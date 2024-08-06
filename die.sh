#!/usr/bin/env bash

source "$(dirname "$0")"/log.sh

die() {
	error $@
	exit 1
}
