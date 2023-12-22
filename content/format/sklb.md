---
title: "Skeleton (.sklb)"
---

A Havok skeleton, used for all of the animated characters and objects in the game. FFXIV uses the Havok SDK to do most of the heavy lifting for animation, so there's not much here.

# Reading

The first few bytes are the magic, which should be a `int32_t` that equals `0x736B6C62`. Then, there is a `uint32_t` that describes which version the skeleton is.

This is used if `version` is `0x3132_3030`:

```c++
struct SklbV1 {
    uint16_t unk_offset;
    uint16_t havok_offset;
    uint32_t body_id;
    uint32_t mapper_body_id1;
    uint32_t mapper_body_id2;
    uint32_t mapper_body_id3;
};
```

This is used if the `version` is `0x3133_3030` or `0x3133_3031`:

```c++
struct SklbV2 {
    uint32_t unk_offset;
    uint32_t havok_offset;
    uint32_t _unknown;
    uint32_t body_id;
    uint32_t mapper_body_id1;
    uint32_t mapper_body_id2;
    uint32_t mapper_body_id3;
};
```

The rest of the file is the Havok binary tagfile format which you will probably need the Havok SDK or another method to read. The data starts at `SklbV1::havok_offset` or `SklbV2::havok_offset` and is contiguous until the end of the file.

# Alternative Implementations

None yet.
