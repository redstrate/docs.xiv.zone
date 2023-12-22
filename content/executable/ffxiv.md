---
title: "Client (ffxiv.exe)"
---

This is the game client executable.

{{< note "There are two separate executables for DirectX 11 and DirectX 9. The DX11 version is named `ffxiv_dx11.exe`. The DX9 version will be removed in a future update." >}}

# Arguments

{{< info "Unlike other executables, passing arguments encrypted with SqexArg is optional for the client. It's recommended that you do so if you're planning to use actual SIDs though." >}}

There a few known arguments that work on the normal game client:

* `DEV.DataPathType`
    * **Guessing** that this controls the asset data type used by the client, this is will always be `1`.
* `DEV.UseSqPack`
    * **Guessing** that this tells the client to try to load data from SqPack files instead of from regular, uncompressed files. Seems to always be `1`.
* `DEV.MaxEntitledExpansionID`
    * This is the max entitled expansion ID that the currently logging in user has access to, you will want to set this from your login response.
* `DEV.TestSID`
    * This is the SID you get from your login response.
* `SYS.Region`
    * Your login region.
* `language`
    * Your login language.
* `ver`
    * The (base) game version string.
* `DEV.GMServerHost`
    * This is the address of the frontier server to connect to. If empty, this will default to the official Square Enix frontier server.
* `DEV.LobbyHost0X`
    * This is the address of the Nth lobby available to the client, these are numbered 0-9. If empty, this will default to the official Square Enix lobbies.
* `DEV.LobbyPort0X`
    * This is the port number of the Nth lobby available to the client, these are numbered 0-9. If empty, this will default to the official Square Enix lobbies.

{{< info "For benchmark versions of the game, there is a whole host of graphical options available as game arguments - but this seems to be missing in the retail version." >}}

# Alternative Implementations

* [SaBOTender (C#)](https://github.com/shalzuth/SaBOTender)
    * Implements very basic networking capabilities.
