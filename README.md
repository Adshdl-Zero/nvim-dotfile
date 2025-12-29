Neovim Configuration (Lazy.nvim)

A modern, fast, and minimal Neovim setup built with Lua and lazy.nvim, focused on productivity, LSP, Treesitter, Git, and a clean UI.

✨ Features

⚡ Fast startup using lazy.nvim

🌳 Treesitter-based syntax highlighting

🧠 Built-in LSP support (Python, C/C++, Lua)

🔍 Telescope fuzzy finding

🧷 Harpoon for quick file navigation

🔧 Auto-format on save (Conform.nvim)

🌈 Rose Pine colorscheme

🧬 Git integration via vim-fugitive

📁 File explorer (nvim-tree)

🧾 Undo history visualizer

🧠 Autocomplete with snippets

📊 Statusline with lualine

🎯 Cursor centered while scrolling

🧰 Prerequisites

Make sure you have the following installed:

Required

Neovim ≥ 0.9

Git

A Nerd Font (for icons)
Recommended: JetBrainsMono Nerd Font

Recommended External Tools

Used by formatters / LSPs:

# Python

pip install black pyright

# JS / TS / Web

npm install -g prettier

# C / C++

Arch:
sudo pacman -S clang clang-format

or equivalent for your distro

# Lua

sudo pacman -S stylua

# 🚀 Installation

1️⃣ Backup existing config (optional)

`mv ~/.config/nvim ~/.config/nvim.backup`

2️⃣ Clone this repository

`git clone https://github.com/Adshdl-Zero/nvim-dotfile.git ~/.config/nvim`

3️⃣ Start Neovim

`nvim`

On first launch:

lazy.nvim will auto-install

All plugins will be downloaded automatically

# Key Highlights

\<leader> = " "

Telescope

- \<leader>pf → Find files
- \<leader>ps → Grep string
- \<C-p> → Git files

Git (Fugitive)

- \<leader>gs → Git status

Harpoon

- \<leader>a → Add file
- \<C-e> → Harpoon menu
- \<C-1..4> → Jump to file

File Explorer

- \<leader>e → Toggle tree
- \<leader>f → Reveal file

Diagnostics

- [d / ]d → Prev / next diagnostic
- \<leader>fd → Line diagnostics

Automatically formats on save
