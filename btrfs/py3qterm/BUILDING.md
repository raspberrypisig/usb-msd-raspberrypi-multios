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



```
