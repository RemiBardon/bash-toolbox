#!/usr/bin/env bash

source "$(dirname "$0")"/die.sh

test_env_var() {
	local var_name="$1"
	if [ -z "${!var_name+x}" ]; then
		[ -n "${2+x}" ] && die "Please set \`$1\` to $2." || die "Undefined variable: \`$1\`"
	fi
}
