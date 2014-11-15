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
GitUrl=$1; PkgName=$2; TagName=$3
# invoke with:
# path/to/Checkout.sh git://someurl/someproject.git someproject release_0_1

#checkout the project
if [ ! -f "$owd/$PkgName.txz" ]; then #if tar isn't there make it
	sudo rm -rf "$owd/$PkgName"
	cd "$owd" && git clone -n $GitUrl $PkgName
	tar cpf - "$PkgName" | nice -19 xz -vf9eC sha256 > "$owd/$PkgName.txz"
else
	rm -rf "$owd/$PkgName"; mkdir "$owd/$PkgName";
	bash $owd/txzExtract.sh "$owd/$PkgName.txz" "$owd"
	cd "$owd/$PkgName/"; git fetch --all; # download updates
	cd "$owd" && tar cf - "$PkgName" | nice -19 xz -vf9eC sha256 > "$owd/$PkgName.txz"
fi

cd "$owd/$PkgName/"; git checkout $TagName;
