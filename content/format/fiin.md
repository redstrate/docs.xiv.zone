# .fiin

I don't know the actual purpose of this file, but it was a fun reverse-engineering exercise. These are usually listed like `fileinfo.fiin` (like in `/boot`) and start with a header like this:

```
struct FileInfoHeader {
    char magic[9];
    uint8_t dummy1[16];
    uint8_t unknown; // version? always seems to be 4
    uint8_t dummy2[2];
    uint8_t unknown1;
    uint8_t unknown2;
    uint8_t dummy[994];
};
```

`magic` is always `FileInfo`.

To get the number of entries, calculate it like so:

```
int overflow = info.header.unknown2;
int extra = overflow * 256;
int first = info.header.unknown1 / 96;
int first2 = extra / 96;
int actualEntries = first + first2 + 1;
```
_(Note: I have no idea if this is actually necessary, and it could just be a unsigned int or something)_

Then each entry is located right after the header, and is structured as so:

```
struct FileInfoEntry {
    uint8_t dummy[8]; // length of file name in some format
    char str[64]; // simple \0 encoded string
    uint8_t dummy2[24]; // sha1
};
```

This file appears to have SHA1 hashes, but for what purpose I do not know.

## Alternative Implementations

* [libxiv (C++)](https://git.sr.ht/~redstrate/libxiv/tree/main/item/src/fiinparser.cpp)
