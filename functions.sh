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

install_whiptail(){
    sudo apt-get install -y whiptail
}

install_suckless(){
    rm -r -f ~/dev/is/tmp/suckless
    mkdir -p ~/dev/is/tmp/suckless

    # st #
    # dependencias st
    sudo apt-get -y install libx11-dev
    sudo apt-get -y install libxft-dev

    git clone https://github.com/nenitf/st.git ~/dev/is/tmp/suckless/st
    cd ~/dev/is/tmp/suckless/st
    sudo make clean install

    # dmenu #
    git clone git://git.suckless.org/dmenu ~/dev/is/tmp/suckless/dmenu
    cd ~/dev/is/tmp/suckless/dmenu
    sudo make clean install

    # dwm #
    sudo apt-get -y install libxinerama-dev
    git clone https://github.com/nenitf/dwm.git ~/dev/is/tmp/suckless/dwm
    cd ~/dev/is/tmp/suckless/dwm
    sudo make clean install
}

install_dotfiles(){
    wget -O - http://neni.dev/dotfiles/lazy.sh | sh
}

install_calcurse(){
    sudo apt-get install -y calcurse
}

install_neomutt(){
    sudo apt-get install -y neomutt
}

install_htop(){
    sudo apt-get install -y htop
}

install_imagemagick(){
    sudo apt-get install -y imagemagick
}

install_mpv(){
    sudo apt-get install -y mpv
}

install_xorg(){
    sudo apt install -y xorg
}

install_pandoc(){
    sudo apt-get install -y pandoc
}

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

install_feh(){
    sudo apt-get install -y feh
}

install_curl(){
    sudo apt-get install -y curl
}

install_urxvt(){
    sudo apt-get install -y rxvt-unicode
}

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

install_browsers(){
    sudo apt install -y firefox
    sudo apt install -y qutebrowser
    sudo apt install -y surf
}

install_nnn(){
    sudo apt-get install -y nnn
}

install_atom(){
    sudo add-apt-repository ppa:webupd8team/atom -y
    #sudo apt-get update
    #sudo apt-get install -y atom
    ARR_INSTALL_OF_PPA=("sudo apt-get install -y atom")
}

install_zathura(){
    sudo apt-get install -y zathura
}

install_scrot(){
    sudo apt-get install -y scrot
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
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    fi
}

install_jdk(){
    sudo -E apt-get install -y oracle-java8-installer
    sudo -E apt-get install -y oracle-java8-set-default
}

install_node(){
    wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
}

install_php(){
    sudo apt-get install -y php
}

install_composer(){
    # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-composer-on-ubuntu-14-04
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
}

install_python3(){
    sudo apt-get install python-software-properties
    sudo apt-get install -y python-dev python-pip python3-dev python3 python3-pip python3-setuptools cmake
    sudo apt install -y python3-flask
    pip3 install flask
    pip3 install --user pynvim
}

install_go(){
    #sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get install -y golang-go
}

install_latex(){
    sudo apt-get install -y texlive-full
}

install_umbrello(){
    sudo apt-get install -y umbrello
}

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
