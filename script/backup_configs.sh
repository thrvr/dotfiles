#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

cd "$(dirname $0)"/..

# find the installers and run them iteratively
find . -name backup.sh | while read backup ; do sh -c "${backup}" ; done

