#!/bin/bash -e

sudo apt-get -y install tmux

export NVM_DIR="/usr/local/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm current
node --version

cd /home/vagrant
git clone https://github.com/c9/core.git c9sdk
chown vagrant:vagrant c9sdk -R

cd c9sdk
scripts/install-sdk.sh

touch /home/vagrant/startups/cloud9
chmod +x /home/vagrant/startups/cloud9

echo "#!/bin/bash" >> /home/vagrant/startups/cloud9
echo "" >> /home/vagrant/startups/cloud9
echo "echo \"Starting Cloud9 IDE...\"" >> /home/vagrant/startups/cloud9
echo "cd /home/vagrant/c9sdk" >> /home/vagrant/startups/cloud9
echo "nohup node server.js -w /home/vagrant/workspace -p 8181 -l 0.0.0.0 -a : &>/dev/null &" >> /home/vagrant/startups/cloud9
echo "" >> /home/vagrant/startups/cloud9