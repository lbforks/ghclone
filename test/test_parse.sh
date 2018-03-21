#!/usr/bin/env bash
# Copyright (c) 2018 Yu-Jie Lin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


source "$(dirname "${BASH_SOURCE[0]}")"/helper.sh


oneTimeSetUp()
{
    eval "$(_CP)"
}


_test_cases()
{
    local expected_user="$1"
    local expected_repo="$2"
    local expected_URL="$3"
    shift 3
    local cases=("$@")

    local i
    for ((i = 0; i < ${#cases[@]}; i += 2)); do
        local test_name="${cases[i]}"
        local test_link="${cases[i + 1]}"
        _CP_parse "$test_link"
        assertEquals "[$test_name] \$user" "$expected_user"   "$user"
        assertEquals "[$test_name] \$repo" "$expected_repo"   "$repo"
        assertEquals "[$test_name] \$URL"  "$expected_URL"    "$URL"
    done
}


##########
# GitHub #
##########


test_GitHub()
{
    _test_cases user repo 'git@github.com:user/repo.git'    \
        'GiHub'         'https://github.com/user/repo'      \
        'GitHub HTTPS'  'https://github.com/user/repo.git'  \
        'GitHub SSH'    'git@github.com:user/repo.git'
}


########
# Gist #
########


test_Gist()
{
    _test_cases '' repo 'git@gist.github.com:repo.git'          \
        'Gist'          'https://gist.github.com/user/repo'     \
        'Gist HTTPS'    'https://gist.github.com/repo.git'      \
        'Gist SSH'      'git@gist.github.com:repo.git'
}


source shunit2
