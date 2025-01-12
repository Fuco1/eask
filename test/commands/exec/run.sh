#!/usr/bin/env bash

# Copyright (C) 2022-2023 Jen-Chieh Shen

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs; see the file COPYING.  If not, write to the
# Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.

## Commentary:
#
# Test command `exec`
#

set -e

echo "Test command 'exec'..."
cd $(dirname "$0")

eask install-deps
eask exec ert-runner -h
eask exec github-elpa -h
eask exec echo hello world

eask exec buttercup -L .
eask exec buttercup -L . --pattern 'pattern 1'
