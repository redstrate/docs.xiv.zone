---
title: "Creating your own Dalamud repository"
---

{{< note "This is for creating a 3rd party repository, which is probably not what you want. Almost all plugins should be submitted to the main repository, see https://dalamud.dev/plugin-development/plugin-submission." >}}

Creating a 3rd party Dalamud repository is easy, since it's pretty stateless and only requires you to host the files somewhere. People even host them on free servers like GitHub.

# Plugin Manifests

First you need to craft a folder somewhere (preferably with version control like Git) and start putting plugin manifests inside. These `manifest.toml` contain vital information like where we check the plugin source code from and more. In your manifest folder, create a `stable` subfolder. And then create more folders as needed inside, which correspond to the plugin name.

```
<manifest dir> /
  PluginA /
    manifest.toml
  PluginB /
    manifest.toml
```

The `manifest.toml` is in this format:

```toml
[plugin]
repository = "<git repository>"
commit = "<git hash>"
owners = [ "<your name>" ]
changelog = '''
Your changelog in here.
'''
```

All plugins require an `icon.png`, which you need to provide inside of an `images` folder:

```
<manifest dir> /
  PluginA /
    images /
      icon.png
    manifest.toml
  PluginB /
    images /
      icon.png
    manifest.toml
```

Now your manifest folder is ready to go, we'll move onto setting up the build system next.

# Setting up and using Plogon

[Plogon](https://github.com/goatcorp/Plogon) is the preferred method of building plugins, and it's used for the main Dalamud repository. It uses Docker to standardize the building process and takes care of repository state for you. Follow their [README](https://github.com/goatcorp/Plogon/blob/master/README.md) and continue this guide once you have a folder with a `State.toml` and your built plugins.

# Creating the repo JSON

Now that we have our built plugin DLLs, our new repository is almost usable inside of Dalamud. But Dalamud does not consume the `State.toml` directly, the plugin manifests need to be concentrated into a single JSON file. [XLWebServices](https://github.com/goatcorp/XLWebServices) does this, but I built a smaller tool just for this purpose called [DalamudRepoTool](https://github.com/redstrate/DalamudRepoTool). Install it via [Cargo](https://rust-lang.org):

```shell
cargo install --git https://github.com/redstrate/DalamudRepoTool.git
```

And then run it on your repository:

```shell
DalamudRepoTool --repo-path <your repository path where the State.toml is>
```

When it's done, it will create a `repo.json` where the `State.toml` was. Your repository is complete and can now be used in Dalamud!
