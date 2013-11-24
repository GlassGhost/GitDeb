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
GitUrl=$1; PkgName=$2; PkgVersion=$3; TagName=$4
# invoke with:
# path/to/GitDeb.sh git://someurl/someproject.git someproject 0.1 release_0_1
source "$owd/txzExtract.sh"

#checkout the project
	if [ ! -f "$owd/$PkgName.txz" ]; then #if tar isn't there make it
		sudo rm -rf "$owd/$PkgName"
		cd "$owd" && git clone -n $GitUrl $PkgName
		tar cf - "$PkgName" | nice -19 xz -vf9eC sha256 > "$owd/$PkgName.txz"
	fi
	rm -rf "$owd/$PkgName"; mkdir "$owd/$PkgName";
	txzExtract "$owd/$PkgName.txz" "$owd"
	cd "$owd/$PkgName/"; git checkout $TagName;

#build the package
cd "$owd/$PkgName/"; ./configure; make clean; make;
fakeroot checkinstall --install=no --fstrans --pkgname="$PkgName" --pkgversion="$PkgVersion" -y -D make install

