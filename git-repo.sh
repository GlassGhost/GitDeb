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
PkgName="git-repo"; #--pkgname
GitUrl="https://gerrit.googlesource.com/git-repo"; #--maintainer
GitTagName="v1.12.7";
PkgVersion="1.12.7"; #--pkgversion
PkgLicense="Apache 2.0"; #--pkglicense

#--requires		Dependencies required by this package.
#--provides		Features provided by this package (currently only on RPM and Deb).

# path/to/Checkout.sh git://someurl/someproject.git someproject release_0_1
bash $owd/Checkout.sh ${GitUrl} ${PkgName} ${GitTagName}
#set "description-pak" file for the deb description
tee "${owd}/${PkgName}/description-pak" > /dev/null <<EOF
Repo is a tool that we built on top of Git. Repo helps us manage the many Git repositories, does the uploads to our revision control system, and automates parts of the Android development workflow. Repo is not meant to replace Git, only to make it easier to work with Git in the context of Android. The repo command is an executable Python script that you can put anywhere in your path.

more info at http://source.android.com/source/version-control.html
EOF
# Build
cd "$owd/$PkgName/";
#autoreconf --install;
./configure --prefix=/usr;
make clean;
make;
# path/to/FakeMake.sh someproject 0.1
bash $owd/FakeMake.sh ${PkgName} ${GitUrl} ${GitTagName} ${PkgVersion} ${PkgLicense}

