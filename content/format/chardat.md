---
title: "Character Creation Data (.dat)"
---

{{< note "This documentation is incomplete." >}}

This contains the data you can save and load from the character creator, used not only in the retail client but the benchmark versions too.

# Reading

The structure is very simple, it's only a series of fields.

## Version 4

```c++
struct CharacterData {
    // The version of the character data, the only supported version right now is 4.
    uint32_t version: u32,

    // The checksum of the data fields.
    uint32_t checksum: u32,

    uint32_t _unknown1;

    // The race of the character.
    uint8_t race: Race,

    // The gender of the character.
    uint8_t gender: Gender,

    // The age of the character. Normal = 1, Old = 3, Young = 4.
    uint8_t age: u8,

    // The height of the character.
    uint8_t height: u8,

    // The character's subrace.
    uint8_t subrace: Subrace,

    // The character's selected head.
    uint8_t head: u8,

    // The character's selected hair.
    uint8_t hair: u8,

    // If hair highlights are enabled for this character.
    uint8_t enable_highlights,

    // The character's skin tone.
    uint8_t skin_tone: u8,

    // The character's right eye color.
    uint8_t right_eye_color: u8,

    // The character's hair color.
    uint8_t hair_tone: u8,

    // The color of the hair highlights.
    uint8_t highlights: u8,

    // The selected facial features.
    uint8_t facial_features: u8,

    // If the character has limbal eyes.
    uint8_t limbal_eyes: u8,

    // The character's selected eyebrows.
    uint8_t eyebrows: u8,

    // The character's left eye color.
    uint8_t left_eye_color: u8,

    // The character's selected eyes.
    uint8_t eyes: u8,

    // The character's selected nose.
    uint8_t nose: u8,

    // The character's selected jaw.
    uint8_t jaw: u8,

    // The character's selected mouth.
    uint8_t mouth: u8,

    // The character's selected pattern.
    uint8_t lips_tone_fur_pattern: u8,

    // The character's selected tail.
    uint8_t tail: u8,

    // The character's choice of face paint.
    uint8_t face_paint: u8,

    // The size of the character's bust.
    uint8_t bust: u8,

    // The color of the face paint.
    uint8_t face_paint_color: u8,

    // The character's chosen voice.
    uint8_t voice: u8,

    uint8_t _garbage;

    // The timestamp when the preset was created.
    uint8_t timestamp[4];
};
```

# Alternative Implementations

* [Physis (Rust)](https://git.sr.ht/~redstrate/physis/tree/main/item/src/chardat.rs)
