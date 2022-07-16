---
title: "EXL"
---

**Note:** To prevent confusion, "Excel" as described has nothing to do with Microsoft's Excel.

I recommend reading the ["Excel List" section](https://xiv.dev/game-data/file-formats/excel#excel-list-.exl) on xiv.dev's Excel docs.

This is simply a text file containing a list of comma-separated strings, where each line is separated by a newline:

```
EXLT,2
Achievement,209
Action,4
content/DeepDungeon2Achievement,-1
content/DeepDungeon2Gacha,-1
```

This describes Excel sheets that exist in the game data, hence why it's called dubbed an "Excel List". The easiest one to parse is `exd/rool.exl` as it contains a bunch of Excel sheets to test a parser on.

With an Excel List parsed, you can then build a path to a [Excel header or .exh](format/exh). To do so, simply move all characters to lowercase and append `.exh` at the end:

`Achievement,209` -> `exh/achievement.exh`

## Alternative Implementations

* [Lumina (C#)](https://github.com/NotAdam/Lumina/blob/master/src/Lumina/Data/Files/Excel/ExcelListFile.cs)
* [libxiv (C++)](https://git.sr.ht/~redstrate/libxiv/tree/main/item/src/exlparser.cpp)
