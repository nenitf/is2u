# ---------------------------------------------------------- #
# Funções utilizadas em install.sh
# Arquivo criado para manter histórico e comentários sobre
# como baixar softwares que são ou já foram importantes.
# ---------------------------------------------------------- #

DIR_INSTALLATION=$HOME/dev/is
ARQUITETURA=`uname -m`                  # 64 ou 32
DISTRO=$(lsb_release -i | cut -f 2-)    # Ubuntu
INTERFACE_GRAFICA=$XDG_CURRENT_DESKTOP  # LXDE

# Array de instalações a partir de PPA
declare -a ARR_INSTALL_OF_PPA=()
# evitar multiplos updates desnecessarios
install_all_from_ppa(){
    sudo apt-get update
    for i in "${ARR_INSTALL_OF_PPA[@]}"
    do
        echo `$i`
    done
}

# Caixas de dialogo do script
install_whiptail(){
    sudo apt-get install -y whiptail
}

###########################
# BASE
###########################

install_suckless(){
    rm -r -f $DIR_INSTALLATION/tmp/suckless
    mkdir -p $DIR_INSTALLATION/tmp/suckless

    sudo apt install -y build-essential				            # gcc, make and other tools for sources compiling
    sudo apt install -y libx11-dev libxinerama-dev libxft-dev	# Development headers, required for dwm and dmenu building
    sudo apt install -y libxinerama1   # Xinerama extension for X protocol (multiple screens attached to a single display)

    # st #
    # dependencias st
    sudo apt-get -y install libx11-dev
    sudo apt-get -y install libxft-dev

    git clone https://github.com/nenitf/st.git $DIR_INSTALLATION/tmp/suckless/st
    cd $DIR_INSTALLATION/tmp/suckless/st
    sudo make clean install

    # dmenu #
    git clone git://git.suckless.org/dmenu $DIR_INSTALLATION/tmp/suckless/dmenu
    cd $DIR_INSTALLATION/tmp/suckless/dmenu
    sudo make clean install

    # dwm #
    #sudo apt-get -y install libxinerama-dev
    #sudo apt install -y libxft2        # Font drawing library for X
    git clone https://github.com/nenitf/dwm.git $DIR_INSTALLATION/tmp/suckless/dwm
    cd $DIR_INSTALLATION/tmp/suckless/dwm
    sudo make clean install
}

install_dotfiles(){
    wget -O - http://neni.dev/dotfiles/lazy.sh | sh
}

# Mail client
install_neomutt(){
    sudo apt-get install -y neomutt
}

install_xclip(){
    sudo apt-get install -y xclip
}

install_htop(){
    sudo apt-get install -y htop
}

install_unrar(){
    sudo apt-get install unrar
}

install_imagemagick(){
    sudo apt-get install -y imagemagick
}

# Player de vídeo com youtube
install_mpv(){
    sudo apt-get install -y mpv
    # youtube dl to play in mpv....
    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
}

# Biblioteca de musicas
install_cmus(){
    sudo apt-get install -y cmus
}

# Editor de tags de musica
install_id3v2(){
    sudo apt-get install -y id3v2
}

# Screen recorder
install_ffmpeg(){
    sudo apt-get install -y ffmpeg
}

# Interpretador de .dot .gv
install_graphviz(){
    sudo apt-get install -y graphviz
}

install_xorg(){
    sudo apt install -y xorg
}

# Transpilador de markdown para pdf
install_pandoc(){
    sudo apt-get install -y pandoc
}

# Uteis para manutenção de rede/internet
install_conectivity(){
    sudo apt-get install -y network-manager network-manager-gnome
    # iwconfig
    sudo apt-get install -y wireless-tools
    # ifconfig
    sudo apt-get install -y net-tools
    # gtk janela de wifi
    #sudo apt-get install -y wicd-gtk
}

install_config_audio(){
    sudo apt-get install -y pavucontrol pulseaudio-module-x11 pulseaudio csound-utils
}

install_arandr(){
    sudo apt-get install -y arandr
}

# Visualizador de imagens e gerenciador de background
install_feh(){
    sudo apt-get install -y feh
}

install_curl(){
    sudo apt-get install -y curl
}

# Icones svg no sistena
install_all_fonts(){
    git clone https://github.com/ryanoasis/nerd-fonts.git $DIR_INSTALLATION/tmp/nerd-fonts
    .$DIR_INSTALLATION/tmp/nerd-fonts/install.sh
}

install_nvim(){
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    #sudo apt-get update
    #sudo apt-get install -y neovim
    ARR_INSTALL_OF_PPA=("sudo apt-get install -y neovim")
    sudo apt-get install -y exuberant-ctags
    # neovim como editor sempre que possivel
    # https://github.com/neovim/neovim/wiki/Installing-Neovim
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi --skip-auto
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim --skip-auto
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor --skip-auto
    nvim -c PlugInstall -c qall teste.txt
}

install_termlab(){
    curl -s https://raw.githubusercontent.com/lighttiger2505/lab/master/install.sh | bash
}

install_termhub(){
    mkdir -p "$GOPATH"/src/github.com/github
    git clone --config transfer.fsckobjects=false --config receive.fsckobjects=false --config fetch.fsckobjects=false https://github.com/github/hub.git "$GOPATH"/src/github.com/github/hub
    cd "$GOPATH"/src/github.com/github/hub
    sudo make install prefix=/usr/local
}

install_browsers(){
    sudo apt install -y firefox
    sudo apt install -y qutebrowser
    sudo apt install -y surf
}

# File manager
install_fff(){
    # sudo apt-get install -y xdotool w3m-img # feh is better!
    git clone https://github.com/dylanaraps/fff $DIR_INSTALLATION/tmp/fff
    cd $DIR_INSTALLATION/tmp/fff
    sudo make install
}

install_atom(){
    sudo add-apt-repository ppa:webupd8team/atom -y
    #sudo apt-get update
    #sudo apt-get install -y atom
    ARR_INSTALL_OF_PPA=("sudo apt-get install -y atom")
}

install_zathura(){
    # pdf, cbr (comics), post script and djvu
    sudo apt-get install -y zathura zathura-cb zathura-ps zathura-djvu
}

install_git_flow(){
    sudo apt-get install -y git-flow
}

install_docker(){
    # docker instalavel somente em x64
    if [ ${ARQUITETURA} == 'x86_64' ]; then
        log_info_action "INSTALANDO DOCKER"
        sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
    fi
}


###########################
# JAVA
###########################

install_jdk(){
    sudo -E apt-get install -y oracle-java8-installer
    sudo -E apt-get install -y oracle-java8-set-default
}


###########################
# NODE
###########################

install_node(){
    wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
}


###########################
# PHP
###########################

install_php(){
    sudo apt-get install -y php
}

install_composer(){
    # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-composer-on-ubuntu-14-04
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
}


###########################
# PYTHON
###########################

install_python3(){
    sudo apt-get install python-software-properties
    sudo apt-get install -y python-dev python-pip python3-dev python3 python3-pip python3-setuptools cmake
    sudo apt install -y python3-flask
    pip3 install flask
    pip3 install --user pynvim
}


###########################
# GO
###########################

install_go(){
    #sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get install -y golang-go
}


###########################
# DEV EXTRA
###########################

install_latex(){
    sudo apt-get install -y texlive-full
}


###########################
# USER EXTRA
###########################

install_discord(){
    #https://www.edivaldobrito.com.br/discord-no-ubuntu-debian-mint/
    wget "https://discordapp.com/api/download?platform=linux&format=deb" -O discord.deb
    sudo dpkg -i discord.deb
    sudo apt-get install -f
    rm discord.deb
}

install_calibre(){
    #https://www.edivaldobrito.com.br/instalar-o-calibre-no-linux/
    sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
}

install_inkscape(){
    sudo add-apt-repository ppa:inkscape.dev/stable -y
    #sudo apt-get update
    #sudo apt-get install -y inkscape
    ARR_INSTALL_OF_PPA=("sudo apt-get install -y inkscape")
}

install_gimp(){
    sudo add-apt-repository ppa:otto-kesselgulasch/gimp -y
    #sudo apt-get update
    #sudo apt-get install -y gimp gimp-gmic gmic
    #sudo apt-get install -y gimp-plugin-registry
    ARR_INSTALL_OF_PPA=("sudo apt-get install -y gimp gimp-gmic gmic gimp-plugin-registry")
}

install_transmission(){
    sudo apt-get install -y transmission-gtk
}
