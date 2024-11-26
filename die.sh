source "${BASH_TOOLBOX-"$(dirname "$0")"}"/log.sh

die() {
	error "$@"
	exit 1
}
