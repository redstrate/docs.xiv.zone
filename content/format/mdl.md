---
title: "Model (.mdl)"
---

{{< note "This documentation is incomplete." >}}

Represents a visual model in the game, from furniture to the world, and characters.

# Reading

First read the model header, which contains some information like the data offsets:

```c++
struct ModelFileHeader {
    uint32_t version;
    uint32_t stackSize;
    uint32_t runtimeSize;

    uint16_t vertexDeclarationCount;
    uint16_t materialCount;

    uint32_t vertexOffsets[3];
    uint32_t indexOffsets[3];
    uint32_t vertexBufferSize[3];
    uint32_t indexBufferSize[3];

    uint8_t lodCount;

    uint8_t indexBufferStreamingEnabled;
    uint8_t hasEdgeGeometry;

    uint8_t _unknown1;
};
```

Immediately after this header begins the vertex declarations which describe how vertex data is sequenced and eventually read. These structures define the basis of the vertex declarations:

```c++
enum VertexType : uint8_t {
    Invalid = 0,
    Single3 = 2,
    Single4 = 3,
    UInt = 5,
    ByteFloat4 = 8,
    Half2 = 13,
    Half4 = 14,
};

enum VertexUsage : uint8_t {
    Position = 0,
    BlendWeights = 1,
    BlendIndices = 2,
    Normal = 3,
    UV = 4,
    Tangent = 5,
    BiTangent = 6,
    Color = 7,
};

struct VertexElement {
    uint8_t stream;
    uint8_t offset;
    VertexType vertexType;
    VertexUsage vertexUsage;
    uint8_t usageIndex;

    uint8_t unknown[3];
};
```

For every vertex declaration (the count in `vertexDeclarationCount`) first read a single `VertexElement`. Then keep reading a `VertexElement` (and keeping these in a buffer) until `VertexElement::stream` is `0xFF` (or 255 in decimal.) This implies an "end of stream" and that's the end of that declaration. Before reading the next declaration you need to advance your cursor `17 + 8 - (elements + 1) * 8` where `elements` is the amount of valid `VertexElement`s you just read.

# Alternative Implementations

* [Physis (Rust)](https://github.com/redstrate/physis/blob/main/src/mdl.rs)
