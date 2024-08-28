#!/bin/bash

# Install Krew
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed 's/x86_64/amd64/' | sed 's/arm.*$/arm/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

# Add Krew to PATH for Fish shell
echo 'set -gx PATH $HOME/.krew/bin $PATH' >> ~/.config/fish/config.fish

# Reload Fish configuration (note: this will only affect future sessions)
fish -c 'source ~/.config/fish/config.fish'
