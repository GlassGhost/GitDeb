#!/bin/bash
#    Use of this software and  associated  documentation  files  (the
#    "Software"), is governed by the Creative Commons  Public  Domain
#    License(the "License"). You may obtain a copy of the License at:
#        https://creativecommons.org/licenses/publicdomain/
#_______________________________________________________________________________
ISO_8601=`date -u "+%FT%TZ"` #ISO 8601 Script Start UTC Time
utc=`date -u "+%Y.%m.%dT%H.%M.%SZ"` #UTC Time (filename safe)
owd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #Path to THIS script.
#_______________________________________________________________________________
PkgName=$1; GitUrl=$1; GitTagName=$3; PkgVersion=$4; PkgLicense=$5;
# invoke with:
# path/to/FakeMake.sh someproject 0.1

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

