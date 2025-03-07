# Some functions to help formatting.

source "${BASH_TOOLBOX-"$(dirname "$0")"}"/colors.sh

format_secondary() {
	printf '%s' "${Dark}$(decolor <<< "$@")${Dark_Off}"
}
format_url() {
	printf '%s' "${Underline}$(decolor <<< "$@")${Underline_Off}"
}
format_hyperlink() {
	if [ "$#" -ne 2 ]; then
		warn "$(format_code format_hyperlink) expects 2 arguments. Got $#." >&2
		printf '<invalid_hyperlink>'
	fi
	printf '%s' "\033]8;;$2\033\\$(decolor <<< $1)\033]8;;\033\\"
}
format_code() {
	printf '%s' "${DCyan}\`${Cyan}$(decolor <<< "$@")${DCyan}\`${Color_Off}"
}
format_command() {
	printf '%s' "${BCyan}$(decolor <<< "$@")${Color_Off}"
}
format_flag() {
	printf '%s' "${BCyan}$(decolor <<< "$@")${Color_Off}"
}
format_arg() {
	printf '%s' "${Cyan}$(decolor <<< "$@")${Color_Off}"
}
format_opt_arg() {
	printf '%s' "${DCyan}[${Cyan}$(decolor <<< "$@")${DCyan}]${Color_Off}"
}

format_title() {
	printf '%s' "${BGreen}$(decolor <<< "$@")${Color_Off}"
}
format_subtitle() {
	printf '%s' "${UGreen}$(decolor <<< "$@")${Color_Off}"
}
