#!/bin/sh

#ubuntu 20.04

#install smartcard software
sudo apt update && sudo apt upgrade
sudo apt install libengine-pkcs11-openssl libp11-3 libpcsc-perl libccid libpcsclite1 pcscd pcsc-tools libasedrive-usb opensc openssl libengine-pkcs11-openssl #default-jre

#copy needed libs
sudo cp libaetdlss.so.3.0.2508 /usr/lib/
sudo cp libaetjcss.so.3.0.2509 /usr/lib/
sudo cp libaetpkss.so.3.0.2528 /usr/lib/

#create links
sudo ln -s /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so.3.0
sudo ln -s /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so.3.0
sudo ln -s /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so.3.0
sudo ln -s /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so.3
sudo ln -s /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so.3
sudo ln -s /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so.3
sudo ln -s /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so
sudo ln -s /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so
sudo ln -s /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so

#fix permisssions
sudo chown $USER:$USER /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetpkss.so.3.0.2528

#install libcrypto.so.1.0.0 and libgdbm_compat.so.3
wget http://ftp.br.debian.org/debian/pool/main/g/gdbm/libgdbm3_1.8.3-14_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.6_amd64.deb
#download pje
wget https://cnj-pje-programs.s3-sa-east-1.amazonaws.com/pje-office/pje-office_amd64.deb

#install
sudo dpkg -i *.deb

#clean
rm *.deb

#all done
cp pjeOffice.desktop ~/.local/share/applications
