#!/usr/bin/env bash
#
# install.sh - Padrão de instalação inicial no linux
#
# Site:             neni.dev/mei4d2u
# Autor/Mantenedor: Felipe Silva - github.com/nenitf
# ---------------------------------------------------------- #
# Esse sript instala pacotes para Ubuntu
# ---------------------------------------------------------- #
# Agradecimentos:
#
# Repositorio i3buntu:
#   https://github.com/mstaal/i3buntu
#
# Matheus Muller:
#   https://www.udemy.com/shell-script-do-basico-ao-profissional/
# ---------------------------------------------------------- #

# ---------------------- VAR GLOBAIS ----------------------- #
DIR_INSTALLATION=$HOME/dev/is 
# ---------------------------------------------------------- #

# ------------------------ IMPORTS ------------------------- #
. $DIR_INSTALLATION/functions.sh
. $DIR_INSTALLATION/logs.sh
# ---------------------------------------------------------- #

# ------------------------- FUNÇÕES ------------------------ #
option_base(){
  log_info_option "BASE"

  # para poder add ppa
  sudo apt-get install -y software-properties-common

  sudo apt-get install -y ubuntu-drivers-common
  sudo apt-get install -y libnm-gtk-common

  # local onde serão clonados repositorios
  mkdir -p $DIR_INSTALLATION/tmp

  log_info_action "LINKANDO DOTFILES"
  install_dotfiles

  log_info_action "INSTALANDO GRAPHVIZ"
  install_graphviz

  log_info_action "INSTALANDO VIM" 
  install_vim

  log_info_action "INSTALANDO CURL"
  install_curl

  log_info_action "INSTALANDO DOCKER"
  install_docker
}

option_java(){
  log_info_option "JAVA"

  log_info_action "INSTALANDO JDK"
  install_jdk
}

option_node(){
  log_info_option "NODE"

  log_info_action "INSTALANDO NODE"
}

option_php(){
  log_info_option "PHP"

  log_info_action "INSTALANDO PHP"
  install_php

  log_info_action "INSTALANDO COMPOSER"
  install_composer
}

option_python3(){
  log_info_option "INSTALANDO PYTHON3"

  log_info_action "INSTALANDO PYTHON3"
  install_python3
}

option_go(){
  log_info_option "GO"

  log_info_action "INSTALANDO INSTALANDO GO"
  install_go
}

option_dev_extra(){
  log_info_option "EXTRA PARA DESENVOLVIMENTO"

  log_info_action "INSTALANDO LATEX"
  install_latex
}

option_user_extra(){
  log_info_option "CONFIGURAÇÕES CASUAIS EXTRAS"

  log_info_action "INSTALANDO INKSCAPE"
  install_inkscape

  log_info_action "INSTALANDO GIMP"
  install_gimp

  log_info_action "INSTALANDO TRANSMISSION"
  install_transmission

  log_info_action "INSTALANDO FFMPEG"
  install_ffmpeg

  log_info_action "INSTALANDO FEH" 
  install_feh

  log_info_action "INSTALANDO ZATHURA"
  install_zathura
}
# ---------------------------------------------------------- #

# -------------------------- MAIN -------------------------- #
install_whiptail

whiptail --title "IS2UM" --checklist --separate-output \
  "↓, ↑, <space>, <tab> and <enter> to confirm"\
  20 70 12 \
  "dev-java" "" OFF \
  "dev-node" "" OFF \
  "dev-php" "" ON \
  "dev-python3" "" ON \
  "dev-go" "" ON \
  "dev-extra" "latex e umbrello" OFF \
  "user-extra" "discord, calibre, inkscape e gimp" OFF \
  2>logwhiptail.txt

exitstatus=$?
if [ $exitstatus = 0 ]; then
  option_base

  # ler e executar cenarios escolhidos
  while read choice
  do
    case $choice in
      "dev-java")
        option_java
        ;;
      "dev-node")
        option_node
        ;;
      "dev-php")
        option_php
        ;;
      "dev-python3")
        coption_python3
        ;;
      "dev-go")
        option_go
        ;;
      "dev-extra")
        option_dev_extra
        ;;
      "user-extra")
        option_user_extra
        ;;
    esac
  done < logwhiptail.txt
  log_info_action "UPDATE / CLEAN"
  install_all_from_ppa
  sudo -E apt-get update
  sudo aptget autoremove
  sudo apt-get autoclean
  sudo apt-get clean
  log_info_action "INSTALAÇÃO TERMINADA!"
else
  log_warn "CANCELADO"
fi
