---
title: "Configuration File (.cfg)"
---

A plaintext configuration file.

# Structure

The file is plaintext, which is easy to parse. The file is split into categories, which are surrounded by `<` and `>`. Within those categories are key-value pairs which are separated by tab characters (`\t`).

```cfg
<FINAL FANTASY XIV Boot Config File>

<Version>
Version	3
Language	1
Region	2
```

Keep in mind that categories can exist without any key-value pairs, as shown above.

# Alternative Implementations

* [Physis (Rust)](https://git.sr.ht/~redstrate/physis/tree/main/item/src/cfg.rs)
