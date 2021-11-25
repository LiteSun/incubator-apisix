#!/bin/sh

#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
VERSION=$1

SUBSTRING1=$(echo $VERSION| cut -d'.' -f 1)
SUBSTRING2=$(echo $VERSION| cut -d'.' -f 2)
BLOB_VERSION=$SUBSTRING1.$SUBSTRING2

read -p "Please enter release note pr: " RELEASE_NOTE_PR
read -p "Please enter release commit id: " COMMIT_ID

vote_contents=$(cat <<EOF
Hello, Community,

This is a call for the vote to release Apache APISIX version

Release notes:

$RELEASE_NOTE_PR

The release candidates:

https://dist.apache.org/repos/dist/dev/apisix/$VERSION/

Release Commit ID:

https://github.com/apache/apisix/commit/$COMMIT_ID

Keys to verify the Release Candidate:

https://dist.apache.org/repos/dist/dev/apisix/KEYS

Steps to validating the release:

1. Download the release

wget https://dist.apache.org/repos/dist/dev/apisix/$VERSION/apache-apisix-$VERSION-src.tgz

2. Checksums and signatures

wget https://dist.apache.org/repos/dist/dev/apisix/KEYS

wget https://dist.apache.org/repos/dist/dev/apisix/$VERSION/apache-apisix-$VERSION-src.tgz.asc

wget https://dist.apache.org/repos/dist/dev/apisix/$VERSION/apache-apisix-$VERSION-src.tgz.sha512

gpg --import KEYS

shasum -c apache-apisix-$VERSION-src.tgz.sha512

gpg --verify apache-apisix-$VERSION-src.tgz.asc apache-apisix-$VERSION-src.tgz

3. Unzip and Check files

tar zxvf apache-apisix-$VERSION-src.tgz

4. Build Apache APISIX:

https://github.com/apache/apisix/blob/release/$BLOB_VERSION/docs/en/latest/how-to-build.md#installation-via-source-release-package

The vote will be open for at least 72 hours or until necessary number of
votes are reached.

Please vote accordingly:

[ ] +1 approve
[ ] +0 no opinion
[ ] -1 disapprove with the reason
EOF
)

if [ ! -d release ];then
  mkdir release
fi
rm -rf ./release/apache-apisix-$VERSION-vote-contents.txt
printf "$vote_contents" >> ./release/apache-apisix-$VERSION-vote-contents.txt
