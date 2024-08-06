#!/usr/bin/env bash

# Inspired by [Paludis's `edo` function](https://gitlab.exherbo.org/paludis/paludis/-/blob/ac9f4552b0a1ef1ed7c43071cf0846e35b99f4ea/paludis/repositories/e/ebuild/exheres-0/build_functions.bash#L247-251),
# with additional dry run logic.
edo() {
	if (( $DRY_RUN )); then
		dry_run $@
	else
		trace $@
		# NOTE: `eval $@` would break spaces in arguments.
		eval $(printf '%q ' "$@")
	fi
	return $?
}
