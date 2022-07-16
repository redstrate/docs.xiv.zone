---
title: "EXH"
---

**Note:** To prevent confusion, "Excel" as described has nothing to do with Microsoft's Excel.

**Note:** This documentation is incomplete.

I recommend reading the ["Excel Header" section](https://xiv.dev/game-data/file-formats/excel#excel-header-.exh) on xiv.dev's Excel docs.

This is a schema file describing the column and row layout of an Excel sheet (such as `Achievement`). You **are required to parse** this before reading `.exd` files, as it contains important information on building a path and reading columns.

## Alternative Implementations

* [Lumina (C#)](https://github.com/NotAdam/Lumina/blob/master/src/Lumina/Data/Files/Excel/ExcelHeaderFile.cs)
* [libxiv (C++)](https://git.sr.ht/~redstrate/libxiv/tree/main/item/src/exhparser.cpp)
