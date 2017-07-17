#!/bin/bash
wget https://raw.githubusercontent.com/bijancn/bcn_scripts/master/.tmux.conf
wget https://raw.githubusercontent.com/bijancn/bcn_scripts/master/.dir_colorsrc
mv .bashrc .bashrc.backup
touch .bashrc
mv .zshrc .zshrc.backup
touch .zshrc
cat > .bashrc << EOF
eval "$(dircolors -b ~/.dir_colorsrc)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -la'
alias ll='ls -ll'
alias x='exit'
EOF
cp .bashrc .zshrc
if [[ $SHELL == *zsh* ]]; then
cat > .zshrc << EOF
export PS1=$'\e[00;34m %n \e[00;36m@\e[01;31m %M :\e[01;34m %~ \e[00m \n $ '
EOF
  echo "Looks like you are using ZSH! Please execute\nsource .zshrc"
else
cat > .zshrc << EOF
export PS1='\[\e[00;34m\]\u\[\e[00;36m\] @ \[\e[01;31m\]\h :\[\e[01;34m\] \w \[\e[00m\]\n $ '
EOF
  echo "Looks like you are using BASH Please execute\nsource .bashrc"
fi
