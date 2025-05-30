# Some variables to make coloring easier.

# Copyright © <https://stackoverflow.com/a/28938235/10967642>.

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black_Code='30'
Red_Code='31'
Green_Code='32'
Yellow_Code='33'
Blue_Code='34'
Purple_Code='35'
Cyan_Code='36'
White_Code='37'

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
Bold='\033[1m'            # Bold
Bold_Off='\033[22m'       # Bold Reset
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Dark
Dark='\033[2m'            # Dark
Dark_Off='\033[22m'       # Dark Reset
DBlack='\033[2;30m'       # Black
DRed='\033[2;31m'         # Red
DGreen='\033[2;32m'       # Green
DYellow='\033[2;33m'      # Yellow
DBlue='\033[2;34m'        # Blue
DPurple='\033[2;35m'      # Purple
DCyan='\033[2;36m'        # Cyan
DWhite='\033[2;37m'       # White

# Underline
Underline='\033[4m'       # Underline
Underline_Off='\033[24m'  # Underline Reset
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

ANSI_ESC='\x1b\['
ANSI_ESC_ESC='\\\033\['
ANSI_NO_DECOLOR='(4|24)m'

decolor() {
	sed -r 's/('"${ANSI_ESC}|${ANSI_ESC_ESC}"')('"${ANSI_NO_DECOLOR}"')/\1%%%\2/g' \
		| sed -r 's/'"(${ANSI_ESC}|${ANSI_ESC_ESC})"'[0-9;]+m//g' \
		| sed -r 's/('"${ANSI_ESC}|${ANSI_ESC_ESC}"')%%%('"${ANSI_NO_DECOLOR}"')/\1\2/g'
}

recolor() {
	local new_color="${1:?}"
	sed -r 's/('"${ANSI_ESC}|${ANSI_ESC_ESC}"')('"${ANSI_NO_DECOLOR}"')/\1%%%\2/g' \
		| sed -r 's/'"(${ANSI_ESC}|${ANSI_ESC_ESC})"'([0-9]+;)[0-9]+(m)/\1\2'"${new_color}"'\3/g' \
		| sed -r 's/'"(${ANSI_ESC}|${ANSI_ESC_ESC})"'0m/\1'"0;${new_color}m"'/g' \
		| sed -r 's/('"${ANSI_ESC}|${ANSI_ESC_ESC}"')%%%('"${ANSI_NO_DECOLOR}"')/\1\2/g' \
		| sed -r 's/(.+)/'"${ANSI_ESC}0;${new_color}m"'\1'"${ANSI_ESC}0m"'/'
}

fg-black() {
	printf "${Black}%s${Color_Off}" "$*"
}
fg-red() {
	printf "${Red}%s${Color_Off}" "$*"
}
fg-green() {
	printf "${Green}%s${Color_Off}" "$*"
}
fg-yellow() {
	printf "${Yellow}%s${Color_Off}" "$*"
}
fg-blue() {
	printf "${Blue}%s${Color_Off}" "$*"
}
fg-purple() {
	printf "${Purple}%s${Color_Off}" "$*"
}
fg-cyan() {
	printf "${Cyan}%s${Color_Off}" "$*"
}
fg-white() {
	printf "${White}%s${Color_Off}" "$*"
}

bg-black() {
	printf "${On_Black}%s${Color_Off}" "$*"
}
bg-red() {
	printf "${On_Red}%s${Color_Off}" "$*"
}
bg-green() {
	printf "${On_Green}%s${Color_Off}" "$*"
}
bg-yellow() {
	printf "${On_Yellow}%s${Color_Off}" "$*"
}
bg-blue() {
	printf "${On_Blue}%s${Color_Off}" "$*"
}
bg-purple() {
	printf "${On_Purple}%s${Color_Off}" "$*"
}
bg-cyan() {
	printf "${On_Cyan}%s${Color_Off}" "$*"
}
bg-white() {
	printf "${On_White}%s${Color_Off}" "$*"
}
