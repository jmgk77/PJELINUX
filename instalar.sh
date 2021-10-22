#!/bin/sh

#helpers...
link_if_not_exists() {
    if [ ! -e $2 ]; then
    	echo $1 "->" $2
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

#extrai bibliotecas para a pasta do sistema
sudo tar -xf data.tgz -C /usr/lib --exclude='pjeOffice.desktop'

#cria links
DLG="libaetdlglib.so.3.5.4428"
DLS="libaetdlss.so.3.5.4441"
JCS="libaetjcss.so.3.5.4427"
PKS="libaetpkss.so.3.5.4458"

cd /usr/lib/
link_if_not_exists $DLG libaetdlglib.so.3.5
link_if_not_exists libaetdlglib.so.3.5 libaetdlglib.so.3
link_if_not_exists libaetdlglib.so.3 libaetdlglib.so
link_if_not_exists $DLS libaetdlss.so.3.5
link_if_not_exists libaetdlss.so.3.5 libaetdlss.so.3
link_if_not_exists libaetdlss.so.3 libaetdlss.so
link_if_not_exists $JCS libaetjcss.so.3.5
link_if_not_exists libaetjcss.so.3.5 libaetjcss.so.3
link_if_not_exists libaetjcss.so.3 libaetjcss.so
link_if_not_exists $PKS libaetpkss.so.3.5
link_if_not_exists libaetpkss.so.3.5 libaetpkss.so.3
link_if_not_exists libaetpkss.so.3 libaetpkss.so
cd -

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
tar -xf data.tgz -C $HOME/.local/share/applications --exclude='*.so*'
