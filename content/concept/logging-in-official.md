---
title: "Logging into Official Servers"
---

**Note:** This article currently only covers logging in via non-Steam Square Enix accounts.

Logging into the official FFXIV servers is actually very simple, and all you need is the ability to send/receive HTTP requests, create JSON responses and read some files off of the disk.

You'll notice below each HTTP request is a series of bullet points. These are HTTP request fields that **must** be filled. This is not a mere suggestion, as we want to closely emulate the official launcher as possible, else you will get nonsensical errors and things won't work.

You'll also notice the variable `{unique_id}` used in some of the User Agents. This is a unique id used by the official launcher, for an unknown purpose. However, any sort of unique ID will work.


## Checking the Gate Status

First of all, you want to check if you can _even_ log in the first place. This is extremely important, as the official launcher refuses to "pass the gate" so to speak. If you allow your launcher to bypass this, you're at your own risk **as Square Enix does not expect legitimate users to enter under maintenance servers**.

**GET** `https://frontier.ffxiv.com/worldStatus/gate_status.json`

The response is a simple JSON as follows:

```
{
    "status": 1
}
```

If the `status` is 1, the gate is open and you're free to log in. Any other value should indicate that you should not attempt to log in, the gate is "closed".

## Boot Update Check

You also need to ensure that the boot components of the game are properly updated.

**Note:** This is not a typo, and this endpoint is actually in plaintext HTTP. Seriously.

**GET** `http://patch-bootver.ffxiv.com/http/win32/ffxivneo_release_boot/{boot_version}`
* User Agent: `FFXIV PATCH CLIENT` (macOS: `FFXIV-MAC PATCH CLIENT`)
* Host: `patch-bootver.ffxiv.com`

`{boot_version}` is the version stored in `$GAME_DIR/boot/boot.ver`.

If you receive an empty response, then you don't need to update any of your boot components. However if your boot components are out of date, you will receive a list of patches to
update.

## Getting _STORED_

The next prerequisite we need is the `_STORED_` value. This is pretty simple though.

**GET** `https://ffxiv-login.square-enix.com/oauth/ffxivarr/login/top`
* Query items:
    * `lng`: "en" (even if the client isn't actually English.)
    * `rgn`: 3 (even if this isn't the client's region.)
    * `isft`: 1 if attempting to log in with a free trial account, otherwise 0.
    * `cssmode`: 1
    * `isnew`: 1
    * `launchver`: 3
    * `issteam`: 1 is attempting to log in with a Steam service account.
    * `session_ticket`: The session ticket acquired from the Steamworks API.
    * `ticket_size`: The session ticket size.
* User Agent: `SQEXAuthor/2.0.0(Windows 6.2; ja-jp; {unique_id})` (macOS: `macSQEXAuthor/2.0.0(MacOSX; ja-jp)`)
* Accept: `image/gif, image/jpeg, image/pjpeg, application/x-ms-application, application/xaml+xml, application/x-ms-xbap, */*`
* Accept-Encoding: `gzip, deflate`
* Accept-Language: `en-us`

The response is actually fully formed HTML, most likely better suited for the real launcher where it's a web browser. However, if you have regex available, you can query the variables needed for later.

**Note:** If you're logging in with a Steam service account, you can find your username using `<input name=""sqexid"" type=""hidden"" value=""(?<sqexid>.*)""\/>`.

To get the `_STORED_` value, use `\t<\s*input .* name="_STORED_" value="(?<stored>.*)">` and use the second captured variable. You also need to the store the full URL of this request (including all of the queries) for use in the next request.

If you get an error during this response, it may indicate that the Square Enix servers are down for maintenance. Make sure to check the gate status!

## Logging in

Now you have all of the needed variables to actually attempt a log in!

**POST** `https://ffxiv-login.square-enix.com/oauth/ffxivarr/login/login.send`
* Query items:
    * `_STORED_`: Your `_STORED_` value you just fetched.
    * `sqexid`: The account username.
    * `password`: The account password.
    * `otppw`: The account one-time password, if needed. This may be left blank of course.
* User Agent: `SQEXAuthor/2.0.0(Windows 6.2; ja-jp; {unique_id})` (macOS: `macSQEXAuthor/2.0.0(MacOSX; ja-jp)`)
* Accept: `image/gif, image/jpeg, image/pjpeg, application/x-ms-application, application/xaml+xml, application/x-ms-xbap, */*`
* Accept-Encoding: `gzip, deflate`
* Accept-Language: `en-us`
* Content-Type: `application/x-www-form-urlencoded`
* Referer: The previous request's URL.
* Cache-Control: `no-cache`

Just like the previous request, you will get a pretty disgusting HTML response. You will need some way to parse this data, but we have some regex queries to get you started.

The response may have multiple parts depending on how you log in, and if the login was successful. Start with this: `window.external.user\("login=auth,ok,(?<launchParams>.*)\);` to get the launch parameters.

If you do not manage to get a match, this means there is a general account error. Luckily, Square Enix actually gives us an error message! Match this regex query now: `window.external.user\("login=auth,ng,err,(?<launchParams>.*)\);`. The second capture has a comma-separated string that contains the relevant error message such as "Account locked due to too many attempts."

However if you do get a match, that's good but there's still quite a bit of parsing to do. First you'll want to split the second captured group since it's a comma-separated string. There are multiple parts which we'll refer to by name:

parts[1] is `{SID}`

parts[3] is `{terms}`

parts[5] is `{region}`

parts[9] is `{playable}`

parts[13] is `{max_expansion}`

First you'll want to check if the account is even playable, which of course is checking to see if `{playable}` is 1. This may indicate billing or license issues with that account. You'll want to check if `{terms}` is 1 as well, which indicates that there's a terms of service agreement the account must sign.

The `{SID}`, `{region}` and `{max_expansion}` will be needed later, so store these variables.

## Calculating the boot hash

Before we can register the session, we must first calculate the hashes of everything in the boot directory. Why you ask? I guess this is Square Enix's idea of security.

Here's the file list we need to start with:

* fxivboot.exe
* ffxivboot64.exe
* ffxivlauncher.exe
* ffxivlauncher64.exe
* ffxivupdater.exe
* ffxivupdater64.exe

For each and every file in that list, we use to build a string like so:

```
{file_name}/{file_hash},...
```

Please note that it's **comma separated** and there is no newlines. The file hash is simply the SHA1 of the file (yes, really, SHA1) and it's formatted as follows:

```
{file_size}/{file_sha1}
```

You'll want to store this completed hash as `{boot_hash}` for the next step.

## Registering a Session

Now that we got an SID, you may expect that we can now log into the game! Well you'd be wrong, as we still have to register a session with the lobby server. If you attempt to launch the client with the `{SID}` you got, the lobby server will disconnect you as soon as you log in. Square Enix expects the launcher to pass it's "security check" next, and this request will also check for if any game updates are required too.

**Note:** `{game_version}` is referring to the version stored in `$GAME_DIR/game/ffxivgame.ver`.

**POST** `https://patch-gamever.ffxiv.com/http/win32/ffxivneo_release_game/{game_version}/{SID}`
* X-Hash-Check: `enabled`
* User Agent: `FFXIV PATCH CLIENT`
* Content-Type: `application/x-www-form-urlencoded`

Before you can **POST** this request, you need to build a report of all of your installed game versions as well as some hashes. This is simply a string in the body of the HTTP request.

The string is built as follows:

```
{boot_version}={boot_hash}\n
ex1\t{ex1_version}\n
...
```

Please note that the client must report **all** of it's installed expansions. The base game version is already reported in the request URL itself, so you should start at "ex1". Each entry in this body is seperated by newlines, except for the last entry. Yes, the `\t` in the body is referring to the tab character.

Once you send this request, there may or may not be a response body. First you'll want to check for the response header called `X-Patch-Unique-Id`, if this found then you've actually successfully registered a session! If this is missing, you may have triggered the anti-tamper check, or the game requires an update.

The `{true_SID}` is now the value of the `X-Patch-Unique-ID` field. Congratulations, you now logged into the game!

## Launching the game

Now you can launch the game! See [ffxiv.exe](executable/ffxiv) for more information. For a quick rundown:
* Set `DEV.TestSID` to `{true_SID}`.
* Set `DEV.MaxEntitledExpansionID` to `{max_expansion}`.
* Set `SYS.Region` to `{region}`.
