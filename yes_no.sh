ask_yes_no() {
	question "${1:?}"
	local yes_no_default="${2:?}" yes_no_answer

	choices() {
		case "${yes_no_default}" in
			y|Y) echo 'Y|n' ;;
			n|N) echo 'y|N' ;;
			*) echo 'y|n' ;;
		esac
	}

	printf "${LOGGER_MARGIN}${BCyan}Answer ($(choices)): "
	read -n 1 yes_no_answer
	printf "${Color_Off}\n"
	case "${yes_no_answer:-"${yes_no_default}"}" in
		y|Y) return 0 ;;
		n|N|*) return 1 ;;
	esac
}

if_yes() {
	local q="${1:?}"
	local yes_no_default="${2:?}"
	shift 2
	ask_yes_no "$q" "$yes_no_default" && edo $@
}
