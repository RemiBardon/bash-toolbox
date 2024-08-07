# Some functions to help formatting.

source "${BASH_TOOLBOX-"$(dirname "$0")"}"/colors.sh

format_secondary() {
	printf '%s' "${DWhite}$(decolor <<< $*)${Color_Off}"
}
format_url() {
	printf '%s' "${Underline}$(decolor <<< $*)${Underline_Off}"
}
format_code() {
	printf '%s' "${Cyan}\`$(decolor <<< $*)\`${Color_Off}"
}
format_command() {
	printf '%s' "${BCyan}$(decolor <<< $*)${Color_Off}"
}
format_flag() {
	printf '%s' "${BCyan}$(decolor <<< $*)${Color_Off}"
}
format_arg() {
	printf '%s' "${Cyan}$(decolor <<< $*)${Color_Off}"
}
format_opt_arg() {
	printf '%s' "${Cyan}[$(decolor <<< $*)]${Color_Off}"
}

format_title() {
	printf '%s' "${BGreen}$(decolor <<< $*)${Color_Off}"
}
format_subtitle() {
	printf '%s' "${Green}$(decolor <<< $*)${Color_Off}"
}
