---
title: "Equipment"
---

{{< note "This documentation is incomplete nd may be missing information for weapons, demihumans, other races and slot types." >}}

This is useful for people implementing similar TexTools or FFXIV Explorer functionality, and it's actually trivial to do so. Before you can do so, you must be able to read [Excel data sheets]({{< ref "format/exd" >}}).

# Read item data

The Excel sheet you're interested is called `item` and since it also contains localized names make sure to choose the relevant language sheet. Once you have done so, you're interested in a couple of columns (tested as of 6.1):

* Column 9 (String)
    * This is the name of the item.
* Column 17 (Unsigned 64-bit Integer)
    * This is the slot id, explained below.
* Column 47 (Unsigned 64-bit Integer)
    * This is the primary model data, explained below.
* Column 48 (Unsigned 64-bit Integer)
    * This is the secondary model data, explained below.

# Reading the slot id

You'll get an integer from the slot item column, and this corresponds to a specific slot:

| Integer | Slot    |
|---------|---------|
| 3       | Head    |
| 4       | Body    |
| 5       | Hands   |
| 7       | Legs    |
| 8       | Feet    |
| 9       | Earring |
| 10      | Neck    |
| 11      | Wrists  |
| 12      | Rings   |

# Reading the model data

There are two separate integers, primary and secondary. Right now, we're only interested in the first 2 bytes of the primary integer - this
is your **primary ID**.

# Grabbing the equipment path

`chara/equipment/e{model_id:04d}/model/c{race_id:04d}e{model_id:04d}_{slot}.mdl`

`{race_id}` is the race-specific equipment you want.
`{model_id}` is the **primary model id**.

**Note:** `:04d` means that it must be padded with 4 zeroes.
