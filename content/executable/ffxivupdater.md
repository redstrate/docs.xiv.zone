---
title: "Updater (ffxivupdater.exe)"
---

{{< note "This documentation is incomplete." >}}

This is the program that actually processes the [patch files]({{< ref "format/patch" >}}) and applies them to the game or boot data.

# Arguments

{{< note "Just like the other executables, it requires you to pass these using the [SqexArg](concept/sqexarg) format." >}}

- BootVersion
    - The version of the boot component.
- GameVersion
    - The version of the game component, however I'm curious as to the purpose of this variable. Is the patcher itself fetching the patches required for the provided game version?
- CallerWindow
    - This seems to be the HWND which it sends messages to. Passing a HWND that is setup to receive messages, it appears to yield a 0x74 message (OpenWindow I believe) which means this is the most likely case. More on the IPC below.
- IsSteam
    - Obviously, to check if this is the Steam version. I have not reversed the game arguments of the Steam version yet.
- NextExe
    - I'm not entirely sure what the purpose of this is yet. It makes no sense for the updater to call the game itself, I'm pretty sure this is used for "patch chaining" but it's
    also set for regular game patches. For example, when updating the game through the launcher it points to ffxiv.exe. Note that it is not ffxiv_dx11.exe, which means this is
    probably unused in the retail launcher.
- ShowMode
    - This is the most interesting parameter, more testing is needed. There is multiple values here, and some of them correspond to known launcher behavior:
    - 1: This seems to be some sort of standalone updater window that I've never seen before in retail. Is this a leftover from a older version of the game? For example, it looks for "LauncherPatchInstall.list" (I can't seem to recreate this file). I have not gotten it to read from a "GamePatchInstall.list" either, however there is probably some other parameter to trigger this change. This "list" format is also unknown.
    - 2: This has no user-visible window, and is the "default mode" when launched properly through ffxivlauncher.exe. It's communicating through regular Win32 IPC I believe, back to the launcher where the launcher updates it's own window.
    - 3: I haven't gotten this mode to work, but on the standalone updater window it mentions "repairing game files". I believe this is what's used by the "repair game files" button in the launcher, but I've never used it before nor do I know it's actual purpose (just checking hashes?).
- UserPath
    - This is the usual UserPath arugment, pointing to your FFXIV-ARR Documents directory.

# Processes

During update execution, the [launcher]({{< ref "executable/ffxivlauncher" >}}) copies the updater executable into your `UserPath/downloads` directory, where it is then ran. I'm assuming this is to work around a Windows limitation where you can't update the executable on disk, so it has to be ran from a location where it could "update" itself.

## ShowMode 2

This is the regular retail patching mode, and it runs ffxivupdater64.exe in a hidden window that's just there for message processing. I'm not sure yet if ffxivupdater.exe is the one actually downloading the patch files yet. The launcher just reflects ffxivupdater's progress, and passes it along to the web form in the form of a json callback. You can set a breakpoint at 0x183278 (tested on the launcher ver 3/20/2022) and see that it first hits that area when updating. There is three seperate printf strings, which I'm guessing is the three "modes" of patch progress:

| Offset | String Data
| ------ | ---------- |
| 1400e6df0	| {version:"%s",remaintime:"%s",progress:%6.2f}	u"{version:\"%s\",remaintime:\"%s\",progress:%6.2f}"
| 1400e75a0	| {version:"%s",downloadsize:"%s",remaintime:"%s",speed:"%s",progress:%6.2f}
| 1400e76c0	| {version:"%s",remaintime:"%s",speed:"%S",progress:%6.2lf}

_(The offsets are tested on 3/20/2022)_
The first one appears very minimal but might be the one used when it's not downloading/installing any patches yet, and just gathering information.
The second one appears to be the regular "downloading" patch mode, considering it says "downloadsize" right there.
The last one would appear to be when it's actually applying the patches, as it has "remaintime" as well as "speed".

## IPC

It looks like this communicates exclusively through Win32 IPC (SendMessage). I haven't deciphered all of the messages yet, but here is a few interesting ones I've seen used:

* 0x7fc

  The format is `{version:\"%s\",ID:%d}`. I'm guessing this means "install this patch", version obviously corresponds to the patch version, and maybe ID is the jumble of alphanumeric characters in the directory names of the ffxivpatch folder?

* 0xbd4 - unknown

* 0x81a - unknown

# Alternative Implementations

* [XIVQuickLauncher (C#)](https://github.com/goatcorp/FFXIVQuickLauncher/blob/master/src/XIVLauncher.Common/Game/Patch)
* [physis (Rust)](https://github.com/redstrate/physis/blob/main/src/patch.rs)
