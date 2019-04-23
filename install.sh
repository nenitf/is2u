#!/usr/bin/env bash
#
# install.sh - Padrão de instalação inicial no linux
#
# Site:             neni.dev/mei4d2u
# Autor/Mantenedor: Felipe Silva - github.com/nenitf
# ---------------------------------------------------------- #
# Esse sript instala pacotes para Ubuntu
# ---------------------------------------------------------- #
# bash --version #versão do bash
#   4.4.19
#
# Sistema operacional:
#   Ubuntu minimal 18.10 em:
#   Xubuntu 18.10 em:
# ---------------------------------------------------------- #
# Agradecimentos:
#
# Repositorio i3buntu:
#   https://github.com/mstaal/i3buntu
#
# Matheus Muller:
#   https://www.udemy.com/shell-script-do-basico-ao-profissional/
# ---------------------------------------------------------- #

# -------------------------- LOG --------------------------- #
ARQUITETURA=`uname -m`                  # 64 ou 32
DISTRO=$(lsb_release -i | cut -f 2-)    # Ubuntu
INTERFACE_GRAFICA=$XDG_CURRENT_DESKTOP  # LXDE

# cores
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
NC='\e[39m' # No Color
WHITE='\e[97m'

BG_NC='\e[49m' # No Color
BG_RED='\e[41m'
BG_PURPLE='\e[45m'
BG_BLUE='\e[44m'

# parametros em shell:
# https://www.vivaolinux.com.br/topico/Shell-Script/Passando-parametros-entre-funcoes
logErro (){
    printf "${BG_RED}${WHITE}!!!!!!!!!!!!!!!!!!!!!! $1${BG_NC}${NC}\n"
}

logAcao (){
    printf "${BG_PURPLE}${WHITE}______________________ $1${BG_NC}${NC}\n"
}

logCenario (){
    printf "${BG_BLUE}${WHITE}====================== CENÁRIO $1${BG_NC}${NC}\n"
}
# ---------------------------------------------------------- #

# ------------------------- FUNÇÕES ------------------------ #
instalaWhiptail(){
    sudo apt-get install -y whiptail
}

# Sugestões encontradas na internet
instalaReq(){
    # Sugestão do DioLinux
    # parte grafica do sistema
    sudo apt install -y xorg
    # gerenciador de login
    sudo apt install -y slim
    sudo cp $HOME/dev/mei4d2u/images/wallpaper.jpg /usr/share/slim/themes/debian-lines/background.png
    sudo cp $HOME/dev/mei4d2u/images/wallpaper.jpg /usr/share/slim/themes/debian-softwaves/background.png
    sudo apt install -y nemo
    sudo apt install -y firefox
    sudo apt install -y qutebrowser

    # Sugestão do mstaal no i3buntu
    sudo apt-get install -y ubuntu-drivers-common
    sudo apt-get install -y libnm-gtk-common
    # monitor display
    sudo apt-get install -y arandr
    # pulseaudio
    sudo apt-get install -y pavucontrol pulseaudio-module-x11 pulseaudio
    sudo apt-get install -y network-manager
    sudo apt-get install network-manager-gnome
    # iwconfig
    sudo apt-get install -y wireless-tools
    # gtk janela de wifi
    sudo apt-get install wicd-gtk
    # ifconfig
    sudo apt-get install -y net-tools
    sudo apt-get install -y i3 i3-wm i3blocks i3status
}

# Existem programas que necessitam ser compilados manualmente para atualizar os arquivos de customização
suckless(){
    mkdir -p ~/dev/dotfiles/suckless
    mkdir -p ~/dev/dotfiles/st
    mkdir -p ~/dev/dotfiles/dmenu
    mkdir -p ~/dev/dotfiles/dwm

    # st
    sudo apt-get -y install libx11-dev
    sudo apt-get -y install libxft-dev
    git clone git://git.suckless.org/st ~/dev/dotfiles/suckless/st
    cd ~/dev/dotfiles/suckless/st
    sudo make install clean

    # dmenu 
    git clone git://git.suckless.org/dmenu ~/dev/dotfiles/suckless/dmenu
    cd ~/dev/dotfiles/suckless/dmenu
    sudo make install clean

    # dwm
    sudo apt-get -y install libxinerama-dev
    git clone git://git.suckless.org/dwm ~/dev/dotfiles/dwm
    cd ~/dev/dotfiles/suckless/dwm
    sudo make install clean
}

cenarioBase(){
    logCenario "BASE"

    logAcao "LINKANDO DOTFILES"
    wget -O - http://neni.dev/dotfiles/lazy.sh | sh
    echo "alias cs2='cd ~/dev/mps2u'" >> ~/dev/dotfiles/bash/.aliases

    logAcao "COMPILANDO SUCKLESS"
    suckless

    # para poder add ppa
    sudo apt-get install -y software-properties-common

    instalaReq

    #logAcao "INSTALANDO WGET"
    #sudo apt-get install -y wget

    logAcao "INSTALANDO CURL"
    sudo apt-get install -y curl

    logAcao "INSTALANDO URXVT"
    sudo apt-get install -y rxvt-unicode

    logAcao "INSTALANDO FONTS"
    sudo apt-get install -y fonts-font-awesome

    logAcao "INSTALANDO NEOVIM"
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo apt-get update
    sudo apt-get install -y neovim
    sudo apt-get install -y exuberant-ctags
    # neovim como editor sempre que possivel
    # https://github.com/neovim/neovim/wiki/Installing-Neovim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi --skip-auto
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim --skip-auto
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor --skip-auto

    # logAcao "INSTALANDO RANGER"
    # sudo apt-get install ranger
    # # para ver imagens com a configuração do rc.config
    # ranger --copy-config=scope

    logAcao "INSTALANDO NNN"
    sudo apt-get install -y nnn

    logAcao "INSTALANDO ATOM"
    sudo add-apt-repository ppa:webupd8team/atom -y
    sudo apt-get update
    sudo apt-get install -y atom

    logAcao "INSTALANDO EVINCE"
    sudo apt-get install -y evince evince-common
    # https://www.raspberrypi.org/forums/viewtopic.php?t=196070
    #(evince:14932): dbind-WARNING **: 05:14:44.336: Error retrieving accessibility bus address: org.freedesktop.DBus.Error.ServiceUnknown: The name org.a11y.Bus was not provided by any .service files
    sudo apt-get install -y at-spi2-core

    logAcao "INSTALANDO SCROT"
    sudo apt-get install -y scrot


    logAcao "INSTALANDO GIT_FLOW"
    sudo apt-get install -y git-flow

    # docker instalavel somente em x64
    if [ ${ARQUITETURA} == 'x86_64' ]; then
        logAcao "INSTALANDO DOCKER"
        sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    fi
}

cenarioJava(){
    logCenario "JAVA"

    logAcao "INSTALANDO JDK"
    sudo -E apt-get install -y oracle-java8-installer
    sudo -E apt-get install -y oracle-java8-set-default
}

cenarioNode(){
    logCenario "NODE"

    logAcao "NODE"
    wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
}

cenarioPHP(){
    logCenario "PHP"

    logAcao "INSTALANDO PHP"
    sudo apt-get install -y php

    logAcao "INSTALANDO COMPOSER"
    # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-composer-on-ubuntu-14-04
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
}

cenarioPython3(){
    logCenario "INSTALANDO PYTHON3"

    logAcao "INSTALANDO PYTHON3"
    sudo apt-get install python-software-properties
    sudo apt-get install -y python-dev python-pip python3-dev python3 python3-pip python3-setuptools cmake
    sudo apt install -y python3-flask
    pip3 install flask
    pip3 install --user pynvim
}

cenarioGo(){
    logCenario "GO"

    logAcao "INSTALANDO INSTALANDO GO"
    #sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get install -y golang-go
}

cenarioDevExtra(){
    logCenario "EXTRA PARA DESENVOLVIMENTO"

    logAcao "INSTALANDO PANDOC"
    sudo apt-get install -y pandoc

    logAcao "INSTALANDO LATEX"
    sudo apt-get install -y texlive-full

    logAcao "INSTALANDO POSTMAN"
    # dicas postman: http://agiletesters.com.br/topic/1270/automatizando-testes-de-apis-rest-com-postman-e-newman
    # https://matheuslima.com.br/como-instalar-o-postman-no-ubuntu
    if [ ${ARQUITETURA} == 'x86_64' ]; then
        # 64-bit stuff here
        wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
    else
        # 32-bit stuff here
        wget https://dl.pstmn.io/download/latest/linux32 -O postman.tar.gz
    fi
    sudo tar -xzf postman.tar.gz -C /opt
    rm postman.tar.gz
    sudo ln -s /opt/Postman/Postman /usr/bin/postman

    logAcao "INSTALANDO UMBRELLO"
    sudo apt-get install -y umbrello
}

cenarioUserExtra(){
    logCenario "CONFIGURAÇÕES CASUAIS EXTRAS"

    logAcao "INSTALANDO DISCORD"
    #https://www.edivaldobrito.com.br/discord-no-ubuntu-debian-mint/
    wget "https://discordapp.com/api/download?platform=linux&format=deb" -O discord.deb
    sudo dpkg -i discord.deb
    sudo apt-get install -f
    rm discord.deb

    logAcao "INSTALANDO CALIBRE"
    #https://www.edivaldobrito.com.br/instalar-o-calibre-no-linux/
    sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"

    logAcao "INSTALANDO INKSCAPE"
    sudo add-apt-repository ppa:inkscape.dev/stable -y
    sudo apt-get update
    sudo apt-get install -y inkscape

    logAcao "INSTALANDO GIMP"
    sudo add-apt-repository ppa:otto-kesselgulasch/gimp -y
    sudo apt-get update
    sudo apt-get install -y gimp gimp-gmic gmic
    sudo apt-get install -y gimp-plugin-registry

    logAcao "INSTALANDO TRANSMISSION"
    sudo apt-get install -y transmission-gtk
}

# ---------------------------------------------------------- #

# -------------------------- MAIN -------------------------- #
instalaWhiptail

whiptail --title "mei4d2u" --checklist --separate-output \
    "↓, ↑, <space>, <tab> and <enter> to confirm"\
    20 70 12 \
    "dev-java" "" OFF \
    "dev-node" "" OFF \
    "dev-php" "" ON \
    "dev-python3" "" ON \
    "dev-go" "" ON \
    "dev-extra" "pandoc, latex, postman e umbrello" OFF \
    "user-extra" "discord, calibre, inkscape e gimp" OFF \
    2>logwhiptail.txt

exitstatus=$?
if [ $exitstatus = 0 ]; then
    cenarioBase

    # ler e executar cenarios escolhidos
    while read choice
    do
        case $choice in
            "dev-java")
                cenarioJava
                ;;
            "dev-node")
                cenarioNode
                ;;
            "dev-php")
                cenarioPHP
                ;;
            "dev-python3")
                cenarioPython3
                ;;
            "dev-go")
                cenarioGo
                ;;
            "dev-extra")
                cenarioDevExtra
                ;;
            "user-extra")
                cenarioUserExtra
                ;;
        esac
    done < logwhiptail.txt
    logAcao "UPDATE"
    sudo -E apt-get update
else
    logErro "CANCELADO"
fi
# ---------------------------------------------------------- #
