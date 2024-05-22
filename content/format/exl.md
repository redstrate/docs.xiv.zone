---
title: "Excel List (.exl)"
---

{{< info "'Excel' here has nothing to do with Microsoft's Excel." >}}

I recommend reading the ["Excel List" section](https://xiv.dev/game-data/file-formats/excel#excel-list-.exl) on xiv.dev's Excel docs.

Describes Excel sheets that exist in the game data. A good example is is `exd/rool.exl` which contains many references to the game data. It's a text file containing a list of comma-separated strings, where each line is separated by a newline:

```txt
EXLT,2
Achievement,209
Action,4
content/DeepDungeon2Achievement,-1
content/DeepDungeon2Gacha,-1
```

With an Excel List parsed, you can then build a path to a [Excel header or .exh](format/exh). To do so, simply move all characters to lowercase and append `.exh` at the end:

`Achievement,209` -> `exh/achievement.exh`

# Alternative Implementations

* [Lumina (C#)](https://github.com/NotAdam/Lumina/blob/master/src/Lumina/Data/Files/Excel/ExcelListFile.cs)
* [Physis (Rust)](https://github.com/redstrate/physis/blob/main/src/exl.rs)
