#!/usr/bin/env bash

set -o errexit

export DEBIAN_FRONTEND='noninteractive'

sudo apt install -yqq \
  --no-install-suggests \
  --no-install-recommends \
  patch \
  gawk \
  g++ \
  gcc \
  autoconf \
  automake \
  bison \
  libc6-dev \
  libffi-dev \
  libgdbm-dev \
  libncurses5-dev \
  libsqlite3-dev \
  libtool \
  libyaml-dev \
  make \
  patch \
  pkg-config \
  sqlite3 \
  zlib1g-dev \
  libgmp-dev \
  libreadline-dev \
  gnupg2 \
  dirmngr \
  libssl-dev

\curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
\curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
\curl -sSL https://get.rvm.io | bash -s stable

# progress bar when downloading RVM / Rubies:
echo progress-bar >> $HOME/.curlrc

# create .rvmrc
tee $HOME/.rvmrc <<EOF
rvm_autoupdate_flag='0'
rvm_binary_flag='1'
rvm_fuzzy_flag='1'
rvm_gem_options='--no-document'
rvm_max_time_flag='5'
rvm_path='/home/travis/.rvm'
rvm_project_rvmrc='0'
rvm_remote_server_type4='rubies'
rvm_remote_server_url4='https://s3.amazonaws.com/travis-rubies/binaries'
rvm_remote_server_verify_downloads4='1'
rvm_silence_path_mismatch_check_flag='1'
rvm_user_install_flag='1'
rvm_with_default_gems='rake bundler'
rvm_without_gems='rubygems-bundler'
rvm_autolibs_flag='read-fail'
EOF

source "$HOME/.rvm/scripts/rvm"
rvm install ruby-2.7.0 --autolibs=enable --fuzzy
rvm install ruby-2.6.3 --autolibs=enable --fuzzy
rvm install ruby-2.6.5 --autolibs=enable --fuzzy
rvm use default
gem i bundler
