---
title: "Launching Dalamud"
---

If you're developing your own launcher, you might be interested in integrating Dalamud support. Here's a detailed
walk-through of setting up a proper Dalamud environment.

## Grabbing .NET Runtime

You'll need a .NET environment to actually launch Dalamud, since it's based it uses .NET. It won't try to use your system .NET, and will require to put it into a separate directory.

In order to determine which .NET runtime you need, first check dalamud-distrib using the following URL:

`https://goatcorp.github.io/dalamud-distrib/version`

This will return a JSON containing keys for `RuntimeVersion`. This is the required .NET runtime, which then can be fetched directly from Microsoft:

`https://dotnetcli.azureedge.net/dotnet/Runtime/%1/dotnet-runtime-%1-win-x64.zip`

`https://dotnetcli.azureedge.net/dotnet/WindowsDesktop/%1/windowsdesktop-runtime-%1-win-x64.zip`

You can then extract both zip files into some directory, henceforth called `$RUNTIME_DIR`.

## Grabbing Dalamud

Now you can grab dalamud from dalamud-distrib:

`https://goatcorp.github.io/latest.zip`

You can then extract this zip file, and the resulting directory will be referred to as `$DALAMUD_DIR`.

**Note:** You can find out the version of Dalamud you have installed by reading the dependencies file, located under `$DALAMUD_DIR/Dalamud.deps.json`.

## Grabbing Dalamud assets

These are not grabbed by Dalamud (for some reason) and instead you must download these yourself. These include fonts, icons and other things which are required for regular operation.

You can find the asset manifest at:

`https://goatcorp.github.io/DalamudAssets/asset.json`

This is simply a long JSON describing where to find the assets, the current version and where to put them. The directory you put
assets in will be called `$DALAMUD_ASSET_DIR`.

## Grabbing nativelauncher

**Note:** Nativelauncher is no longer needed, as it seems Dalamud can host the game process on it's own. This section is kept for historical purposes as Astra will eventually move away from using it.

Now you need an ACL bypass for Dalamud to actually gain privileges in order to read game memory. Using one of these programs is out of scope for this tutorial, but I recommend my own [nativelauncher](https://git.sr.ht/~redstrate/nativelauncher) as it's a standalone Windows binary.

You can grab the latest version from this URL:

`https://xiv.zone/distrib/nativelauncher/version`

And using this URL you can grab the latest binary:

`https://xiv.zone/distrib/nativelauncher/NativeLauncher.exe`

Please check the [README](https://git.sr.ht/~redstrate/nativelauncher/#usage) on usage.

## Launching Dalamud

Now with all of your ugly ducklings in a row, you can begin launching Dalamud! First, please make
sure these environment variables are set **on the game process and all relevant processes and children**. Please double check these, as Dalamud may silently fail without them.

* `DALAMUD_RUNTIME` should be set to your`$RUNTIME_DIR`.
* If you are in Wine, please set `XL_WINEONLINUX`.

1. Launch the game using some sort of ACL bypass (nativelauncher, etc). Then continue once you recieve the PID of the game.
2. Launch `$DALAMUD_DIR/Dalamud.Injector.exe`.
    * You may be able to launch the injector without any additional configuration, but it's recommended to set these.
    * Arguments:
        1. The PID of the game process.
        2. Base64-encoding of a JSON dictionary which may contain these options:
            * WorkingDirectory - overrides the working directory for Dalamud
            * ConfigurationPath - the file path of `dalamudConfig.json`
            * PluginDirectory - the directory for the `installedPlugins` folder
            * AssetDirectory - should point to `$DALAMUD_ASSET_DIR`.
            * DefaultPluginDirectory - the default directory for the `devPlugin` folder.
            * DelayinitializeMs - how much Dalamud should wait before injection
            * GameVersion - the (base) game version string
            * Language - language code of the game
            * OptOutMbCollection - whether or not to opt out from anonymous marketboard statistics collection
3. If successful, the game should freeze for a few momements and Dalamud will successfully inject!
