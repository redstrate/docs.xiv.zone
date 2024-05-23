---
title: "PlayStation 3 Client"
---

In [mid-2017, Square Enix officially ended support for the PlayStation 3 version](https://na.finalfantasyxiv.com/lodestone/topics/detail/a8db3b52eae5f11037a16ef7a637368a2ec5ed08). This guide covers how to crack open and mess with the game files, assuming you have a legitimate retail copy. Unfortunately reverse engineering PS3 games is slowly becoming a lost art, so here's a quick guide to get started!

# Obtaining a copy

The PS3 version of A Realm Reborn was printed on disc, so it's still [possible to buy a retail copy](https://www.amazon.com/Final-Fantasy-XIV-Realm-Reborn-Playstation/dp/B002BRZ79E) even with digital downloads being defunct. I will assume you have one and have already dumped an ISO or some other kind of mountable backup.

# Dumping the contents of the disc

Inside of the disc is a big folder structure, but we can ignore most of it as we're not interested in installing this on a real PS3. Refer to the diagram below to find the `INSTALL.PKG` which contains the game files:

```shell
/ PS3_GAME
   / PKGDIR
       / PKG00
          > INSTALL.PKG <
```

Move this file to another location, as that's all we need from the disc.

# Dumping the .PKG file

This is a ["software update package" or PKG](https://psdevwiki.com/ps3/PKG_files) used for installing the game on a PS3. These are encrypted and compressed, but there is a software tool called `pkgrip` which we will use to extract it's contents. Clone and build the tool from [here](https://github.com/redstrate/pkgrip) and then run it:

```shell
$ pkgrip INSTALL.PKG
...
```

This process should only take a few minutes and dump the file tree into your current directory.

Once the contents of the PKG file are dumped, you'll see a very similar looking folder structure. There are a few excpetions:
* The [Bink video files](https://www.radgametools.com/bnkmain.htm) under `game/movie/ffxiv` are "pam" files. No idea what those are yet.
* The `dat0` and `index` files are suffixed with `ps3` instead of `win32`, of course.
	* Curiously, there are `sdat` files as well. Maybe these are encrypted?
* There are no `.exe`s because of course PS3 isn't Win32. See below for peeking into these.

# Decrypting the executable files

Executables on the PS3 are [signed and encrypted](https://www.psdevwiki.com/ps3/SELF_-_SPRX) so you will need a tool like the [TrueAncestor SELF Resigner](https://www.psx-place.com/resources/trueancestor-self-resigner-by-jjkkyu.33/)[^1] or scetool. It cannot be bruteforced by unself, so don't even try. If you need keys for scetool, the SELF Resigner has provided the correct keys to decrypt the game's executables.

In either tool you simply put in the `.self` files and then they pop out as proper `.elf` files.

## Ghidra

To be able to actually decompile anything useful in [Ghidra](https://ghidra-sre.org/), make sure to select the `PowerISA-Altivec-64-32addr` language when asked (it's not recommended usually.) Make sure it's the Big Endian version, too.

[^1]: Can also be found on [archive.org](https://archive.org/details/true-ancestor-self-resigner-v-1.98).
