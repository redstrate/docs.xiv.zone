---
title: "Launcher (ffxivlauncher.exe)"
---

{{< note "This documentation is incomplete." >}}

This is the program that logins into the official servers and launches the game.

# History

Since FFXIV has been around for a long time, it's went through several launcher redesigns.

## 1.x

This is the old launcher designed used for 1.x versions, before A Realm Reborn. This is [a recreation by Ioncannon](http://ffxivclassic.fragmenterworks.com/), as I can't find a screenshot of the original login page anywhere online.

![The old launcher design](ffxivlauncher-10.png)

## 2.x

The old launcher has been there since launch, but was on the path to be retired since the new launcher design was used.

![The old launcher design](ffxivlauncher-old.png)

## 6.5+

It seems as of Patch 6.5, the old launcher can no longer be used and all users must use the new design.

![The new launcher design](ffxivlauncher-new.png)

# Internals

The launcher is actually a website, and the launcher is served by the [Frontier server]({{< ref "/server/frontier" >}}) on URLs such as https://frontier.ffxiv.com/version_4_0_win/index.html?1559390056785.

In order for the launcher to actually launch anything useful, it uses JavaScript callbacks into native code.

For details on how logging into the Square Enix servers work, see the [relevant page on this concept]({{< ref "/concept/logging-in-official" >}}).

# Arguments

{{< note "Like the other executables, it requires you to pass these using the [SqexArg](concept/sqexarg) format." >}}

- `ExecuteArg` (**Required**)
    - This is a strange argument. This appears to be a random gibberish of numbers:

    `/T =1000000 /ExecuteArg =14431503 /UserPath =C:/users/yourname/Documents/My  Games/FINAL  FANTASY  XIV  -  A  Realm  Reborn`

    In reality, decompiling the launcher reveals that they are sprintf'ing in this format:

    `%02d%02d%02d%02d`

    - 1st arg - current month + 1
    - 2nd arg - current day
    - 3rd arg - current hour
    - 4th arg - current minute

- `UserPath`
    - Your usual path to your FFXIV data folder in `My Documents`.

# Alternative Implementations

* [XIVQuickLauncher (C#)](https://github.com/goatcorp/FFXIVQuickLauncher)
* [XIVCore (C#)](https://github.com/goatcorp/XIVLauncher.Core)
* [XIV-on-Mac (Swift)](https://github.com/marzent/XIV-on-Mac)
* [microlaunch (Rust)](https://github.com/eorzeatools/microlaunch)
* [L4-cpp (C++)](https://github.com/WorkingRobot/L4-cpp)
* [Astra (C++)](https://github.com/redstrate/astra/)
