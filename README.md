Vim Chunkwm Navigator
==================

This plugin will allow you to navigate seamlessly between Vim/Neovim splits and
native mac os windows managed by chunkwm using a consistent set of hotkeys. The
secret sauce that allows this to work is the combination of [Åsmund Vikane][]'s
[chunkwm][], a tiling window manager, and a hotkey daemon(e.g. [khd][] or
[skhd][]).

This is **oh so heavily** based off [Chris Toomey][]'s [vim-tmux-navigator][].
For educational purposes I have structured the code like [vim-tmux-navigator][]
due to my lack of vimscript experience. I have taken the time to implement
everything as if it were from scratch in a progressive manner (as the need
presented itself) for my educational benefit. In the end, I hope to have
scratched my own itch, while deepening my vim knownledge.

**IMPORTANT: This requires [chunkwm][], or similar window manager and your
hacking on supplied scripts, and a third party hotkey daemon(e.g. [khd][] or
[skhd][])**

Usage
-----

This plugin provides the following mappings which allow you to move between
Vim/Neovim pane splits and native macos windows seamlessly.

- `<ctrl-h>` => Left
- `<ctrl-j>` => Down
- `<ctrl-k>` => Up
- `<ctrl-l>` => Right

**Note** - Even if you use a modal hotkey daemon, you can bind these to the
default mode.

If you want to use alternate key mappings, see the [configuration section
below][].

Installation
------------

### Vim/Neovim

If you don't have a preferred installation method, I recommend using [vim-plug][].
Assuming you have vim-plug installed and configured, the following steps will
install the plugin:

Add the following line to your `.vimrc` or `init.vim` file

``` vim
Plug 'justfielding/vim-chunkwm-navigator'
```

Then run

```
:PlugInstall
```

### Hotkey Daemon or other third party key mapping method

To configure the chunkw side of this customization we must use a third party
hotkey daemon(e.g. [khd][] or [skhd][]). I will try include configurations for 
any submitted by others.

#### skhd

For [skhd][] edit any existing bindings to `ctrl - h`, `ctrl - j`, `ctrl -
k`, and `ctrl - l` in `~/.skhdrc` to match the following snippet:

``` skhdrc
ctrl - h ->         : if [[ "$(chunkc tiling::query --window name)" != *"vim"* ]]; then chunkc tiling::window --focus west; fi
ctrl - l ->         : if [[ "$(chunkc tiling::query --window name)" != *"vim"* ]]; then chunkc tiling::window --focus west; fi
ctrl - j ->         : if [[ "$(chunkc tiling::query --window name)" != *"vim"* ]]; then chunkc tiling::window --focus west; fi
ctrl - k ->         : if [[ "$(chunkc tiling::query --window name)" != *"vim"* ]]; then chunkc tiling::window --focus west; fi
```

TODO
----

- [ ] Correct how it handles the wrapping around from window back in to vim/nvim  
- [ ] README: Finish!  
  - [ ] add confguraton section  
  - [ ] add khd configuration
  - [ ] add tidbit about terminal title

[Åsmund Vikane]: https://github.com/koekeishiya
[chunkwm]: https://github.com/koekeishiya/chunkwm
[khd]:https://github.com/koekeishiya/khd
[skhd]: https://github.com/koekeishiya/skhd 
[vim-plug]: https://github.com/junegunn/vim-plug