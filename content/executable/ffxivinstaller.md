---
title: "Installer (ffxivinstaller.exe)"
---

This is not a standard InstallShield installer (at least to my knowledge) but seems to a self-extracting executable and then some form of InstallShield executable.

If you only care about the .cab files (which can then be read with your usual installshield libraries/tools like unshield) then they are contained right in the executable, uncompressed.

To find them, simply find the needle string "Disk1\\{FileName}" where FileName is the cab filename. They are as follows:

* data1.cab
* data1.hdr (to my knowledge, this is some kind of "file index" for installshield installers)
* data2.cab

They are simply put right next to each other in the executable, so if you follow that order you'll find each of them quite easily.

# Alternative Implementations

* [physis (Rust)](https://git.sr.ht/~redstrate/physis/tree/main/item/src/installer.rs)
* [libxiv (C++)](https://git.sr.ht/~redstrate/libxiv/tree/main/src/installextract.cpp)
