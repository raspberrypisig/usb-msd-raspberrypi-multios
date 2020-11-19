# BUILDING

```
apt install -y git
curl https://pyenv.run | bash

cat<<EOF
export PATH="/root/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF > ~/.bashrc

source ~/.bashrc

cd /mnt
mkdir test
cd test
pyenv install 3.6.8


```
