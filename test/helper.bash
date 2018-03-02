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


GHCLONE="$BATS_TEST_DIRNAME/../ghclone"


#######
# _CP #
#######
# cherrypick a piece of code to test.
#
# Wrap code with two comments like
#
#     # +_CP_foobar
#     : some code here
#     # -_CP_foobar
#
# It will be extracted and echo out as
#
#     _CP_foobar() {
#     : some code here
#     }
#
# The result can be used by eval to define the functions.
_CP() {
    < "$GHCLONE" \
    sed -n -E \
        -e '/^ *# \+_CP_[a-zA-Z0-9_]+$/,/^ *# -_CP_[a-zA-Z0-9_]+$/ {' \
            -e 's/^ *# \+(_CP_[a-zA-Z0-9_]+)$/\1()\{/' \
            -e 's/^ *# -_CP_[a-zA-Z0-9_]+$/\}/' \
            -e 'p' \
        -e '}' |
    sed -E -e 's/\$?RANDOM/$((_RND_SEQ[_RND_IDX\+\+]))/g'
}


###########
# asserts #
###########


# test strings $1 == $2
eqs ()
{
    echo "   '$1'"
    echo "!= '$2'"
    [[ "$1" == "$2" ]]
}
