source "$(dirname "$0")"/log.sh

die() {
	error $@
	exit 1
}
