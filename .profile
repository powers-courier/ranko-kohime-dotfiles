# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

ZDOTDIR=~/.config/shell

export AMD_VULKAN_ICD=RADV
export EDITOR=/home/ranko/.local/bin/nvim.appimage
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export TERM=xterm
export VISUAL=emacs
