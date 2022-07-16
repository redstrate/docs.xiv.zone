---
title: "ffxiv.exe"
---

This is the actual game executable, and theres two versions - one for DX9 and DX11. You'll almost always be using the DX11 version, called `ffxiv_dx11.exe`.

## Arguments

* DEV.DataPathType
    * **Guessing** that this controls the asset data type used by the client, this is will always be `1`.
* DEV.UseSqPack
    * **Guessing** that this tells the client to try to load data from SqPack files instead of from regular, uncompressed files. Seems to always be `1`.
* DEV.MaxEntitledExpansionID
    * This is the max entitled expansion ID that the currently logging in user has access to, you will want to set this from your login response.
* DEV.TestSID
    * This is the SID you get from your login response.
* SYS.Region
    * Your login region.
* language
    * Your login language.
* ver
    * The (base) game version string.
* DEV.GMServerHost
    * This is the address of the frontier server to connect to. If empty, this will default to the official Square Enix frontier server.
* DEV.LobbyHost0X
    * This is the address of the Nth lobby available to the client, these are numbered 0-9. If empty, this will default to the official Square Enix lobbies.
* DEV.LobbyPort0X
    * This is the port number of the Nth lobby available to the client, these are numbered 0-9. If empty, this will default to the official Square Enix lobbies.

**Note:** For benchmark versions of the game, there is a whole host of graphical options available as game arguments - but this seems to be missing in the retail version.

## Alternative Implementations

None.
