#!/bin/bash
mv .bashrc .bashrc.backup
touch .bashrc
mv .zshrc .zshrc.backup
touch .zshrc
cat > .bashrc << EOF
alias la='la -la'
export PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n $ '
EOF
cp .bashrc .zshrc
if [[ $SHELL == *zsh* ]]; then
  echo "Looks like you are using ZSH"
  source .zshrc
else
  echo "Looks like you are using BASH"
  source .bashrc
fi
