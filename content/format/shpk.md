---
title: "SHPK"
---

**Note**: Resource and scalar parameters are not documented yet.

These are "shader packages" or a collection of vertex and pixel shaders. A good example is _"character.shpk"_ which contains - you guessed it - character shaders.

# Header Structure

All values are in **little-endian**.

| Offset | Type | Purpose |
| ------ | ----- | ------ |
| 0x00    | 4 character ASCII string | Magic, should read "ShPk". |
| 0x04    | Unknown 4 byte. | Unknown. |
| 0x08    | 4 character ASCII string | The format of the shader, e.g. "DX11". |
| 0x0C    | 32-bit integer | File length in bytes. |
| 0x10    | 32-bit integer | Offset in bytes to the shader bytecode. |
| 0x14    | 32-bit integer | Offset in bytes to the parameter list. |
| 0x18    | 32-bit integer | Number of vertex shaders. |
| 0x1C    | 32-bit integer | Number of pixel shaders. |
| 0x20    | 32-bit integer | Number of scalar parameters. |
| 0x24    | 32-bit integer | Number of resource parameters. |

# Reading shader bytecode

Getting the shader bytecode from a shader package is easy, it begins at the shader bytecode offset in the header. Then, move your cursor up 12 bytes (to skip the initial `DXBC` ASCII, and some garbage data).

Then, collect a WORD (4 bytes) at a time and putting them into a buffer. Keep doing this until you hit the next `DXBC` ASCII and you found a complete shader bytecode. Rinse and repeat and you should have `N` shaders where `N = number of vertex shaders + number of pixel shaders`.

The format of this shader bytecode is nothing special, it's DXBC (the bytecode format used by DirectX before DXIL.) If you want to reverse this into something usable, like SPIR-V, HLSL or GLSL then you need to find a decompiler.

# Alternative Implementations

* [SaintCoinach (C#)](https://github.com/xivapi/SaintCoinach/blob/master/SaintCoinach/Graphics/ShPk/ShPkFile.cs)
* [physis (Rust)](https://git.sr.ht/~redstrate/physis/tree/main/item/src/shpk.rs)
