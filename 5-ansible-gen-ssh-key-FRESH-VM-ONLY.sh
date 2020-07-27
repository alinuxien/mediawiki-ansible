rm -rf /vagrant/.ssh
mkdir /vagrant/.ssh
ssh-keygen -q -N '' -t ecdsa -f /vagrant/.ssh/id_ecdsa

