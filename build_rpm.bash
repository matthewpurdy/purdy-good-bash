#/bin/bash

rpms_dir=$(mktemp -d /tmp/rpm_build_XXXXXX)
if [ "$#" == '1' ]
then
   rpms_dir="$(readlink -f $1)"
fi

mkdir -p $rpms_dir/{specs,sources}

PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bin:$PATH

which_path=$(which "$0")
script_path=$(dirname "$which_path")

umask 0022

temp_dir=/tmp
topdir=/tmp/rpmbuild

# create rpmmacros
echo '%_topdir /tmp/rpmbuild'    > ~/.rpmmacros
echo '%_tmppath %{_topdir}/tmp' >> ~/.rpmmacros

# create topdir directories
rm -rf $topdir
mkdir -p $topdir/BUILD
mkdir -p $topdir/RPMS
mkdir -p $topdir/SOURCES
mkdir -p $topdir/SPECS
mkdir -p $topdir/SRPMS
mkdir -p $topdir/tmp

# copy RPM spec file and put in the $topdir/SPECS
echo cp *.spec $topdir/SPECS/
cp *.spec $topdir/SPECS/

# copy RPM source file in the $topdir/SOURCES
echo cp *.tar.gz $topdir/SOURCES/
cp *.tar.gz $topdir/SOURCES/

# create RPM
echo rpmbuild -bb $topdir/SPECS/*.spec
rpmbuild -bb $topdir/SPECS/*.spec

# copy RPM files from topdir to rpms_dir
echo cp $topdir/RPMS/*/* $rpms_dir
cp $topdir/RPMS/*/*.rpm $rpms_dir 

# copy RPM spec files from topdir to rpms_dir/specs
echo cp $topdir/SPECS/* $rpms_dir/specs 
cp $topdir/SPECS/* $rpms_dir/specs 

# copy RPM source files from topdir to rpms_dir/sources
echo cp /tmp/rpmbuild/SOURCES/* $rpms_dir/sources
cp /tmp/rpmbuild/SOURCES/* $rpms_dir/sources

# cleanup 
rm -f ~/.rpmmacros
rm -rf /tmp/rpmbuild

