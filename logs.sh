# ---------------------------------------------------------- #
# Variáveis e funções utilizadas para informar trechos do
# script install.sh
# ---------------------------------------------------------- #

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
log_warn (){
    printf "${BG_RED}${WHITE}!!!!!!!!!!!!!!!!!!!!!! $1${BG_NC}${NC}\n"
}

log_action_info (){
    printf "${BG_PURPLE}${WHITE}______________________ $1${BG_NC}${NC}\n"
}

log_option_info (){
    printf "${BG_BLUE}${WHITE}====================== CENÁRIO $1${BG_NC}${NC}\n"
}
