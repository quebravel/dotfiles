
	Lista de alguns atalhos de teclado úteis.
    Mais pode ser encontrado no arquivo ~/.config/sxhkd/sxhkdrc.
    Você também pode editar atalhos de teclado.

    Mod4 é super chave, em muitos teclados marcados com o logotipo do Windows.
    Como regra geral, super + <direction> move o foco,
    super + shift + <direction> move a janela focalizada,
    e super + alt + <direction> redimensiona as janelas.

    Setas, hjkl representam direções e números representam
    espaços de trabalho diferentes.

	### Manipulação de janelas ################################################################################################

        Super + m	                            |- Altera para modo monocle [tela cheia com top barra de status]
        Super + y                               |- Trás a ultima janela focada para o workspace atual.
        Super + g                               |- Trás a maior janela para o workspace atual.
	    Super + t                               |- Coloca a janela em modo normal.
	    Super + s                               |- Coloca a janela em modo flutuante.
	    Super + shift T                         |- Coloca a janela em modo pseudo [a janela travada em modo flutuante.]
	    Super + f                               |- Coloca a janela em tela cheia.
	    Super + ctrl + x                        |- Trava a janela.
	    Super + ctrl + y                        |- Coloca a janela em modo sticky [a janela segue para todos os workspaces]
	    Super + ctrl + z                        |- Coloca a janela em modo privado.
	    Super + n                               |- Vai para a próxima janela.
	    Super + shift + n                       |- Volta para a janela anterior.
	    Super + '                               |- Volta ou/e vai para a janela anterior a nova.
        Super + tab                             |- Volta ou/e vai para o workspace anterior.
	    Super + {i,o}                           |- Navega entre as janelas e workspaces.
	    Super + shift + {0-9}                   |- Move a janela entre os workspaces.
	    Super + ctrl + {h,j,k,l}                |- Pre-seleciona um espaço da janela para adicionar um outro programa.
	    Super + ctrl + spaço                    |- Cancela a Pre-seleção.
	    Super + ctrl + {1-9}                    |- Pre-seleção com tamanhos selecionados.
	    Super + alt + {h,j,k,l}                 |- Redimensiona a janela em modo flutuante.
	    Super + {cima,baixo,direita,esquerda}   |- Move a janela em modo flutuante.

	### Comando do mouse #####################################################################################################

	    Super + drag                            |- Move a janela
	    Super + rightclick drap                 |- redimensiona a janela.

    ### Aplicativos ##########################################################################################################

	    Super + p                               |- Dmenu
	    Super + i                               |- Browser
	    Super + r                               |- File search
	    Super + r                               |- Ranger gerenciador de arquivos
	    Super + Enter                           |- Terminal
        Super + shift + d                       |- Desliga o computador.
        Super + shift + r                       |- Reiniciar o computador.
        Alt + cima                              |- Amplia o som.
        Alt + baixo                             |- Reduz o som.
        Super + alt + cima                      |- Amplia o som além dos 100%.
        Super + alt + baixo                     |- Reduz o som diretamante para os 100% caso enteja acima do mesmo.
        Alt + direita                           |- Almenta o brilho em notebooks.
        Alt + esquerda                          |- Reduz o brilho em notebooks.
        Print                                   |- Tirar um screenshot da tela toda.
        Alt + print                             |- Seleciona com o mouse a área  do screenshot.
        Alt + {+,-}                             |- Almenta ou diminui a área de espaço entre janelas.
        Super + alt + g                         |- Remove ou adiciona espaços entre janelas.
        Super + alt + esc                       |- Sai do bspwm.
        Super + alt + r                         |- Reinicia o bspwm.
        Super + esc                             |- Reinicia o sxhkd.

    Modificado de https://github.com/Chrysostomus/bspwm-scripts/blob/master/bin/keybindings.sh
