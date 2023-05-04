# Test if ~/.config/shell/zshrc exists
# if it does, source it
if [[ -f ~/.config/shell/zshrc ]]; then
    source ~/.config/shell/zshrc
  else
    echo "No ~/.config/shell/zshrc file found."
fi
