#!/bin/sh

#para Ubuntu 20.04...

#instala drivers do smartcard 
sudo apt update && sudo apt upgrade
sudo apt install libengine-pkcs11-openssl libp11-3 libpcsc-perl libccid libpcsclite1 pcscd pcsc-tools libasedrive-usb opensc openssl libengine-pkcs11-openssl #default-jre

#copia bibliotecas para a pasta do sistema
sudo cp libaetdlss.so.3.0.2508 /usr/lib/
sudo cp libaetjcss.so.3.0.2509 /usr/lib/
sudo cp libaetpkss.so.3.0.2528 /usr/lib/

#cria links
sudo ln -s /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so.3.0
sudo ln -s /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so.3.0
sudo ln -s /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so.3.0
sudo ln -s /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so.3
sudo ln -s /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so.3
sudo ln -s /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so.3
sudo ln -s /usr/lib/libaetpkss.so.3.0.2528 /usr/lib/libaetpkss.so
sudo ln -s /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetjcss.so
sudo ln -s /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetdlss.so

#conserta permisssões
sudo chown $USER:$USER /usr/lib/libaetdlss.so.3.0.2508 /usr/lib/libaetjcss.so.3.0.2509 /usr/lib/libaetpkss.so.3.0.2528

#baixa libcrypto.so.1.0.0 e libgdbm_compat.so.3 (que não estão disponiveis via apt-get)
wget http://ftp.br.debian.org/debian/pool/main/g/gdbm/libgdbm3_1.8.3-14_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.6_amd64.deb
#baixa pjeOffice
wget https://cnj-pje-programs.s3-sa-east-1.amazonaws.com/pje-office/pje-office_amd64.deb

#instala tudo
sudo dpkg -i *.deb

#remove arquivos baixados
rm *.deb

#copia atalho para icone (o que vem no PjeOffice tem erros)
cp pjeOffice.desktop ~/.local/share/applications
