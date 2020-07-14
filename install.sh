#!/bin/bash
#REF: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/randymcmillan/docker.shell/master/install.sh)"
install() {

if [[ "$OSTYPE" == "linux-gnu" ]]; then

    if hash apt 2>/dev/null; then
        apt install curl docker
    fi

elif [[ "$OSTYPE" == "linux-musl" ]]; then

    if hash apk 2>/dev/null; then
        apk add curl openrc
        apk update && apk add docker docker-compose && rc-update add docker boot
    fi

elif [[ "$OSTYPE" == "darwin"* ]]; then

    if hash brew 2>/dev/null; then
        brew install curl docker
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        install
    fi

elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo TODO add support for $OSTYPE
elif [[ "$OSTYPE" == "msys" ]]; then
    echo TODO add support for $OSTYPE
elif [[ "$OSTYPE" == "win32" ]]; then
    echo TODO add support for $OSTYPE
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo TODO add support for $OSTYPE
else
    echo TODO add support for $OSTYPE
fi

if [ ! -d $HOME/docker.shell ]; then
    git clone https://github.com/randymcmillan/docker.shell $HOME/docker.shell
fi

cd $HOME/docker.shell
git reset --hard HEAD~1 && git pull && make link

}
install

