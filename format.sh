# Some functions to help formatting.

source "${BASH_TOOLBOX-"$(dirname "$0")"}"/colors.sh

format_secondary() {
	printf "${DWhite}$*${Color_Off}"
}
format_url() {
	printf "${Underline}$*${Underline_Off}"
}
format_code() {
	printf "${Cyan}\`$*\`${Color_Off}"
}
format_command() {
	printf "${BCyan}$*${Color_Off}"
}
format_flag() {
	printf "${BCyan}$*${Color_Off}"
}
format_arg() {
	printf "${Cyan}$*${Color_Off}"
}
format_opt_arg() {
	printf "${Cyan}[$*]${Color_Off}"
}

format_title() {
	printf "${BGreen}$*${Color_Off}"
}
format_subtitle() {
	printf "${Green}$*${Color_Off}"
}
