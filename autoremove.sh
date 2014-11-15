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
sudo apt-get -y update
sudo apt-get -y clean #Clean /var/apt/cache
sudo apt-get -y autoremove #Remove unneeded apps
sudo aptitude -y purge ~c #Get rid of leftover config files
sudo aptitude -y purge `deborphan` #Remove orphaned packages
deborphan --guess-dev | xargs sudo apt-get -y remove --purge #Remove orphaned -dev packages

exit
sudo apt-get -y update
#Clean /var/apt/cache
sudo apt-get -y clean
#Remove unneeded apps
sudo apt-get -y autoremove
#Get rid of leftover config files:
sudo aptitude -y purge ~c
#Remove orphaned packages:
#deborphan | xargs apt-get -y remove --purge
sudo aptitude -y purge `deborphan`
#Also: aptitude purge ~o (Make sure nothing you actually need is being removed, as it will remove packages you manually installed from the web.)
#Remove orphaned -dev packages:
deborphan --guess-dev | xargs sudo apt-get -y remove --purge

