#! /usr/bin/env bash
set -e

# Installing packer for nvim
NVIM_PACKER_PATH="${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"
[[ -e "${NVIM_PACKER_PATH}" ]] || git clone --depth 1 "https://github.com/wbthomason/packer.nvim"\
	"${NVIM_PACKER_PATH}"
 
# Installing tpm for tmux
TPM_PATH="${HOME}/.tmux/plugins/tpm"
[[ -e "${TPM_PATH}" ]] || git clone "https://github.com/tmux-plugins/tpm" "${TPM_PATH}"

cd "${HOME}/.dotfiles"
command -v stow && stow --adopt .
