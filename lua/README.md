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

sudo pacman -S clang clang-format # Arch

# or equivalent for your distro

# Lua

sudo pacman -S stylua

🚀 Installation
1️⃣ Backup existing config (optional)
mv ~/.config/nvim ~/.config/nvim.backup

2️⃣ Clone this repository
git clone https://github.com/Adshdl-Zero/nvim-dotfile.git ~/.config/nvim

3️⃣ Start Neovim
nvim

On first launch:

lazy.nvim will auto-install

All plugins will be downloaded automatically

🔌 Plugins Used
Plugin Manager

folke/lazy.nvim – Modern async plugin manager

UI / UX

rose-pine/neovim – Colorscheme

nvim-lualine/lualine.nvim – Statusline

nvim-tree/nvim-tree.lua – File explorer

nvim-tree/nvim-web-devicons – Icons

Navigation & Search

nvim-telescope/telescope.nvim – Fuzzy finder

nvim-lua/plenary.nvim – Lua utility library

ThePrimeagen/harpoon (harpoon2) – Quick file jumps

Syntax & Highlighting

nvim-treesitter/nvim-treesitter – Syntax highlighting & parsing

Git

tpope/vim-fugitive – Git inside Neovim

Editing Enhancements

windwp/nvim-autopairs – Auto-close brackets

numToStr/Comment.nvim – Toggle comments

mbbill/undotree – Visual undo history

LSP & Autocompletion

neovim/nvim-lspconfig – LSP configuration

mason-org/mason.nvim – LSP installer

mason-org/mason-lspconfig.nvim – Mason ↔ LSP bridge

Completion & Snippets

hrsh7th/nvim-cmp – Completion engine

hrsh7th/cmp-nvim-lsp

hrsh7th/cmp-buffer

hrsh7th/cmp-path

hrsh7th/cmp-nvim-lua

saadparwaiz1/cmp_luasnip

L3MON4D3/LuaSnip – Snippet engine

rafamadriz/friendly-snippets – Predefined snippets

Formatting

stevearc/conform.nvim – Auto-format on save

🧠 Language Server Setup

Configured LSPs:

Pyright – Python

clangd – C / C++

lua_ls – Lua (Neovim-aware)

LSPs are installed via Mason.

⌨️ Key Highlights
Leader Key
<Space>

Telescope

<leader>pf → Find files

<leader>ps → Grep string

<C-p> → Git files

Git (Fugitive)

<leader>gs → Git status

Harpoon

<leader>a → Add file

<C-e> → Harpoon menu

<C-1..4> → Jump to file

File Explorer

<leader>e → Toggle tree

<leader>f → Reveal file

Diagnostics

[d / ]d → Prev / next diagnostic

<leader>fd → Line diagnostics

🧪 Formatting on Save

Automatically formats on save using:

black (Python)

prettier (JS/TS/JSON/HTML/CSS/Markdown)

stylua (Lua)

clang-format (C/C++)

🧠 Notes

Cursor stays centered while scrolling

Relative + absolute line numbers enabled

Designed to be minimal but extensible

Easy to fork and customize
