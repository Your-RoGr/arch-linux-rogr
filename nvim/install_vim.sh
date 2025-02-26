#!/bin/bash

# root required
if [ "$EUID" -ne 0 ]; then echo "Please run $0 as root." && exit; fi

cd "$(dirname $0)"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo pacman -Sy --noconfirm neovim npm pyright go gopls

# go зависимости
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/kyoh86/richgo@latest
go install golang.org/x/tools/cmd/gorename@latest
go install gotest.tools/gotestsum@latest
go install github.com/segmentio/golines@latest
go install mvdan.cc/gofumpt@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/gonew@latest
go install github.com/cweill/gotests/...@latest

# yay -S impl json-to-struct gomvp mockgen govulncheck go-enum iferr callgraph fillswitch

cp ./init.vim ~/.config/nvim/
cp -r ./lua ~/.config/nvim/
