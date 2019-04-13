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
#   Lubuntu 18.10 em:
#   Xubuntu 18.10 em:
# ---------------------------------------------------------- #
# Agradecimentos:
#
# Repositorio i3buntu:
#   https://github.com/mstaal/i3buntu
#
# DioLinux:
#
# Matheus Muller:
#   https://www.udemy.com/shell-script-do-basico-ao-profissional/
# ---------------------------------------------------------- #

# ------------------------- IMPORT ------------------------- #
source ./config.sh
# ---------------------------------------------------------- #

# ------------------------- TESTES ------------------------- #

# ---------------------------------------------------------- #

# ------------------------- FUNÇÕES ------------------------ #
instalaWhiptail(){
    sudo apt-get install -y whiptail
}

instalaReq(){
    # dio
    sudo apt install -y xorg # parte grafica do sistema
    sudo apt install -y slim # gerenciador de login
    sudo apt install -y firefox
    sudo apt install -y nitrogen # gerenciador de background
    nitrogen --set-auto dev/mei4d2u/images/wallpaper.jpg

    # mstaal
    sudo apt-get install -y ubuntu-drivers-common
    sudo apt-get install -y libnm-gtk-common
    sudo apt-get install -y arandr # monitor display
    sudo apt-get install -y pavucontrol pulseaudio-module-x11 # pulseaudio
    sudo apt-get install -y network-manager
    sudo apt-get install network-manager-gnome
    sudo apt-get install -y wireless-tools # iwconfig
    sudo apt-get install wicd-gtk # gtk janela de wifi
    sudo apt-get install -y net-tools # ifconfig
    sudo apt-get install -y i3 i3-wm i3blocks i3lock i3status
    transmission-gtk
}

cenarioBase(){
    logCenario "BASE"

    instalaReq

    #logAcao "INSTALANDO WGET"
    #sudo apt-get install -y wget

    logAcao "INSTALANDO CURL"
    sudo apt-get install -y curl

    logAcao "INSTALANDO URXVT"
    sudo apt-get install -y rxvt-unicode

    logAcao "INSTALANDO VIM"
    sudo apt-get install -y vim
    sudo apt-get install -y exuberant-ctags

    logAcao "INSTALANDO ATOM"
    sudo add-apt-repository -y ppa:webupd8team/atom
    sudo apt-get update
    sudo apt-get install -y atom

    logAcao "INSTALANDO EVINCE"
    sudo apt-get install -y evince evince-common
    # https://www.raspberrypi.org/forums/viewtopic.php?t=196070
    #(evince:14932): dbind-WARNING **: 05:14:44.336: Error retrieving accessibility bus address: org.freedesktop.DBus.Error.ServiceUnknown: The name org.a11y.Bus was not provided by any .service files
    sudo apt-get install -y at-spi2-core

    logAcao "INSTALANDO SCROT"
    sudo apt-get install -y scrot

    logAcao "INSTALANDO TEMAS"

    logAcao "LINKANDO DOTFILES"
    wget -O - http://neni.dev/dotfiles/lazy.sh | sh
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
    sudo apt-get install -y python3 python3-pip python3-dev cmake
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
    #https://matheuslima.com.br/como-instalar-o-postman-no-ubuntu
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
    sudo add-apt-repository ppa:inkscape.dev/stable
    sudo apt-get update
    sudo apt-get install inkscape

    logAcao "INSTALANDO GIMP"
    sudo add-apt-repository ppa:otto-kesselgulasch/gimp
    sudo apt-get update
    sudo apt-get install gimp gimp-gmic gmic
    sudo apt-get install gimp-plugin-registry
}

# ---------------------------------------------------------- #

# -------------------------- MAIN -------------------------- #
instalaWhiptail

[ "$1" = "-t" ] && TEST_MODE=true

whiptail --title "mei4d2u" --checklist --separate-output \
    "↓, ↑, <space>, <tab> and <enter> to confirm"\
    20 70 12 \
    "dev-java" "" OFF \
    "dev-node" "" ON \
    "dev-php" "" ON \
    "dev-python3" "" ON \
    "dev-go" "" ON \
    "dev-extra" "pandoc, latex, postman e umbrello" ON \
    "user-extra" "discord, calibre, inkscape e gimp" OFF \
    2>logwhiptail

# teste para ver se o arquivo está vazio
if [ -s logwhiptail ]
then
    cenarioBase

    # ler e executar cenarios escolhidos
    while read choice
    do
        case $choice in
            dev-java) cenarioJava
                ;;
            dev-node) cenarioNode
                ;;
            dev-php) cenarioPHP
                ;;
            dev-python3) cenarioPython3
                ;;
            dev-go) cenarioGo
                ;;
            dev-extra) cenarioDevExtra
                ;;
            user-extra) cenarioUserExtra
                ;;
        esac
    done < logwhiptail
    logAcao "UPDATE"
    sudo -E apt-get update
else
    logAcao "CANCELADO"
fi

# ---------------------------------------------------------- #
