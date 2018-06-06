#!/bin/sh
sudo apt-add-repository ppa:ansible/ansible -y 
sudo apt-get update -y
sudo apt-get install ansible -y
sudo mv /etc/ansible/hosts /tmp/
sudo mv /etc/ansible/ansible.cfg /tmp/
sudo echo localhost >/etc/ansible/hosts
sudo echo [defaults] >/etc/ansible/ansible.cfg
sudo sh -c "echo 'inventory = /etc/ansible/hosts' >> /etc/ansible/ansible.cfg"
sudo sh -c "echo 'remote_user = root' >> /etc/ansible/ansible.cfg"
sudo sh -c "echo 'private_key_file = /root/.ssh/id_rsa' >> /etc/ansible/ansible.cfg"
sudo sh -c "echo 'host_key_checking = False' >> /etc/ansible/ansible.cfg"
sudo sh -c "echo 'log_path=/var/log/ansible' >> /etc/ansible/ansible.cfg"
#sudo useradd -m ansible
#sudo mkdir /home/ansible/.ssh
#sudo ssh-keygen -f /home/ansible/.ssh/id_rsa -t rsa -N ''
#sudo sh -c "echo 'ansible ALL=NOPASSWD: ALL' >> /etc/sudoers"
#sudo cat /home/ansible/.ssh/id_rsa.pub >/home/ansible/.ssh/authorized_keys
#sudo chmod 600 /home/ansible/.ssh/authorized_keys
#sudo chown -R ansible:ansible /home/ansible/.ssh
sudo ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''
sudo cat /root/.ssh/id_rsa.pub >/root/.ssh/authorized_keys
#sudo chown -R ansible:ansible /etc/ansible
sudo apt-get install libpam-google-authenticator -y
sudo apt-get install figlet -y
sudo apt-get install sysvbanner -y
sudo apt-get install build-essential -y
sudo apt-get install sendmail -y
sudo apt-get install fail2ban -y
wget https://sourceforge.net/projects/sudosh2/files/sudosh2-1.0.5.tgz
tar zxvf sudosh2-1.0.5.tgz
cd sudosh2-1.0.5/
sudo CFLAGS=”-D_GNU_SOURCE” ./configure
sudo ./configure
sudo make
sudo make install
sudo sh -c "echo 'User_Alias ADMINS=ubuntu,ansible' >> /etc/sudoers"
sudo sh -c "echo 'Cmnd_Alias SUDOSH=/usr/local/bin/sudosh' >> /etc/sudoers"
sudo sh -c "echo 'Admins ALL=SUDOSH' >> /etc/sudoers"
sudo mkdir /var/log/sudosh
sudo chmod 733 /var/log/sudosh
sudo service sshd restart
