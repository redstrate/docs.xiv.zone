---
title: "Logging into Sapphire Servers"
---

[Sapphire](https://github.com/SapphireServer/Sapphire/) has a much, much easier login process than [the official servers]({{< ref "concept/logging-in-official" >}}), which only consist of one or two requests.

# Logging in

**POST** `http(s)://{sapphire_lobby_url}/sapphire-api/lobby/login`

You'll need to construct a JSON body as follows:

```
{
    "username": {username},
    "pass": {pass}
}
```

Of course, `{username}` and `{password}` is the user account credentials.

The response is also JSON, and if it's not empty (which indicates a login error) it will be constructed like this:

```
{
    "sId": {SID},
    "lobbyHost": {lobby_host},
    "frontierHost": {frontier_host}
}
```

Now you can launch the game! See [ffxiv.exe](executable/ffxiv) for more arguments. For a quick rundown:
* Set `DEV.TestSID` to `{SID}`.
* Set `DEV.MaxEntitledExpansionID` to your desired expansion level.
* Set `SYS.Region` to 3.
* Set `DEV.GMServerHost` to `{frontier_host}`.
* Set `DEV.LobbyHost01`...`DEV.LobbyHost09` to `{lobby_host}`.
* Set `DEV.LobbyPort01`...`DEV.LobbyPort09` to your Sapphire lobby's port - usually 54994.

# Registering an account

**POST** `http(s)://{sapphire_lobby_url}/sapphire-api/lobby/createAccount`

This request is identical to the one used for logging in, so refer to the section above for details.
