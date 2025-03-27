---
title: "World"
---

This is the main server that communicates the minute-to-minute gameplay.

Unlike other servers, the opcodes for the World server are randomized each patch. This was done starting in Shadowbringers(?)[^1] to prevent the usage of client-side tools like ACT, although this didn't actually change anything.

Communication with the World server is compressed with [Oodle](https://www.radgametools.com/oodle.htm). It was previously compressed with Zlib until Patch 6.3. Compression is optional however, the client happily accepts uncompressed packets.

# Alternative Implementations

* [Sapphire (C++)](https://github.com/SapphireServer/Sapphire/)
* Maelstorm (C#)
* iolite (Rust)
* Kawari (Rust)

[^1]: Alluded to in this [Sapphire Blog post](https://sapphireserver.github.io/dev/2019/12/23/fixing-opcodes.html)
