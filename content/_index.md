This is my collection of everything I know, and that I collected on FFXIV inner workings. This information was previously hosted in my ffxiv-info repository on GitHub, but moved here to it's own website.

Developers, please look at the end of each page for example implementations that I know of. I find it incredibly useful to look at them, especially if I'm stuck on implementing something. If you have a project that you want to add to the list or suggest any kind of edit, don't hesitate to [email me](https://redstrate.com/about) or [fix it yourself](https://git.sr.ht/~redstrate/docs.xiv.zone)!

# Executables

**Note:** These are actually referring to their 64-bit counterparts, e.g. `ffxivboot.exe` is `ffxivboot64.exe`.

## Boot

* [ffxivboot.exe](executable/ffxivboot) - Launcher for the launcher.
* [ffxivupdater.exe](executable/ffxivupdater) - Game patcher.
* [ffxivlauncher.exe](executable/ffxivlauncher) - Boot/game launcher.

## Game

* [ffxiv.exe](executable/ffxiv) - Game executable.

## Other

* [ffxivinstaller.exe](executable/ffxivinstaller) - Retail game client installer.

# Concepts/Techniques

* [Logging into Official Servers](concept/logging-in-official) - Logging into the official game servers.
* [Logging into Sapphire](concept/logging-in-sapphire) - Logging into unofficial Sapphire servers.
* [SqexArg](concept/sqexarg) - Encrypted game arguments (sqexarg).
* [Equipment](concept/equipment) - All about reading equipment data ala TexTools.
* [Dalamud](concept/dalamud) - Launching Dalamud without the help of XIVQuickLauncher.

# File Formats

## Excel

* [.exd](format/exd) - Excel data.
* [.exh](format/exh) - Excel header.
* [.exl](format/exl) - Excel list.

## Graphics

* [.mdl](format/mdl) - Game model.
* [.shpk](format/shpk) - Shader packages.

## SqPack

* [.index/index2](format/sqpack-index) - Game Data Index file.
* [.dat](format/sqpack-dat) - Compressed game data.

## Other

* [.patch](format/patch) - ZiPatch files.
* [.fiin](format/fiin) - File info.

# Credits

This wouldn't be possible without all of the great people who open-source their work, and everyone else in the FFXIV community!

* [xiv.dev](https://xiv.dev/)
* [XIVQuickLauncher](https://github.com/goatcorp/FFXIVQuickLauncher)
* [XIV-on-Mac](https://github.com/marzent/XIV-on-Mac)
* [xivModdingFramework](https://github.com/TexTools/xivModdingFramework)
* [Lumina](https://github.com/NotAdam/Lumina)
* Everyone else who develops FFXIV tools :-)
