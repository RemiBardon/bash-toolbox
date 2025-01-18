# Some reusable logging functions.

source "${BASH_TOOLBOX-"$(dirname "$0")"}"/colors.sh
source "${BASH_TOOLBOX-"$(dirname "$0")"}"/format.sh

# Add support for GitHub Actions debug logging.
# See <https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/troubleshooting-workflows/enabling-debug-logging#enabling-step-debug-logging>.
if [ -n "${ACTIONS_STEP_DEBUG-}" ]; then LOG_TRACE=1; fi
# Apply defaults.
: ${LOG_TRACE:=0}
: ${LOG_DEBUG:=1}
: ${LOG_INFO:=1}
: ${LOG_WARN:=1}
# Apply inheritance.
if (( $LOG_TRACE )); then LOG_DEBUG=1; fi
if (( $LOG_DEBUG )); then LOG_INFO=1; fi
if (( $LOG_INFO )); then LOG_WARN=1; fi
if (( $DRY_RUN )); then LOG_DRY_RUN=1; fi

LOGGER_MARGIN="          "

trace() {
	(( $LOG_TRACE )) && printf "  ${DWhite}[${Purple}TRACE${DWhite}]${Color_Off} $(format_secondary "$@")\n" >&2 || return 0
}
debug() {
	(( $LOG_DEBUG )) && printf "  ${DWhite}[${White}DEBUG${DWhite}]${Color_Off} ${Black}${On_Yellow}$(decolor <<< "$@")${Color_Off}\n" >&2 || return 0
}
info() {
	(( $LOG_INFO )) && printf "   ${DWhite}[${Blue}INFO${DWhite}]${Color_Off} $@\n" >&2 || return 0
}
warn() {
	(( $LOG_WARN )) && printf "   ${DWhite}[${Yellow}WARN${DWhite}]${Color_Off} ${Yellow}$(decolor <<< "$@")${Color_Off}\n" >&2 || return 0
}
error() {
	printf "  ${DWhite}[${Red}ERROR${DWhite}]${Color_Off} ${Red}$(decolor <<< "$@")${Color_Off}\n" >&2
}
success() {
	printf "     ${DWhite}[${Green}OK${DWhite}]${Color_Off} $@\n" >&2
}
question() {
	printf "    ${DWhite}[${Cyan}???${DWhite}]${Color_Off} $@\n" >&2
}
dry_run() {
	# NOTE: Remove leading underscore-prefixed functions, to avoid logging things like `log_as_info_`.
	local command=$(echo "$@" | sed -E 's/^([a-zA-Z0-9_]*_ )+//')
	(( $LOG_DRY_RUN )) && printf "${DWhite}[${White}DRY_RUN${DWhite}]${Color_Off} sh> $(format_secondary $command)\n" >&2 || return 0
}

log_as_trace_() {
	"$@" 2>&1 | while read -r line; do trace "$line"; done
}
log_as_debug_() {
	"$@" 2>&1 | while read -r line; do debug "$line"; done
}
log_as_info_() {
	"$@" 2>&1 | while read -r line; do info "$line"; done
}
log_as_warn_() {
	"$@" 2>&1 | while read -r line; do warn "$line"; done
}
log_as_error_() {
	"$@" 2>&1 | while read -r line; do error "$line"; done
}
log_as_success_() {
	"$@" 2>&1 | while read -r line; do success "$line"; done
}
