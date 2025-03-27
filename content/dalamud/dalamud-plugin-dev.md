---
title: "Building Dalamud plugins on Linux"
---

It's trivial to develop Dalamud plguins on Linux since they moved to .NET Core!

# The .NET SDK

You need the .NET SDK of course, which is already in many package managers:

* Fedora Linux: `dotnet`
* Arch Linux: `dotnet-sdk`
* Gentoo Linux: `dotnet-sdk` or `dotnet-sdk-bin`

Currently Dalamud requires .NET 9.0 as of API 12.

# devPlugin path

Remember that when entering the dev plugin path in the Dalamud settings, to prepend it with `Z:` and take care of your slashes so they make sense under Wine.

