# Allows passing a pipe as argument.
REGEX_ALLOW_PIPES='s#\\|#|#'
# Allows passing redirects (e.g. `2>&1`) as argument.
REGEX_ALLOW_REDIRECTS='s#([[:digit:]]*)\\>(\\&[[:digit:]]+)?#\1>\2#'

# Inspired by [Paludis's `edo` function](https://gitlab.exherbo.org/paludis/paludis/-/blob/ac9f4552b0a1ef1ed7c43071cf0846e35b99f4ea/paludis/repositories/e/ebuild/exheres-0/build_functions.bash#L247-251),
# with additional dry run logic.
edo() {
	if (( $DRY_RUN )); then
		dry_run $@
	else
		trace $@
		# NOTE: `$@`, `"$@"` or `eval $@` would break spaces in arguments.
		eval $(printf '%q ' "$@" | sed "$REGEX_ALLOW_PIPES" | sed -E "$REGEX_ALLOW_REDIRECTS")
	fi
	return $?
}

# Like `edo` but with no dry run logic.
traced() {
	trace $@
	# NOTE: `$@`, `"$@"` or `eval $@` would break spaces in arguments.
	eval $(printf '%q ' "$@" | sed "$REGEX_ALLOW_PIPES" | sed -E "$REGEX_ALLOW_REDIRECTS")
}
