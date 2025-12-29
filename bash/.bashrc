# Ensure interactive bash shells source the login profile so PATH and env are consistent
# with login shells (keeps behavior aligned with ~/.profile and zsh files).
[ -f "$HOME/.profile" ] && source "$HOME/.profile"
