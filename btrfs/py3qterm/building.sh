#!/usr/bin/env bash

apt install -y git build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl https://pyenv.run | bash

cat<<'EOF'  >> ~/.bashrc
export PATH="/root/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF

source ~/.bashrc

cd /mnt
mkdir test
cd test
PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.6.8
pyenv local 3.6.8
python --version
