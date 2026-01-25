# Neovim Configuration (lazy.nvim)

A modern, fast, and feature-rich Neovim setup built with Lua and lazy.nvim, providing a complete development environment with LSP support for multiple programming languages, Treesitter syntax highlighting, git integration, fuzzy finding, and more.

## ✨ Features

- ⚡ **Fast startup** using lazy.nvim plugin manager
- 🌳 **Treesitter-based** syntax highlighting for 12+ languages
- 🧠 **Built-in LSP support** for 13+ languages (Python, JavaScript, TypeScript, Java, C/C++, Lua, CSS, HTML, JSON, YAML, Bash, Docker, SQL, Markdown)
- 🔍 **Telescope** fuzzy finder for files and text search
- 🧷 **Harpoon** for quick file navigation and management
- 💾 **Auto-format on save** with Conform.nvim
- 🎨 **Rose Pine colorscheme** with transparent background
- 🧬 **Git integration** via vim-fugitive
- 📁 **File explorer** with nvim-tree
- 🧾 **Undo history** visualizer
- 🧠 **Autocomplete with snippets** (nvim-cmp + LuaSnip)
- 📊 **Statusline** with lualine
- 🔧 **Auto-pairing** with nvim-autopairs
- 💬 **Fast commenting** with Comment.nvim
- 🎯 **Smart cursor** centering while scrolling

---

## 🛠️ Prerequisites

### Required

- **Neovim** ≥ 0.11 - [Install](https://github.com/neovim/neovim/releases)
- **Git** - Version control system
- **Nerd Font** - For proper icon display (Recommended: JetBrainsMono Nerd Font, FiraCode, or Meslo)

### Recommended External Tools

- **Node.js** ≥ 14 - For JavaScript/TypeScript LSP and Prettier formatter
- **Python 3** - For Python LSP (Pyright), Black, and Ruff formatters
- **npm/yarn** - Package manager for Node.js tools
- **C/C++ compiler** - For clangd LSP (gcc or clang)
- **Rust toolchain** - For Stylua (optional Lua formatter)

### Optional

- **Java JDK** - For Java LSP (jdtls)
- **pip** - Python package manager

---

## 🚀 Quick Installation

### Option 1: Automated Installation Script (Recommended)

The installation script works on **any shell** (bash, zsh, fish, sh) and **any OS** (Linux, macOS, Windows).

Run this command to install the configuration automatically:

```bash
curl -fsSL https://raw.githubusercontent.com/Adshdl-Zero/nvim-dotfile/master/install.sh | sh
```

Or clone and run locally:

```bash
git clone https://github.com/Adshdl-Zero/nvim-dotfile.git
cd nvim-dotfile
chmod +x install.sh
./install.sh
```

**Features of the installation script:**
- ✓ **Cross-platform**: Works on Linux, macOS, and Windows (Git Bash/Cygwin)
- ✓ **Shell-agnostic**: Compatible with bash, zsh, fish, sh, and other POSIX shells
- ✓ **Auto-detection**: Detects your OS and package manager automatically
- ✓ **Auto-installation**: Automatically installs missing prerequisites (Neovim, Git, Node.js, Python3)
- ✓ **OS-specific guidance**: Provides tailored installation instructions for your system
- ✓ **Safe backups**: Automatically backs up existing Neovim configuration

### Option 2: Manual Installation

#### Step 1: Backup Existing Config (if present)

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

#### Step 2: Clone the Repository

```bash
git clone https://github.com/Adshdl-Zero/nvim-dotfile.git ~/.config/nvim
```

#### Step 3: Start Neovim

```bash
nvim
```

On first launch:
- lazy.nvim will automatically bootstrap and install all plugins
- Mason will begin installing LSP servers in the background
- All formatters will be available (if installed)

---

## � Supported Platforms & Shells

The installation script automatically detects and adapts to your environment.

### Operating Systems
- ✓ **Linux** (Ubuntu, Debian, Arch, Fedora, openSUSE, etc.)
- ✓ **macOS**
- ✓ **Windows** (Git Bash, Cygwin, MSYS2)

### Shells
- ✓ **bash**
- ✓ **zsh**
- ✓ **fish**
- ✓ **sh** (and other POSIX shells)

### Package Manager Support
The script automatically detects your package manager:
- `apt-get` (Ubuntu/Debian)
- `pacman` (Arch Linux)
- `brew` (macOS)
- `yum` (CentOS/RHEL)
- `dnf` (Fedora)
- `zypper` (openSUSE)

---

## �📦 Setting Up Language Support

### Automatic Installation

LSP servers are automatically installed via Mason when you:
1. Open Neovim for the first time
2. Open a file of a supported language

To manually manage LSPs:
```vim
:Mason        " Open Mason UI to view/install LSPs
:MasonInstall " Install a specific LSP
:MasonUninstall " Remove an LSP
```

### Manual Installation of External Tools

#### Python Support
```bash
pip3 install --user black pyright ruff
```

#### JavaScript/TypeScript/Web Support
```bash
npm install -g prettier typescript-language-server
```

#### C/C++ Support
```bash
# Ubuntu/Debian
sudo apt-get install clang-format clang

# Arch
sudo pacman -S clang

# macOS
brew install clang-format
```

#### Lua Support
```bash
cargo install stylua
# OR
npm install -g stylua
```

#### Java Support
```bash
# Mason will handle most of the setup, but ensure you have a JDK installed
# Ubuntu/Debian
sudo apt-get install default-jdk

# Arch
sudo pacman -S jdk-openjdk

# macOS
brew install openjdk
```

---

## 🎨 Font Setup

For the best experience with icons and UI elements, install a Nerd Font:

### Download a Nerd Font

Visit [nerdfonts.com](https://www.nerdfonts.com) and download:
- **JetBrainsMono Nerd Font** (Recommended)
- **FiraCode Nerd Font**
- **Meslo Nerd Font**
- **DroidSansMono Nerd Font**

### Install via Package Manager

**Ubuntu/Debian:**
```bash
sudo apt install fonts-jetbrains-mono fonts-fira-code
```

**Arch:**
```bash
sudo pacman -S nerd-fonts-jetbrains-mono nerd-fonts-fira-code
```

**macOS:**
```bash
brew install font-jetbrains-mono-nerd-font font-fira-code-nerd-font
```

### Configure Your Terminal

Set your terminal emulator to use the installed Nerd Font:
- **Terminal.app / iTerm2**: Preferences → Profiles → Font
- **GNOME Terminal**: Preferences → Unnamed → Text Appearance
- **Konsole**: Settings → Edit Current Profile → Appearance
- **Alacritty**: Edit `~/.config/alacritty/alacritty.yml` and set font family

---

## ⌨️ Key Bindings

**Leader Key: `SPACE`**

### File Navigation

| Keybinding | Action |
|-----------|--------|
| `<Space>pf` | Find files in project |
| `<Space>ps` | Grep/search text in files |
| `<C-p>` | Find git files |
| `<Space>e` | Toggle file explorer (NvimTree) |
| `<Space>f` | Reveal current file in explorer |

### Quick Navigation (Harpoon)

| Keybinding | Action |
|-----------|--------|
| `<Space>a` | Add current file to harpoon |
| `<C-e>` | Open harpoon quick menu |
| `<C-1>` | Jump to harpoon file 1 |
| `<C-2>` | Jump to harpoon file 2 |
| `<C-3>` | Jump to harpoon file 3 |
| `<C-4>` | Jump to harpoon file 4 |

### Git Integration (Fugitive)

| Keybinding | Action |
|-----------|--------|
| `<Space>gs` | Open git status window |

### Undo / History

| Keybinding | Action |
|-----------|--------|
| `<Space>u` | Toggle undo tree |

### LSP & Diagnostics

| Keybinding | Action |
|-----------|--------|
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `<Space>fd` | Show diagnostics for current line |

### Code Completion

| Keybinding | Action |
|-----------|--------|
| `<C-Space>` | Trigger autocomplete menu |
| `<Tab>` | Select next item / expand snippet |
| `<S-Tab>` | Select previous item / jump back in snippet |
| `<CR>` | Confirm selection |

### General

| Keybinding | Action |
|-----------|--------|
| `gcc` | Toggle comment (single line) |
| `gc` | Toggle comment (visual selection) |
| Auto-format | `:write` (format on save) |

---

## 📂 Configuration Structure

```
~/.config/nvim/
├── init.lua              # Main entry point
├── install.sh            # Installation script
├── README.md             # This file
└── lua/
    └── pino/
        ├── init.lua      # Plugin loading
        ├── lazy.lua      # Plugin specifications & LSP config
        └── remap.lua     # Keybindings & editor settings
```

### File Descriptions

- **init.lua**: Entry point that loads the Pino configuration namespace
- **lazy.lua**: Plugin specifications, LSP servers, and Mason configuration
- **remap.lua**: Keybindings, editor options, and general settings

---

## 📋 Supported Languages & LSPs

| Language | LSP Server | Formatter |
|----------|-----------|-----------|
| Python | Pyright | Black, Ruff |
| JavaScript | TypeScript Server | Prettier |
| TypeScript | TypeScript Server | Prettier |
| Java | JDTLS | - |
| C | Clangd | Clang-Format |
| C++ | Clangd | Clang-Format |
| Lua | Lua-LS | Stylua |
| CSS | Cssls | Prettier |
| HTML | HTML Server | Prettier |
| JSON | Jsonls | Prettier |
| YAML | Yamlls | Prettier |
| Bash | Bashls | - |
| Docker | Dockerls | - |
| SQL | SQLLs | - |
| Markdown | Marksman | Prettier |

---

## 🔧 Troubleshooting

### Plugins Not Installing

If plugins don't install automatically:

```vim
:Lazy sync    " Force sync all plugins
:Lazy update  " Update all plugins
```

### LSPs Not Working

1. Check Mason installation status:
   ```vim
   :Mason
   ```

2. Manually install a specific LSP:
   ```vim
   :MasonInstall <lsp-name>
   ```

3. Check LSP logs:
   ```vim
   :LspLog
   ```

### Icons Not Displaying

- Ensure you have a Nerd Font installed
- Set your terminal to use the Nerd Font
- Restart your terminal

### Formatters Not Working

1. Ensure the formatter is installed (see [Setting Up Language Support](#-setting-up-language-support))
2. Check available formatters:
   ```vim
   :ConformInfo
   ```

### Performance Issues

- Update plugins: `:Lazy update`
- Clear cache:
  ```bash
  rm -rf ~/.local/share/nvim/lazy
  rm -rf ~/.local/share/nvim/mason
  ```

### Treesitter Highlighting Issues

Update Treesitter parsers:
```vim
:TSUpdate all
```

---

## 📚 Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim Repository](https://github.com/folke/lazy.nvim)
- [Mason.nvim Repository](https://github.com/mason-org/mason.nvim)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig)
- [Treesitter Documentation](https://github.com/nvim-treesitter/nvim-treesitter)

---

## 🤝 Contributing

Found a bug or have a suggestion? Feel free to open an issue or submit a pull request on [GitHub](https://github.com/Adshdl-Zero/nvim-dotfile).

---

## 📄 License

This configuration is provided as-is. See the LICENSE file for more details.

---

## 🎉 First Launch

After installation:

1. **Start Neovim:**
   ```bash
   nvim
   ```

2. **Wait for plugins to install** (first launch may take 1-2 minutes)

3. **LSPs will install automatically** when you open files in supported languages

4. **Enjoy coding!** All keybindings are available immediately

---

## 💡 Tips & Tricks

- Use `:Lazy` to manage plugins interactively
- Use `:Mason` to manage LSP servers
- Use `<Space>pf` to quickly jump between files
- Add frequently used files to Harpoon with `<Space>a`
- Press `?` in Telescope to see all available commands
- Use `<Space>gs` to manage git operations
