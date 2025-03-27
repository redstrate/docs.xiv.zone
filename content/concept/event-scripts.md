---
title: "Client-Side Scripts"
---

Events are scripted using [Lua](https://lua.org/), and are shipped with the client as bytecode. One example is `game_script/quest/047/FesSxt103_04798.luab`, notice the `.luab` extension.

The version of Lua used in the client is Lua 5.1. They don't seem to modify much - if any - of the base Lua state - including [dangerous stuff like the os module](https://notnite.com/blog/ffxiv-modloader-ace) that's not needed for client-side scripts.

# Decompiling 

Decompiling the bytecode is trivial, one tool that can be used is [unluac](https://sourceforge.net/projects/unluac/). But there many other 5.1 decompilers available online.

Since only the bytecode remains, there's very little useful information left in the file. Much of the logic and API calls are intact though!

# API

Here are the currently known functions of the API:

---

## Class `Pc`

**`IsWarriorOfLight()` → `boolean`**

Unknown purpose. But probably returns true if the player character is legacy (1.x).

**`IsHowTo{id=…}` → `boolean`**

Unknown purpose.

---

## Class `EventHandler`

See `game_script/system/EventHandler.luab` for various constants used throughout event scripts.

**`PlayBGM{id=…}`**

Unknown purpose. But probably plays BGM.

**`FadeOut{unk=…}`**

Unknown purpose. But probably fades out the screen.

**`WaitForFade()`**

Unknown purpose. But probably waits for the current fade to stop animating.

**`BeginCutScene()`**

Unknown purpose. But probably starts preparing a cutscene to play.

**`PlayCutScene{unk=…}`**

Unknown purpose. But probably plays a cutscene.

**`EndCutScene()`**

Unknown purpose. But probably ends the current cutscene.

**`DisableSceneSkip()`**

Unknown prupose. But probably prevents the player from skipping the cutscene.

**`FadeIn{unk=…}`**

Unknown purpose. But probably starts a fade in animation.

**`EnableSceneSkip()`**

Unknown purpose. But probably allows the player to skip the cutscene.

**`LoadMovePosition{unk=…}`**

Unknown purpose.

**`HowTo{id=…}`**

Unknown purpose.

**`GetTerritoryType()` → `unk`**

Unknown purpose. But probably returns the current territory type id.

**`PlayLandscapeCamera{unk=…}`**

Unknown purpose. But probably moves the current camera to a set landscape camera.

**`Zoom{unk=…, unk=…, unk=…, unk=…, unk=…}`**

Unknown purpose. But probably begins zooming the camera.

**`Wait{unk=…}`**

Unknown purpose. But probably waits for a set amount of time.

**`UpdownPan{unk=…, unk=…, unk=…, unk=…, unk=…}`**

Unknown purpose. But probably pan related.

**`SidePan{unk=…, unk=…, unk=…, unk=…, unk=…}`**

Unknown purpose. But probably pan related.

**`PlayScreenShake{unk=…, unk=…, unk=…}`**

Unknown purpose. But probably starts shaking the screen.

**`StopScreenShake{unk=…}`**

Unknown purpose. But probably stops shaking the screen.

**`ScreenImage{unk=…}`**

Unknown purpose. But probably shows a set image on the screen.

---

## Class `Opening`

**`EnableEventRange{unk=…, unk=…, unk=…}`**

Unknown purpose.

**`DisableEventRange{unk=…, unk=…, unk=…}`**

Unknown purpose.

---

## Class `Chara` extends `Actor`

**`Move{unk=…, unk=…, unk=…}`**

Unknown purpose. But probably moves the character to a specified position.

**`WaitForMove()`**

Unknown purpose. But probably waits until the character has stopped moving.

## Class `Actor`

**`EndEventRollback{unk=…, unk=…}`**

Unknown purpose.
