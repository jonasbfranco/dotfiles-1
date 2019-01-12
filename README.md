# sistematico dotfiles

![screenshot](https://raw.githubusercontent.com/sistematico/dotfiles/master/screenshot.png)

## Requisitos

- Sistema Operacional: `Arch Linux` [link](https://www.archlinux.org)
- Gerenciador de Janelas: `i3-gaps` [link](https://github.com/Airblader/i3)
- Barra: `polybar` [link](https://github.com/jaagr/polybar)
- Shell: `bash` [link](https://www.gnu.org/software/bash/)
- Terminal: `termite` [link](https://github.com/thestinger/termite)
- Editor: `vim` [link](https://www.vim.org/)
- Web Browser: `chromium` [link](http://www.chromium.org/Home)
- Dotfiles: `stow` [link](https://www.gnu.org/software/stow/)

## Instalação Manual(user)

1. Instale o `stow`
2. `cd ~`
3. `git clone https://github.com/sistematico/dotfiles .dotfiles`
4. `cd .dotfiles`
5. `stow i3`
5. `stow polybar`
6. `sudo stow -t /etc etc`

## Instalação Automática

`bash <(curl -s https://raw.githubusercontent.com/sistematico/dotfiles/master/install.sh)`
