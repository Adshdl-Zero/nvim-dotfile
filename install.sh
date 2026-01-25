#!/bin/sh
# Cross-platform Neovim configuration installer
# Compatible with sh, bash, zsh, fish on Linux, macOS, and other Unix-like systems

set -e

# Detect OS
detect_os() {
	OS_TYPE=$(uname -s)
	case "$OS_TYPE" in
		Linux*)
			OS="linux"
			;;
		Darwin*)
			OS="macos"
			;;
		CYGWIN* | MINGW* | MSYS*)
			OS="windows"
			;;
		*)
			OS="unknown"
			;;
	esac
}

detect_os

# Detect package manager
detect_package_manager() {
	if command -v apt-get >/dev/null 2>&1; then
		PKG_MANAGER="apt"
	elif command -v pacman >/dev/null 2>&1; then
		PKG_MANAGER="pacman"
	elif command -v brew >/dev/null 2>&1; then
		PKG_MANAGER="brew"
	elif command -v yum >/dev/null 2>&1; then
		PKG_MANAGER="yum"
	elif command -v dnf >/dev/null 2>&1; then
		PKG_MANAGER="dnf"
	elif command -v zypper >/dev/null 2>&1; then
		PKG_MANAGER="zypper"
	else
		PKG_MANAGER="unknown"
	fi
}

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_section() {
	printf "${BLUE}========================================${NC}\n"
	printf "${BLUE}%s${NC}\n" "$1"
	printf "${BLUE}========================================${NC}\n"
}

print_success() {
	printf "${GREEN}✓ %s${NC}\n" "$1"
}

print_warning() {
	printf "${YELLOW}⚠ %s${NC}\n" "$1"
}

print_error() {
	printf "${RED}✗ %s${NC}\n" "$1"
}

# Check if command exists
cmd_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Install package manager prerequisites
install_prerequisite() {
	PKG_NAME=$1
	case "$PKG_MANAGER" in
		apt)
			sudo apt-get update >/dev/null 2>&1
			sudo apt-get install -y "$PKG_NAME" >/dev/null 2>&1
			;;
		pacman)
			sudo pacman -Sy --noconfirm "$PKG_NAME" >/dev/null 2>&1
			;;
		brew)
			brew install "$PKG_NAME" >/dev/null 2>&1
			;;
		yum)
			sudo yum install -y "$PKG_NAME" >/dev/null 2>&1
			;;
		dnf)
			sudo dnf install -y "$PKG_NAME" >/dev/null 2>&1
			;;
		zypper)
			sudo zypper install -y "$PKG_NAME" >/dev/null 2>&1
			;;
		*)
			print_warning "Unknown package manager. Please install $PKG_NAME manually."
			return 1
			;;
	esac
	return 0
}

# Check prerequisites
check_prerequisites() {
	print_section "Checking & Installing Prerequisites (OS: $OS, PM: $PKG_MANAGER)"

	# Check Neovim
	if ! cmd_exists nvim; then
		print_warning "Neovim not found. Attempting to install..."
		case "$OS" in
			linux)
				case "$PKG_MANAGER" in
					apt)
						print_success "Installing neovim via apt..."
						install_prerequisite neovim && print_success "Neovim installed successfully"
						;;
					pacman)
						print_success "Installing neovim via pacman..."
						install_prerequisite neovim && print_success "Neovim installed successfully"
						;;
					brew)
						print_success "Installing neovim via brew..."
						install_prerequisite neovim && print_success "Neovim installed successfully"
						;;
					yum|dnf)
						print_success "Installing neovim via $PKG_MANAGER..."
						install_prerequisite neovim && print_success "Neovim installed successfully"
						;;
					*)
						print_error "Cannot auto-install Neovim. Please install manually from https://github.com/neovim/neovim/releases"
						exit 1
						;;
				esac
				;;
			macos)
				print_success "Installing neovim via brew..."
				install_prerequisite neovim && print_success "Neovim installed successfully"
				;;
			*)
				print_error "Cannot auto-install Neovim on this system. Please install manually from https://github.com/neovim/neovim/releases"
				exit 1
				;;
		esac
	fi
	NVIM_VERSION=$(nvim --version | head -n 1)
	print_success "Neovim: $NVIM_VERSION"

	# Check Git
	if ! cmd_exists git; then
		print_warning "Git not found. Attempting to install..."
		install_prerequisite git && print_success "Git installed successfully" || {
			print_error "Failed to install Git. Please install manually."
			exit 1
		}
	fi
	print_success "Git installed"

	# Check Node.js (optional but recommended)
	if ! cmd_exists node; then
		print_warning "Node.js not found. Attempting to install..."
		case "$PKG_MANAGER" in
			apt)
				print_success "Installing nodejs via apt..."
				install_prerequisite nodejs && print_success "Node.js installed successfully"
				;;
			pacman)
				print_success "Installing nodejs via pacman..."
				install_prerequisite nodejs && print_success "Node.js installed successfully"
				;;
			brew)
				print_success "Installing node via brew..."
				install_prerequisite node && print_success "Node.js installed successfully"
				;;
			yum|dnf)
				print_success "Installing nodejs via $PKG_MANAGER..."
				install_prerequisite nodejs && print_success "Node.js installed successfully"
				;;
			*)
				print_warning "Cannot auto-install Node.js. Please install manually: https://nodejs.org"
				;;
		esac
	else
		NODE_VERSION=$(node --version)
		print_success "Node.js: $NODE_VERSION"
	fi

	# Check Python (optional but recommended)
	if ! cmd_exists python3; then
		print_warning "Python3 not found. Attempting to install..."
		case "$PKG_MANAGER" in
			apt)
				print_success "Installing python3 via apt..."
				install_prerequisite python3 && print_success "Python3 installed successfully"
				;;
			pacman)
				print_success "Installing python via pacman..."
				install_prerequisite python && print_success "Python3 installed successfully"
				;;
			brew)
				print_success "Installing python@3 via brew..."
				install_prerequisite python@3 && print_success "Python3 installed successfully"
				;;
			yum|dnf)
				print_success "Installing python3 via $PKG_MANAGER..."
				install_prerequisite python3 && print_success "Python3 installed successfully"
				;;
			*)
				print_warning "Cannot auto-install Python3. Please install manually: https://python.org"
				;;
		esac
	else
		PYTHON_VERSION=$(python3 --version)
		print_success "Python3: $PYTHON_VERSION"
	fi
}

# Install the configuration
install_config() {
	print_section "Installing Neovim Configuration"

	NVIM_CONFIG_DIR="$HOME/.config/nvim"
	NVIM_DATA_DIR="$HOME/.local/share/nvim"

	# Backup existing config
	if [ -d "$NVIM_CONFIG_DIR" ]; then
		print_warning "Existing Neovim config found at $NVIM_CONFIG_DIR"
		BACKUP_DIR="$NVIM_CONFIG_DIR.backup.$(date +%s)"
		echo "Creating backup at $BACKUP_DIR"
		mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
		print_success "Configuration backed up"
	fi

	# Clone repository
	echo "Cloning nvim-dotfile repository..."
	git clone https://github.com/Adshdl-Zero/nvim-dotfile.git "$NVIM_CONFIG_DIR"
	print_success "Configuration installed at $NVIM_CONFIG_DIR"
}

# Install formatters
install_formatters() {
	print_section "Installing External Formatters"

	# Python formatters (black, ruff)
	if cmd_exists pip3; then
		print_success "Installing Python formatters (black, ruff)..."
		pip3 install --user black ruff 2>/dev/null || print_warning "Could not install black/ruff"
	fi

	# Prettier for JavaScript/TypeScript/JSON/YAML/HTML/CSS
	if cmd_exists npm; then
		print_success "Installing Prettier formatter..."
		npm install -g prettier 2>/dev/null || print_warning "Could not install prettier globally"
	fi

	# Stylua for Lua
	if cmd_exists cargo; then
		print_success "Installing Stylua formatter..."
		cargo install stylua 2>/dev/null || print_warning "Could not install stylua"
	fi

	# Clang-format for C/C++
	print_success "Instructions for installing clang-format:"
	case "$OS" in
		linux)
			case "$PKG_MANAGER" in
				apt)
					echo "  Run: sudo apt-get install clang-format"
					;;
				pacman)
					echo "  Run: sudo pacman -S clang"
					;;
				yum)
					echo "  Run: sudo yum install clang-tools-extra"
					;;
				dnf)
					echo "  Run: sudo dnf install clang-tools-extra"
					;;
				zypper)
					echo "  Run: sudo zypper install clang"
					;;
				*)
					echo "  Use your distro's package manager to install clang-format"
					;;
			esac
			;;
		macos)
			echo "  Run: brew install clang-format"
			;;
		windows)
			echo "  Download from: https://github.com/llvm/llvm-project/releases"
			;;
	esac
}

# Install nerd fonts
install_nerd_fonts() {
	print_section "Nerd Fonts Setup"

	echo "To get the best experience, install a Nerd Font:"
	echo "Recommended: JetBrainsMono Nerd Font, FiraCode Nerd Font, or Meslo Nerd Font"
	echo ""
	echo "Download from: https://www.nerdfonts.com"
	echo ""

	case "$OS" in
		linux)
			echo "Install via package manager:"
			case "$PKG_MANAGER" in
				apt)
					echo "  sudo apt install fonts-jetbrains-mono fonts-fira-code"
					;;
				pacman)
					echo "  sudo pacman -S nerd-fonts-jetbrains-mono nerd-fonts-fira-code"
					;;
				yum)
					echo "  sudo yum install fontawesome-fonts-all google-noto-sans-mono-fonts"
					;;
				dnf)
					echo "  sudo dnf install google-noto-sans-mono-fonts"
					;;
				*)
					echo "  Use your distro's package manager to install nerd fonts"
					;;
			esac
			;;
		macos)
			echo "Install via Homebrew:"
			echo "  brew install font-jetbrains-mono-nerd-font font-fira-code-nerd-font"
			;;
		windows)
			echo "Download .zip files from nerdfonts.com and extract to:"
			echo "  C:\\Users\\YourUsername\\AppData\\Local\\Microsoft\\Windows\\Fonts"
			;;
	esac

	echo ""
	echo "Then set your terminal to use the Nerd Font in its preferences."
}

# Print keybindings
print_keybindings() {
	print_section "Keybindings Reference"

	cat << 'EOF'
Leader Key: SPACE

File Navigation:
  <space>pf  → Find files (Telescope)
  <space>ps  → Grep in files (Telescope)
  <C-p>      → Find git files
  <space>e   → Toggle file tree (NvimTree)
  <space>f   → Reveal current file in tree

Quick Navigation (Harpoon):
  <space>a   → Add file to harpoon
  <C-e>      → Toggle harpoon menu
  <C-1>      → Jump to file 1
  <C-2>      → Jump to file 2
  <C-3>      → Jump to file 3
  <C-4>      → Jump to file 4

Git Integration (Fugitive):
  <space>gs  → Open git status

Undo / Redo:
  <space>u   → Toggle undo tree

Diagnostics:
  [d         → Previous diagnostic
  ]d         → Next diagnostic
  <space>fd  → Show line diagnostics

Code Completion:
  <C-Space>  → Trigger completion
  <Tab>      → Next item / expand snippet
  <S-Tab>    → Previous item / jump back in snippet
  <CR>       → Confirm selection
EOF
}

# Final instructions
print_final_instructions() {
	print_section "Installation Complete!"

	echo ""
	print_success "Neovim configuration installed successfully!"
	echo ""
	echo "Next steps:"
	echo "1. Start Neovim: nvim"
	echo "2. Wait for plugins to install (first launch may take a minute)"
	echo "3. LSP servers will auto-install via Mason"
	echo ""
	echo "For best experience:"
	echo "  - Install a Nerd Font and set it as your terminal font"
	echo "  - Install external formatters (black, prettier, etc.)"
	echo "  - Install Node.js and Python3 for full LSP support"
	echo ""
	echo "Documentation: See README.md in your config directory"
	echo "Config location: $HOME/.config/nvim"
	echo ""
}

# Main installation flow
main() {
	print_section "Neovim Dotfile Installation"

	detect_package_manager
	check_prerequisites
	install_config
	install_formatters
	install_nerd_fonts
	print_keybindings
	print_final_instructions
}

main
