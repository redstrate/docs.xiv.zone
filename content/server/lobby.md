---
title: "Lobby"
---

These servers are first thing the [game client]({{< ref "executable/ffxiv" >}}) connects to when you login. These are the ones hardcoded into the client:

* neolobby01.ffxiv.com (Elemental) (`LobbyHost01`)
* neolobby03.ffxiv.com (Gaia) (`LobbyHost02`)
* neolobby05.ffxiv.com (Mana) (`LobbyHost03`)
* neolobby02.ffxiv.com (Aether) (`LobbyHost04`)
* neolobby04.ffxiv.com (Primal) (`LobbyHost05`)
* neolobby06.ffxiv.com (Chaos) (`LobbyHost06`)
* neolobby07.ffxiv.com (Light) (`LobbyHost07`)
* neolobby08.ffxiv.com (Crystal) (`LobbyHost08`)
* neolobby09.ffxiv.com (Materia) (`LobbyHost09`)
* neolobby10.ffxiv.com (Meteor) (`LobbyHost10`)
* neolobby11.ffxiv.com (Dynamis) (`LobbyHost11`)
* neolobby12.ffxiv.com (Shadow[^1]) (`LobbyHost12`)
* neolobby98.ffxiv.com (Unknown[^2]) (`LobbyHost98`)

These directly correspond to the layout of the [Logical Data Centers]({{< ref "logical-data-center" >}}). And this makes sense, as the lobby server you connect to changes depending on which logical data center you select in the client.

The main purpose of the lobby is to funnel you to [the World server]({{< ref "world" >}}) of your choosing. It also acts as a waiting area during congestion, putting players into a queue before connecting to the World server.

Communication with the Lobby server is "encrypted", which is strange as the rest of the game's communication isn't. Another interesting thing is that the client doesn't have the IP address of the World servers hardcoded, but this is instead given to the client by the Lobby server on login.

# Alternative Implementations

* [Sapphire (C++)](https://github.com/SapphireServer/Sapphire/)
* Maelstorm (C#)
* iolite (Rust)
* Kawari (Rust)

[^1]: The Shadow data center [is defunct](https://gamerant.com/final-fantasy-14-servers-shutdown-shadow-data-center/).
[^2]: It's likely because of the high number - chosen to avoid conflicts with any future datacenter additions - that is meant for public testing. And indeed, this was the lobby server for the NA Cloud DC test.
