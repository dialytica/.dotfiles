#! /usr/bin/env bash
set -e

# Installing tpm for tmux
TPM_PATH="${HOME}/.tmux/plugins/tpm"
[[ -e "${TPM_PATH}" ]] || git clone "https://github.com/tmux-plugins/tpm" "${TPM_PATH}"

cd "${HOME}/.dotfiles"
if [[ $(command -v stow) ]]; then
  stow --adopt .
fi
