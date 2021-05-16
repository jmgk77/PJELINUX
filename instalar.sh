#!/bin/sh

#para Ubuntu 20.04...

#helpers...
link_if_not_exists() {
    if [ ! -e $2 ]; then
        sudo ln -s $1 $2
    fi
}

#MAIN

#checa CPU
CPU=`uname -m`
if [ $CPU != x86_64 ]; then
    echo 'Este script somente suporta sistemas 64 bits...'
    exit
fi

#instala drivers do smartcard 
sudo apt update && sudo apt upgrade
sudo apt install libengine-pkcs11-openssl libpcsc-perl libccid libpcsclite1 pcscd pcsc-tools libasedrive-usb opensc openssl libengine-pkcs11-openssl
#nao existe no ubuntu 16.04...
#sudo apt install libp11-3 

#extrai bibliotecas para a pasta do sistema
sudo tar -xf data.tgz -C /usr/lib --exclude='pjeOffice.desktop'

#cria links
link_if_not_exists /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so.3.0
link_if_not_exists /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so.3.0
link_if_not_exists /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so.3.0
link_if_not_exists /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so.3
link_if_not_exists /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so.3
link_if_not_exists /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so.3
link_if_not_exists /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so
link_if_not_exists /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so
link_if_not_exists /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so

#conserta permisssões
sudo chown $USER:$USER /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetpkss.so.3.0.2528

#baixa libs que não estão disponiveis via apt-get

#Ubuntu 16.04 tem libgdbm3 disponivel via apt-get
wget http://ftp.br.debian.org/debian/pool/main/g/gdbm/libgdbm3_1.8.3-14_amd64.deb

#Ubuntu 18.04 tem libssl1.0.0 disponivel via apt-get
#Ubuntu 16.04 tem libssl1.0.0 disponivel via apt-get
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.6_amd64.deb

#baixa pjeOffice
wget https://cnj-pje-programs.s3-sa-east-1.amazonaws.com/pje-office/pje-office_amd64.deb

#instala tudo
sudo dpkg -i *.deb

#remove arquivos baixados
rm *.deb

#extrai atalho para lançador (o que vem no PjeOffice tem erros)
tar -xf data.tgz -C ~/.local/share/applications --exclude='*.so*'
