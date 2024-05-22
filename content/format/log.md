---
title: "Chat Log (.log)"
---

{{< note "This documentation is incomplete." >}}

A binary store of recent chat logs. These are usually found in the character folder, e.g. "FFXIV_CHR<number>/log/00000000.log"

## Reading

At the beginning of the file is a header with this content:

```c++
struct ChatLogHeader {
    uint32_t contentSize;
    uint32_t fileSize;

    uint32_t offsets[fileSize - contentSize];
};
```

The content of the log begins at `(8 + fileSize * 4)`. The number of elements in `offsets` is also the number of messages in this log.

To read the messages, start reading at the offset described above. After seeking, read this short header:

```c++
enum EventFilter : uint8_t {
    SystemMessages = 3,
    Unknown = 20,
    ProgressionMessage = 64,
    NPCBattle = 41,
    Unknown2 = 57,
    Unknown7 = 29,
    Unknown3 = 59,
    EnemyBattle = 170,
}

enum EventChannel : uint8_t {
    System = 0,
    ServerAnnouncement = 3,
    Unknown1 = 50,
    Unknown7 = 29,
    Others = 32,
    Unknown5 = 41,
    NPCEnemy = 51,
    NPCFriendly = 59,
    Unknown4 = 64,
    Unknown6 = 170,
}

struct ChatLogEntry {
    uint32_t timestamp;
    EventFilter filter;
    EventChannel channel;
    uint32_t _garbage;
};
```

Then the string is ASCII(?) from the end of header to the element in `offsets`. The loop might look something like this:

```c++
uint32_t contentOffset = (8 + fileSize * 4);
seek(contentOffset);
for (uint32_t offset : offsets) {
    readChatLogEntry();
    message = read(cursorPos + offset);
    seek(contentOffset + offset); // ensure we always end up at the right place.
}
```

# Alternative Implementations

* [Physis (Rust)](https://github.com/redstrate/physis/blob/main/src/log.rs)
