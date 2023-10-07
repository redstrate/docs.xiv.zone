---
title: "Character Creation Data (.dat)"
---

{{< note "This documentation is incomplete." >}}

Saved data from the character creation screen.

# Structure

There seems to be a few different versions of this format. Below is version 4:

## Version 4

| Offset | Type | Purpose |
| ------ | ----- | ------ |
| 0x00    | 32-bit integer | Magic, should be 0x2013FF14. |
| 0x04    | 32-bit integer | The version of the file, in this case "4". |
| 0x08    | 32-bit integer | Checksum of the data. |
| 0x0C    | 32-bit integer | Unknown. |
| 0x0D    | 8-bit unsigned integer | The character's race. |
| 0x0E    | 8-bit unsigned integer | The character's gender. |
| 0x0F    | 8-bit unsigned integer | The character's age. |
| 0x10    | 8-bit unsigned integer | The character's age. 1 is "Normal", 3 is "Old" and 4 is "Young". |
| 0x11    | 8-bit unsigned integer | The character's height from 0-255. |
| 0x12    | 8-bit unsigned integer | The character's subrace. |
| 0x13    | 8-bit unsigned integer | The character's head. |
| 0x14    | 8-bit unsigned integer | The character's hair. |
| 0x15    | 8-bit unsigned integer | If the character has hair highlights. |
| 0x16    | 8-bit unsigned integer | The character's skin tone. |
| 0x17    | 8-bit unsigned integer | The character's right eye color. |
| 0x18    | 8-bit unsigned integer | The character's hair color. |
| 0x19    | 8-bit unsigned integer | The character's hair highlights color. |
| 0x1A    | 8-bit unsigned integer | The character's facial features. |
| 0x1B    | 8-bit unsigned integer | If the character has limbal eyes. |
| 0x1C    | 8-bit unsigned integer | The character's eyebrows. |
| 0x1D    | 8-bit unsigned integer | The character's left eye color. |
| 0x1E    | 8-bit unsigned integer | The character's eyes. |
| 0x1F    | 8-bit unsigned integer | The character's nose. |
| 0x20    | 8-bit unsigned integer | The character's jaw. |
| 0x21    | 8-bit unsigned integer | The character's mouth. |
| 0x22    | 8-bit unsigned integer | The character's lip/tone/fur/pattern. |
| 0x23    | 8-bit unsigned integer | The character's tail. |
| 0x24    | 8-bit unsigned integer | The character's face paint. |
| 0x25    | 8-bit unsigned integer | The character's bust size from 0-255. |
| 0x26    | 8-bit unsigned integer | The character's face paint color. |
| 0x27    | 8-bit unsigned integer | The character's voice. |
| 0x28    | 8-bit unsigned integer | Unknown. |
| 0x29    | 32-bit unsigned integer | Timestamp? |

# Alternative Implementations

* [Physis (Rust)](https://git.sr.ht/~redstrate/physis/tree/main/item/src/chardat.rs)
