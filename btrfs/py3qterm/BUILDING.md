# BUILDING

```
#!/usr/bin/env bash

apt install -y git build-essential
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
pyenv local 3.6.8
python --version
```
