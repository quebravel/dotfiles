
# .config com configuração do `bspwm` + `sxhkd` + `polybar`.

![bspwm](https://github.com/quebravel/dotfiles-conf/blob/master/gitresize.png?raw=true) 


# Personalizando meu Linux

# fish

## Instalando e configurando fish
```
$ sudo emerge -aq app-shells/fish
$ chsh -s /bin/fish
$ git clone https://github.com/oh-my-fish/oh-my-fish
$ cd oh-my-fish
$ bin/install --offline
$ omf install bobthefish
```

- Mova a config.fish para...

```
mv config.fish .config/fish/
```

# zsh

## Instalando e configurando zsh

```
$ sudo emerge -aq app-shells/zsh                             $ sudo pacman -S extra/zsh
$ sudo emerge -aq app-shells/zsh-completions                 $ sudo pacman -S community/zsh-completions

$ sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```
- Selecione o tema entrando no arquivo:
```
$ vim ~/.zshrc
```
- Na linha `ZSH_THEME="robbyrussell"` troque o robbyrussell por `fino-time`.

> ZSH_THEME="fino-time"

- Deixe o zsh como padrão com o comando:
```
$ chsh -s /bin/zsh
```
# air-line

## Instalando fontes powerline
- Clone o powerline
```
git clone https://github.com/powerline/fonts.git --depth=1
```
- Instale com os comandos:
```
cd fonts && ./install.sh
```
- Remova as pastas desnecessárias
```
cd .. && rm -rf fonts
```

## Colocando o tema air-line no vim
- Clone o airline.
```
$ git clone https://github.com/vim-airline/vim-airline.git
```
- Crie e mova o conteudo da pasta airline para a pasta vim.
```
$ mkdir ~/.vim
$ mv vim-airline/* ~/.vim
```
- Crie o arquivo `.vimrc`.
```
$ vim .vimrc
```
- Adicione no arquivo:
> let g:airline_powerline_fonts = 1
- Baixe o pip
```
$ sudo emerge -aq dev-python/pip                             $ sudo pacman -S extra/python-pip
```
- Baixe o powerline status e font com o pip
```
$ pip install --user powerline-status
$ pip install --user git+git://github.com/powerline/powerline
```
- Baixe os símbolos, font, powerline e a configuração com o comando
```
$ wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
$ wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
$ git clone https://github.com/powerline/fonts --depth=1
$ cd /fonts
$ ./install.sh
```
- Mova e aponte os arquivos para as seguintes pastas
```
$ mv PowerlineSymbols.otf ~/.local/share/fonts/
$ fc-cache -vf ~/.local/share/fonts/
$ sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
```
- para ter o tema quando usar o sudo copie as pastas e o .vimrc para pasta root
###### Obs: Não esqueça de modificar o `nomeUsuario` pelo nome do usuário.
```
$ sudo su
$ cp /home/nomeUsuario/.vimrc /root
```
# Xresources

###### Configuração do terminal `xterm`.

- Copie a configuração do arquivo [Xresources](https://github.com/Quebravel/zsh-airline-Xresources/blob/master/.Xresources) e cole na pasta do usuário.


# Outras configurações

### ranger

- Comando para o ranger copiar os arquivos de configurações e ativar os plugs.
```
ranger --copy-config=all
```
- Modifique a linha que contem `set preview_images false` de `false` para `true` no final. No seguinte arquivo:
```
vim .config/ranger/rc.conf
```


### vim syntax

###### Ativando a syntax do vim no Arch Linux e ligando as cores solarized
- Instale o `vim-syntastic`.
```
$ sudo pacman -S community/vim-syntastic
```
- Adicione as linhas em `~/.vimrc` contendo o comando abaixo para a syntax e a númeração de linha ser ativada como padrão .
```
" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
syntax enable "ativando syntax
set laststatus=2
set nu! "ativando númeração de linha
colorscheme solarized "cores solarized
set background=dark "dark/light
" ------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:solarized_bold=1            "valor padrão é 1
let g:solarized_underline=1       "valor padrão é 1
let g:solarized_italic=1          "valor padrão é 1
let g:solarized_termcolors=256    "valor padrão é 16
let g:solarized_contrast="high"   "valor padrão é normal
let g:solarized_visibility="high" "valor padrão é normal
let g:solarized_diffmode="high"   "valor padrão é normal

" ------------------------------------------------------------------
 let g:solarized_termtrans=0
 let g:solarized_degrade=1
 let g:solarized_hitrail=0
 let g:solarized_menu=1
```
### Vim Solarized

- [Git para adicionar a coloração](https://github.com/altercation/vim-colors-solarized)

## Configuração do teclado gentoo/arch

### gentoo
- Instale
```
$ emerge -aq x11-apps/setxkbmap
```

- Crie um arquivo chamado `30-keyboard.conf` no xorg
```
$ sudo vim -w /etc/X11/xorg.conf.d/30-keyboard.conf
```
- Dentro digite:
```
Section "InputClass"
	Identifier "keyboard-all"
	Driver "evdev"
	Option "XkbLayout" "br"
	Option "XkbVariant" ",abnt2"
	Option "XkbOptions" "grp:shift_toggle,grp_led:scroll"
EndSection
```
- Adicione ao boot
```
rc-update add keymaps boot
```

###  arch
- Crie um arquivo chamado `00-keyboard.conf` no xorg
```
$ sudo nano /etc/X11/xorg.conf.d/00-keyboard.conf 
```
- Dentro digite:
```
Section "InputClass"
	Identifier "system-keyboard"
	MatchIsKeyboard "on"
	Option "XkbLayout" "br"
	Option "XkbVariant" ",abnt2"
	Option "XkbOptions" "grp:shift_toggle,grp_led:scroll"
EndSection
```

## Pacotes adicionais
- extrair pacotes gentoo/arch

```
$ sudo emerge -aq app-arch/arj                              $ sudo pacman -S community/arj
$ sudo emerge -aq app-arch/lha                              $ sudo pacman -S aur/lha
$ sudo emerge -aq app-arch/p7zip                            $ sudo pacman -S extra/p7zip
$ sudo emerge -aq app-arch/rar                              $ sudo pacman -S aur/rar
$ sudo emerge -aq app-arch/file-roller                      $ sudo pacman -S extra/file-roller
$ sudo emerge -aq app-arch/unzip                            $ sudo pacman -S extra/unzip
$ sudo emerge -aq app-arch/zip                              $ sudo pacman -S extra/zip
```

- formartar discos gentoo/arch
```
$ sudo emerge -aq sys-fs/dosfstools                         $ sudo pacman -S core/dosfstools
$ sudo emerge -aq sys-fs/ntfs3g                             $ sudo pacman -S extra/ntfs-3g

```

## Corrigindo fonte no Java 
- edite o arquivo `environment`
```
$ sudo vim /etc/environment
```
- adicione a linha

> _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'

## eix gentoo/funtoo
- instale o pacote:
```
$ sudo emerge app-portage/eix
$ sudo eix-update
```
- modifique o arquivo `00-eixrc` em:
```
$ sudo vim /etc/eixrc/00-eixrc
```
- adicione na ultima linha:
```
TERM_ALT1_ADD=rxvt
BG0=none
BG1=none
BG2=none
BG3=none
#SOLARIZED=true
```
