#!/bin/bash

FILES="my*.txt my*.sh"
SHA="SHA256SUM"

echo -e "\e[36mDeleting previous files\n\e[33;1m> rm -f $SHA $SHA.asc\e[0m"
rm -f $SHA $SHA.asc

echo -e "\n\e[36mGenerating checksum\n\e[33;1m> sha256sum $FILES > $SHA\e[0m"
sha256sum $FILES > $SHA

echo -e "\n\e[36mVerifying checksum\n\e[33;1m> sha256sum -c $SHA\e[0m"
sha256sum -c $SHA

echo -e "\n\e[36mSigning checksum (detached, armor)\n\e[33;1m> gpg -o $SHA.asc -a -sb $SHA\e[0m"
gpg -o $SHA.asc -a -sb $SHA

echo -e "\n\e[36mVerifying signature\n\e[33;1m> gpg --verify $SHA.asc $SHA\e[0m"
gpg --verify $SHA.asc $SHA

exit 0
