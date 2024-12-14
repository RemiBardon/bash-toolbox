# Some reusable logging functions.

source "${BASH_TOOLBOX-"$(dirname "$0")"}"/colors.sh
source "${BASH_TOOLBOX-"$(dirname "$0")"}"/format.sh

LOG_TRACE=${LOG_TRACE:-0}
LOG_DEBUG=${LOG_DEBUG:-1}
LOG_INFO=${LOG_INFO:-1}
LOG_WARN=${LOG_WARN:-1}
LOG_DRY_RUN=${LOG_DRY_RUN:-${DRY_RUN}}

LOGGER_MARGIN="          "

trace() {
	(( $LOG_TRACE )) && printf "  ${DWhite}[${Purple}TRACE${DWhite}]${Color_Off} $(format_secondary "$@")\n" || return 0
}
debug() {
	(( $LOG_DEBUG )) && printf "  ${DWhite}[${White}DEBUG${DWhite}]${Color_Off} ${Black}${On_Yellow}$(decolor <<< "$@")${Color_Off}\n" || return 0
}
info() {
	(( $LOG_INFO )) && printf "   ${DWhite}[${Blue}INFO${DWhite}]${Color_Off} $@\n" || return 0
}
warn() {
	(( $LOG_WARN )) && printf "   ${DWhite}[${Yellow}WARN${DWhite}]${Color_Off} ${Yellow}$(decolor <<< "$@")${Color_Off}\n" || return 0
}
error() {
	printf "  ${DWhite}[${Red}ERROR${DWhite}]${Color_Off} ${Red}$(decolor <<< "$@")${Color_Off}\n"
}
success() {
	printf "     ${DWhite}[${Green}OK${DWhite}]${Color_Off} $@\n"
}
question() {
	printf "    ${DWhite}[${Cyan}???${DWhite}]${Color_Off} $@\n"
}
dry_run() {
	# NOTE: Remove leading underscore-prefixed functions, to avoid logging things like `log_as_info_`.
	local command=$(echo "$@" | sed -E 's/^([a-zA-Z0-9_]*_ )+//')
	(( $LOG_DRY_RUN )) && printf "${DWhite}[${White}DRY_RUN${DWhite}]${Color_Off} sh> $(format_secondary $command)\n" || return 0
}

log_as_trace_() {
	"$@" | while read -r line; do trace "$line"; done
}
log_as_debug_() {
	"$@" | while read -r line; do debug "$line"; done
}
log_as_info_() {
	"$@" | while read -r line; do info "$line"; done
}
log_as_warn_() {
	"$@" | while read -r line; do warn "$line"; done
}
log_as_error_() {
	"$@" | while read -r line; do error "$line"; done
}
log_as_success_() {
	"$@" | while read -r line; do info "$line"; done
}
