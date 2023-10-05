---
title: "Building Dalamud plugins on Linux"
---

Believe it or not, it's actually very easy to develop with Dalamud on Linux since they moved to .NET Core!

For example, in [JetBrain's Rider](https://www.jetbrains.com/rider/) you can open any Dalamud project and have it build out of the box.

## The .NET SDK

You need the .NET SDK of course, which is in many package managers:

* Fedora Linux: `dotnet`
* Arch Linux: `dotnet-sdk`
* Gentoo Linux: `dotnet-sdk` or `dotnet-sdk-bin`

## Fixing DalamudLibPath

Depending on the plugin, it might already have sensible paths to the Dalamud library folder. The [SamplePlugin](https://github.com/goatcorp/SamplePlugin/blob/master/SamplePlugin/SamplePlugin.csproj#L33) is an example of this. If it doesn't, or you don't use XIVQuickLauncher/XIV.Core then you need to manually edit the path. Tweak the `<DalamudLibPath>` folder to the location where your `Dalamud.dll` and files sit, and you'll know when you're successful when .NET stops screaming.

If for some reason your build of Dalamud is not a developer-enabled one, check the [Dalamud release server](https://kamori.goats.dev/Dalamud/Release/VersionInfo?track=) for a download URL.

## The devPlugin path

Remember that when entering the dev plugin path in the Dalamud settings, to prepend it with `Z:` and take care of your slashes so they make sense under Wine.

