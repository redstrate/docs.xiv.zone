---
title: "Packets"
---

Communication between the [client]({{< ref "ffxiv" >}}) and Servers happen with custom, binary packet structures sent over [TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol).

# Packets

Each packet begins with a header, that is always the same size and is never encrypted or compressed:

```rust
struct PacketHeader {
    unk1: u64, /// Unknown value
    unk2: u64, /// Another unknown value
    timestamp: u64, /// Milliseconds since UNIX epoch 
    size: u32, /// Total size of the packet *INCLUDING* this header
    connection_type: ConnectionType, /// The connection this happened on
    segment_count: u16, /// How many segments follow this header
    unk3: u8, /// Yet another unknown value
    compression_type: CompressionType, /// The type of compression used for segment data
    unk4: u16, /// Whoop, more unknowns
    uncompressed_size: u32, /// If compressed, the size of the data when uncompressed. Otherwise, always 0.
}
```
