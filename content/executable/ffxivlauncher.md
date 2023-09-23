---
title: "ffxivlauncher.exe"
---

# Arguments

**Note:** Just like the other executables, it requires you to pass these using the [SqexArg](concept/sqexarg) format.

- ExecuteArg
    - This is a strange argument. This appears to be a random gibberish of numbers:

    `/T =1000000 /ExecuteArg =14431503 /UserPath =C:/users/yourname/Documents/My  Games/FINAL  FANTASY  XIV  -  A  Realm  Reborn`

    In reality, decompiling the launcher reveals that they are literally sprintf'ing in this format:

    `%02d%02d%02d%02d`

    - 1st arg - current month + 1
    - 2nd arg - current day
    - 3rd arg - current hour
    - 4th arg - current minute

- UserPath
    - Your usual path to your FFXIV data folder in Documents.


# Alternative Implementations

* [XIVQuickLauncher (C#)](https://github.com/goatcorp/FFXIVQuickLauncher)
* [Astra (C++)](https://sr.ht/~redstrate/astra/)
* [XIV-on-Mac (Swift)](https://github.com/marzent/XIV-on-Mac)
* [microlaunch (Rust)](https://github.com/eorzeatools/microlaunch)
