#!/bin/env bash

set -o errexit

main() {
	set -o xtrace

	__install_lein
}

__install_lein() {
	mkdir -p $HOME/bin
	curl -sL -o $HOME/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
	chmod +x $HOME/bin/lein
        echo 'export PATH=${HOME}/bin:${PATH}' > /home/travis/.bash_profile.d/lein.bash
        chmod 644 /home/travis/.bash_profile.d/lein.bash
        chown travis: /home/travis/.bash_profile.d/lein.bash
}

main "@@"
