#!/bin/bash
ISO_8601=`date -u "+%FT%TZ"` #ISO 8601 Script Start UTC Time
utc=`date -u "+%Y.%m.%dT%H.%M.%SZ"` #UTC Time (filename safe)
owd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #Path to THIS script.
#   Copyright 2013 Roy Pfund
#
#   Licensed under the Apache License, Version 2.0 (the  "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable  law  or  agreed  to  in  writing,
#   software distributed under the License is distributed on an  "AS
#   IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,  either
#   express or implied. See the License for  the  specific  language
#   governing permissions and limitations under the License.
#_______________________________________________________________________________
#	Be careful to correctly quote/escape the name, to prevent shell expansion
PkgName="gambit"; #--pkgname
GitUrl="https://github.com/feeley/gambit.git"; #--maintainer
GitTagName="v4.7.0";
PkgVersion="4.7.0"; #--pkgversion
PkgLicense="Apache 2.0"; #--pkglicense
#--pkgarch		Set package architecture.
#--pakdir		Where to save the new package.
#--requires		Dependencies required by this package.
#libssl libdb4.8 libboost miniupnpc qt protobuf libqrencode
#sudo aptitude install -y autoconf build-essential checkinstall libtool autotools-dev libssl-dev libboost-all-dev libqrencode-dev libminiupnpc-dev libqt4-dev libprotobuf-dev protobuf-compiler


#For Qt 5 you need the following: apt-get install libqt5gui5 libqt5core5 libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev



#autoconf build-essential checkinstall libssl-dev 
#libdb++-dev libboost-all-dev libminiupnpc-dev 
#libqt4-core libqt4-gui libqt4-dev qt4-qmake libqrencode-dev



#--with-incompatible-bdb
#--provides		Features provided by this package (currently only on RPM and Deb).

# path/to/Checkout.sh git://someurl/someproject.git someproject release_0_1
bash $owd/Checkout.sh ${GitUrl} ${PkgName} ${GitTagName}
# Build
cd "$owd/$PkgName/";
./configure --prefix=/usr  --enable-single-host;
make clean;
make -j4 from-scratch;
make check;
# path/to/FakeMake.sh someproject 0.1
bash $owd/FakeMake.sh ${PkgName} ${GitUrl} ${GitTagName} ${PkgVersion} ${PkgLicense}


