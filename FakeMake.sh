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
PkgName=$1; GitUrl=$1; GitTagName=$3; PkgVersion=$4; PkgLicense=$5;
# invoke with:
# path/to/FakeMake.sh someproject 0.1

#TCC is a tiny but complete ISOC99 C compiler which enables you to use C as scripting language. TCC has its roots in the OTCC project. The TCCBOOT boot loader demonstrate the speed of TCC by compiling and launching a Linux kernel in less than 15 seconds.

#more info at http://bellard.org
#EOF
#--deldoc  Toggle deletion of doc-pak upon termination.
#--deldesc Toggle deletion of description-pak upon termination.
#--delspec Toggle deletion of spec file upon termination.

#Fake root Make install the package
cd "$owd/$PkgName";
fakeroot checkinstall --install=no --fstrans -y -D \
--pkgname="$PkgName" \
--maintainer="$GitUrl" \
--pkgversion="$PkgVersion" \
--pkglicense="$PkgLicense" \
--pakdir="$owd" \
make install
#--pkgarch="" \
#--requires="" \
#--provides="" \

#--pkgrelease			Set the package release.
#--pkggroup				Set the package group.
#--pkgsource			Set source location
#--pkgaltsource			Set alternate source location

