#!/bin/bash -ex
export DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical
apt-get -qq  update
apt-get -qq -y dist-upgrade
