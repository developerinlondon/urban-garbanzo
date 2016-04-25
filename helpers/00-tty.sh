#!/bin/bash -ex
[ -f /root/.profile ] && grep -q -E "^mesg n" /root/.profile && sed -i -e 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile 
exit 0
