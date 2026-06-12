# hiraeth

Hiraeth is defined as profound longing and homesickness.

I've tried a myriad of text editors: VS Code/VSCodium, Zed, Sublime, Notepad++, Focus, Helix, as well as all the main Neovim distros. Every time I left my own Neovim config to look for more, I always wanted to come back -- hence the name Hiraeth.

I've been half tempted to make my own editor but it's far more work than it's worth. If I ever do, I'd call it Hiraeth.

This is kept purposefully tiny -- the (almost) bare minimum of what I need when used in conjunction with lazygit and yazi.
There could be even less here if you remove matugen and which-key, even less so if you removed mason, but then you're trading functionality for aesthetic minimalism -- not _actual_ minimalism, at least in my opinion.

### Neovim plugins:

| Plugin | Purpose |
|--------|---------|
| `telescope.nvim` | Fuzzy finder |
| `matugen.nvim` | Material You colours from matugen |
| `which-key.nvim` | Keybind hints |
| `blink.cmp` | Completion engine |
| `mason.nvim` | LSP/tool installer |
| `mason-lspconfig.nvim` | Mason → lspconfig bridge |
| `nvim-lspconfig` | LSP server defaults |
| `conform.nvim` | Format on save |

### Dependencies:

| Plugin | Purpose |
|--------|---------|
| `lazy.nvim` | Plugin manager |
| `plenary.nvim` | Telescope dependency |

## Setup

You need Neovim 0.10 or newer. Clone this into your config directory and open Neovim:

```bash
git clone https://github.com/captnjayce/hiraeth.git ~/.config/nvim
nvim
```

lazy.nvim will bootstrap itself on first launch, then pull in everything else. You will need to restart Neovim once so Mason can finish installing the LSPs.
