---
title: "Excel Header (.exh)"
---

{{< info "'Excel' here has nothing to do with Microsoft's Excel." >}}
{{< note "This documentation is incomplete." >}}

I recommend reading the ["Excel Header" section](https://xiv.dev/game-data/file-formats/excel#excel-header-.exh) on xiv.dev's Excel docs.

This is a schema file describing the column and row layout of an Excel sheet (such as `Achievement`). You **are required to parse** this before reading `.exd` files, as it contains important information on building a path and reading columns.

# Alternative Implementations

* [Lumina (C#)](https://github.com/NotAdam/Lumina/blob/master/src/Lumina/Data/Files/Excel/ExcelHeaderFile.cs)
* [Physis (Rust)](https://github.com/redstrate/physis/blob/main/src/exh.rs)
