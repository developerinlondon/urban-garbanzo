#!/bin/bash -ex
export DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical

# If you need to reconfigure the keyboard
# sudo dpkg-reconfigure keyboard-configuration

# Switch to GB archive
cat > /etc/apt/sources.list <<END
deb http://gb.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb http://gb.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://gb.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://gb.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse
END

# Disable recommended, suggested and autoremove them
cat > /etc/apt/apt.conf.d/02recommends <<END
APT::Install-Recommends "false";
APT::AutoRemove::RecommendsImportant "false";
END
cat > /etc/apt/apt.conf.d/02suggests <<END
APT::Install-Suggests "false";
APT::AutoRemove::SuggestsImportant "false";
END

apt-mark manual grub-pc
apt-get -qq  update
apt-get -qq -y purge chef chef-zero juju-core puppet
apt-get -qq -y autoremove
apt-get -qq -y install build-essential dkms
# apt-get -qq -y install virtualbox-guest-dkms

apt-get -qq -y install terminator
apt-get -qq -y install git

#Java & JDK 8
add-apt-repository -y ppa:webupd8team/java
apt-get -qq  update

echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections

apt-get -y install oracle-java8-installer

apt-add-repository -y ppa:andrei-pozolotin/maven3
apt-get -qq -y update
apt-get -qq -y install maven3
apt-get -qq -y install mlocate
updatedb

#wget https://www.jetbrains.com/idea/download/download-thanks.html?platform=windows -P ~/Documents

#Set the keyboard layout to UK
# setxkbmap -layout gb

#Fix bug which can prevent loggin
chown vagrant:vagrant /home/vagrant/.Xauthority
chown ubuntu:ubuntu /home/ubuntu/.Xauthority

#install intellij to /opt (assumes package is in the /vagrant folder
tar -xvf /vagrant/ideaIU-2016.1.1.tar.gz -C /opt
chown -R ubuntu:ubuntu /opt/idea-IU-145.597.3/


#Setup squid proxy
apt-get -qq -y install connect-proxy

#Setup ss-agent with key for git
#eval `ssh-agent -s`
#ssh-add /home/ubuntu/.ssh/gerrit_key

#Configure git
git config --global user.name "Your Name"
git config --global user.email "youremail@email.com"

#Sorts out git line endings
git config --global core.autocrlf input

#copy keys from windows - or could mount instead, only useful if you have already generated keys and
#are running VM from Windows
#cp /vagrant/ssh/known_hosts ~/.ssh/known_hosts
#cp /vagrant/ssh/id_rsa ~/.ssh/id_rsa
#cp /vagrant/ssh/id_rsa.pub ~/.ssh/id_rsa.pub

# You may need to set up certificates for additional / internal repos
# cp /vagrant/settings.xml /home/ubuntu/.m2/settings.xml
# Should add the java cryptography extensions & rpelace the cacerts with a symlync so to O/S can manage certs
# keytool -import -trustcacerts -keystore /usr/lib/jvm/java-8-oracle/jre/lib/security/cacerts -storepass changeit -noprompt -alias tools.indigo.blue -file /path/to/certificate
# keytool -import -trustcacerts -keystore /usr/lib/jvm/java-8-oracle/jre/lib/security/cacerts -storepass changeit -noprompt -alias ops.svcs.artifactory -file /path/to/certificate

#address the login after screenlock issues with lubuntu
sudo apt-get -qq -y remove light-locker

#Extract terraform
# sudo unzip /vagrant/terraform_0.6.15_linux_amd64.zip -d /opt/terraform
# sudo chown -R ubuntu:ubuntu /opt/terraform/

