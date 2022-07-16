---
title: "SqexArg"
---

I also recommend reading the relevant [xiv.dev page on SqexArg](https://xiv.dev/sqexarg).

## Purpose

This is the "encrypted argument" format used by a lot of FFXIV programs and is used in place of regular plaintext command line arguments. However, this is barely a security measure and just prevents easily snooping stuff like your login token. Despite this, the SqexArg format is well known, reversible and easily breakable.

## Format

When viewing the command line arguments for, say [ffxiv.exe](executable/ffxiv) you will see it's only something like this:

```
//**sqex0003S2_Utl8qdamv3_82SH7Lhtk=S**//
```
_(Yes, I did garble some of the text, so it's not actually decodable :-))_

There are three distinct parts of this string:

```
//**sqex0003S2_Utl8qdamv3_82SH7Lhtk=S**//
           ^^                       ^
    version||                       |
            | base64 string         |
                                    | checksum
```

Let's break them down:

* version
    * From what I've seen, this is always `3`. I'm not sure if there any more meaning behind this, apart from they revised this 3 times.
* base64 string
    * This is your usual base64-encoded string. However, there is a couple of important things to note:
        * Use the URL-safe version of Base64.
        * You may omit the trailing equal.
    * The result is unreadable garbage, but how to encode/decode this will be revealed below.
* checksum
    * This is also covered in a later section, but this is always one character long and located at the end of the string.

## Encryption Algorithm

The resulting bytes when you decode the base64 string is going to Blowfish ECB encrypted.

* However, please note that Square Enix does some weird bitflip endian-encoding nonsense which means your out-of-box Blowfish library might not work. I would highly recommend reading up on some existing implementations to get an idea of what to do:
    * [XIVQuickLauncher (C#)](https://github.com/goatcorp/FFXIVQuickLauncher/blob/master/src/XIVLauncher.Common/Encryption/LegacyBlowfish.cs)
    * [Astra (C++)](https://git.sr.ht/~redstrate/astra/tree/main/item/launcher/core/include/blowfish.h)
    * [XIV-on-Mac (Swift)](https://github.com/marzent/XIV-on-Mac/blob/main/XIV%20on%20Mac/Encryption.swift)
    * Before encrypting or decrypting, ensure the buffer is padded.

**Note:** In the new Steam launcher update, Square Enix has actually switched to a more sane version of Blowfish ECB without their weird changes. Please look at [XIVQuickLauncher for the changes](https://github.com/goatcorp/FFXIVQuickLauncher/blob/master/src/XIVLauncher.Common/Encryption/BlockCipher/Blowfish.cs) required, as I have not tested this yet.

### Key

The key used for encrypting/decrypting the encrypted arguments is just your **system's uptime clock**. All FFXIV executables just call `GetTickCount()`, and theres about ~50 or so ticks of freedom before the game or launcher considers it invalid. There is a specific transformation you need to do in order to fetch a valid key though:

```
unsigned int rawTicks = TickCount();
unsigned int ticks = rawTicks & 0xFFFFFFFFu;
unsigned int key = ticks & 0xFFFF0000u;

char buffer[9] = {};
sprintf(buffer, "%08x", key);
```

To make this easier, here is a couple of platform-specific implementations of `TickCount()`. Thank you Wine for being easily searchable, as this is what Wine is actually doing under the hood to emulate `GetTickCount()`, so these are exact and have been tested on Astra for all platforms.

#### Windows

```
uint32_t TickCount() {
    return GetTickCount();
}
```

#### macOS

```
uint32_t TickCount() {
    struct mach_timebase_info timebase;
    mach_timebase_info(&timebase);

    auto machtime = mach_continuous_time();
    auto numer = uint64_t (timebase.numer);
    auto denom = uint64_t(timebase.denom);
    auto monotonic_time = machtime * numer / denom / 100;
    return monotonic_time / 10000;
}
```

#### Linux

```
uint32_t TickCount() {
    struct timespec ts;

    clock_gettime(CLOCK_MONOTONIC, &ts);

    return (ts.tv_sec * 1000 + ts.tv_nsec / 1000000);
}
```

### Checksum

If you're just interested in decrypting game arguments, this is not essential. This is presumably used as a checksum
when the game checks your encrypted string.

```
static char ChecksumTable[] = {
    'f', 'X', '1', 'p', 'G', 't', 'd', 'S',
    '5', 'C', 'A', 'P', '4', '_', 'V', 'L'
};

static char GetChecksum(unsigned int key) {
    auto value = key & 0x000F0000;
    return ChecksumTable[value >> 16];
}
```

## Decrypting

You can try the [dedicated argcracker](https://sr.ht/~redstrate/novus/#argcracker) in Novus for this purpose. It allows you to easily
crack any SqexArg enabled program assuming you have access to the string.

## Notes

Every instance where SqexArg is used, the first argument is always `T`, where `T` is set to the value of `ticks` (as shown above). I'm not sure what the purpose of this really is, maybe for verifying the checksum?

The arguments (before encoding of course) must be formatted as `" /%1 =%2"`. The extra space is required, even at the beginning of the arguments. Make sure that any spaces in your string is double padded as well.

## Implementations

* [XIVQuickLauncher (C#)](https://github.com/goatcorp/FFXIVQuickLauncher/blob/master/src/XIVLauncher.Common/Encryption/ArgumentBuilder.cs)
* [Astra (C++)](https://git.sr.ht/~redstrate/astra/tree/main/item/launcher/core/include/encryptedarg.h)
* [XIV-on-Mac (Swift)](https://github.com/marzent/XIV-on-Mac/blob/main/XIV%20on%20Mac/Encryption.swift)
