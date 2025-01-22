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

LOGGER_MARGIN="        "

trace() {
	if (( $LOG_TRACE )); then
		printf "${DPurple}[${Purple}TRACE${DPurple}]${Color_Off} $(format_secondary "$@")\n" >&2
	fi
}
debug() {
	if (( $LOG_DEBUG )); then
		printf "${DWhite}[${White}DEBUG${DWhite}]${Color_Off} ${Black}${On_Yellow}$(decolor <<< "$@")${Color_Off}\n" >&2
	fi
}
info() {
	if (( $LOG_INFO )); then
		printf " ${DBlue}[${Blue}INFO${DBlue}]${Color_Off} $@\n" >&2
	fi
}
warn() {
	if (( $LOG_WARN )); then
		printf " ${DYellow}[${Yellow}WARN${DYellow}]${Color_Off} ${Yellow}$(decolor <<< "$@")${Color_Off}\n" >&2
	fi
}
error() {
	printf "${DRed}[${Red}ERROR${DRed}]${Color_Off} ${Red}$(decolor <<< "$@")${Color_Off}\n" >&2
}
success() {
	printf "   ${DGreen}[${Green}OK${DGreen}]${Color_Off} $@\n" >&2
}
question() {
	printf "  ${DCyan}[${Cyan}???${DCyan}]${Color_Off} $@\n" >&2
}
dry_run() {
	# NOTE: Remove leading underscore-prefixed functions, to avoid logging things like `log_as_info_`.
	local command=$(echo "$@" | sed -E 's/^([a-zA-Z0-9_]*_ )+//')
	if (( $LOG_DRY_RUN )); then
		printf "${DWhite}[${White}DRY_RUN${DWhite}]${Color_Off} sh> $(format_secondary $command)\n" >&2
	fi
}

log_as_trace_() {
	( set -o pipefail; "$@" 2>&1 | while read -r line; do trace "$line"; done)
}
log_as_debug_() {
	( set -o pipefail; "$@" 2>&1 | while read -r line; do debug "$line"; done)
}
log_as_info_() {
	( set -o pipefail; "$@" 2>&1 | while read -r line; do info "$line"; done)
}
log_as_warn_() {
	( set -o pipefail; "$@" 2>&1 | while read -r line; do warn "$line"; done)
}
log_as_error_() {
	( set -o pipefail; "$@" 2>&1 | while read -r line; do error "$line"; done)
}
log_as_success_() {
	( set -o pipefail; "$@" 2>&1 | while read -r line; do success "$line"; done)
}
