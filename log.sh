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
if (( ${LOG_TRACE:-0} )); then LOG_DEBUG=1; fi
if (( ${LOG_DEBUG:-0} )); then LOG_INFO=1; fi
if (( ${LOG_INFO:-0} )); then LOG_WARN=1; fi
if (( ${DRY_RUN:-0} )); then LOG_DRY_RUN=1; fi

LOGGER_MARGIN="        "

trace_() {
	if (( ${LOG_TRACE:-0} )); then
		printf '%b %s\n' "${DPurple}[${Purple}TRACE${DPurple}]${Color_Off}" "$(format_secondary "$@")" >&2
	fi
}
trace() {
	if [ -z "$*" ]; then return 0; fi
	echo "$@" | while IFS= read -r line; do trace_ "$line"; done
}
debug_() {
	if (( ${LOG_DEBUG:-0} )); then
		printf "%b ${Black}${On_Yellow}%s${Color_Off}\n" "${DWhite}[${White}DEBUG${DWhite}]${Color_Off}" "$(decolor <<< "$@")" >&2
	fi
}
debug() {
	if [ -z "$*" ]; then return 0; fi
	echo "$@" | while IFS= read -r line; do debug_ "$line"; done
}
info_() {
	if (( ${LOG_INFO:-0} )); then
		printf '%b %s\n' " ${DBlue}[${Blue}INFO${DBlue}]${Color_Off}" "$@" >&2
	fi
}
info() {
	if [ -z "$*" ]; then return 0; fi
	echo "$@" | while IFS= read -r line; do info_ "$line"; done
}
warn_() {
	if (( ${LOG_WARN:-0} )); then
		printf "%b ${Red}%s${Color_Off}\n" " ${DYellow}[${Yellow}WARN${DYellow}]${Color_Off}" "$(recolor "${Yellow_Code}" <<< "$@")" >&2
	fi
}
warn() {
	if [ -z "$*" ]; then return 0; fi
	echo "$@" | while IFS= read -r line; do warn_ "$line"; done
}
error_() {
	printf "%b ${Red}%s${Color_Off}\n" "${DRed}[${Red}ERROR${DRed}]${Color_Off}" "$(recolor "${Red_Code}" <<< "$@")" >&2
}
error() {
	if [ -z "$*" ]; then return 0; fi
	echo "$@" | while IFS= read -r line; do error_ "$line"; done
}
success_() {
	printf '%b %s\n' "   ${DGreen}[${Green}OK${DGreen}]${Color_Off}" "$@" >&2
}
success() {
	if [ -z "$*" ]; then return 0; fi
	echo "$@" | while IFS= read -r line; do success_ "$line"; done
}
question_() {
	printf '%b %s\n' "  ${DCyan}[${Cyan}???${DCyan}]${Color_Off}" "$@" >&2
}
question() {
	if [ -z "$*" ]; then return 0; fi
	echo "$@" | while IFS= read -r line; do question_ "$line"; done
}
dry_run_() {
	# NOTE: Remove leading underscore-prefixed functions, to avoid logging things like `log_as_info_`.
	local command=$(echo "$@" | sed -E 's/^([a-zA-Z0-9_]*_ )+//')
	if (( ${LOG_DRY_RUN:-0} )); then
		printf '%b %s\n' "${DWhite}[${White}DRY_RUN${DWhite}]${Color_Off}" "sh> $(format_secondary $command)" >&2
	fi
}
dry_run() {
	if [ -z "$*" ]; then return 0; fi
	echo "$@" | while IFS= read -r line; do dry_run_ "$line"; done
}

log_as_trace_() {
	( set -o pipefail; "$@" 2>&1 | while IFS= read -r line; do trace_ "$line"; done )
}
log_as_debug_() {
	( set -o pipefail; "$@" 2>&1 | while IFS= read -r line; do debug_ "$line"; done )
}
log_as_info_() {
	( set -o pipefail; "$@" 2>&1 | while IFS= read -r line; do info_ "$line"; done )
}
log_as_warn_() {
	( set -o pipefail; "$@" 2>&1 | while IFS= read -r line; do warn_ "$line"; done )
}
log_as_error_() {
	( set -o pipefail; "$@" 2>&1 | while IFS= read -r line; do error_ "$line"; done )
}
log_as_success_() {
	( set -o pipefail; "$@" 2>&1 | while IFS= read -r line; do success_ "$line"; done )
}
