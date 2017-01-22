#!/bin/bash

version=$1

if [ -z "$version" ]; then
    version=2.8.2
fi

echo "building and installing git ${version} into /opt with a sym link to /opt/git loading bath into bashrc starting"

yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yum install -y gcc perl-ExtUtils-MakeMaker

cd ~/Download
wget http://www.kernel.org/pub/software/scm/git/git-${version}.tar.gz
tar xzvf git-${version}.tar.gz

cd git-${version}
make prefix=/opt/git-${version} all
make prefix=/opt/git-${version} install

cd /opt
rm -f /opt/git
ln -s /opt/git-${version} git

echo ''                                >> ~/.bashrc
echo 'export GIT_HOME=/opt/git'        >> ~/.bashrc
echo 'export PATH=$GIT_HOME/bin:$PATH' >> ~/.bashrc
echo ''                                >> ~/.bashrc

source ~/.bashrc

echo "building and installing git ${version} into /opt with a sym link to /opt/git loading bath into bashrc is complete"

