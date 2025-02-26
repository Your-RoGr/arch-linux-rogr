#!/bin/bash

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
go install github.com/josharian/impl@latest
go install github.com/golang/mock/mockgen@latest
go install golang.org/x/vuln/cmd/govulncheck@latest
go install github.com/abice/go-enum@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install github.com/tmc/json-to-struct@latest
go install github.com/abenz1267/gomvp@latest
go install github.com/koron/iferr@latest
go install golang.org/x/tools/cmd/callgraph@latest
go install github.com/davidrjenni/reftools/cmd/fillswitch@latest

cp ./init.vim ~/.config/nvim/
cp -r ./lua ~/.config/nvim/

nvim -c 'PlugInstall' -c 'qa!'

