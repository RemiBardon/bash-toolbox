# Some functions to help formatting.

source "${BASH_TOOLBOX-"$(dirname "$0")"}"/colors.sh

format_secondary() {
	printf "${Dark}%s${Dark_Off}" "$(decolor <<< "$@")"
}
format_url() {
	printf "${Underline}%s${Underline_Off}" "$(decolor <<< "$@")"
}
format_hyperlink() {
	if [ "$#" -ne 2 ]; then
		warn "$(format_code format_hyperlink) expects 2 arguments. Got $#." >&2
		printf '%s' '<invalid_hyperlink>'
	fi
	printf "\033]8;;%s\033\\%s\033]8;;\033\\" "$2" "$(decolor <<< $1)"
}
format_code() {
	printf "${DCyan}\`${Cyan}%s${DCyan}\`${Color_Off}" "$(decolor <<< "$@")"
}
format_command() {
	printf "${BCyan}%s${Color_Off}" "$(decolor <<< "$@")"
}
format_flag() {
	printf "${BCyan}%s${Color_Off}" "$(decolor <<< "$@")"
}
format_arg() {
	printf "${Cyan}%s${Color_Off}" "$(decolor <<< "$@")"
}
format_opt_arg() {
	printf "${DCyan}[${Cyan}%s${DCyan}]${Color_Off}" "$(decolor <<< "$@")"
}

format_title() {
	printf "${BGreen}%s${Color_Off}" "$(decolor <<< "$@")"
}
format_subtitle() {
	printf "${UGreen}%s${Color_Off}" "$(decolor <<< "$@")"
}
