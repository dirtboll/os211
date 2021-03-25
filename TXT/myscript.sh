#!/bin/bash
REC2="dirtboll.boi@gmail.com"
REC1="operatingsystems@vlsm.org"
FILES="my*.asc my*.txt my*.sh"
SHA="SHA256SUM"

[ -d $HOME/RESULT ] || mkdir -p $HOME/RESULT
pushd $HOME/RESULT
for II in W?? ; do
    [ -d $II ] || continue
    TARFILE=my$II.tar.bz2
    TARFASC=$TARFILE.asc
    rm -f $TARFILE $TARFASC
    echo -e "\e[36mCreating tar from $II\e[0m"
    echo -e "\e[33;1m> tar cfj $TARFILE $II/\e\n[0m"
    tar cfj $TARFILE $II/
    echo -e "\e[36mSigning $TARFILE\e[0m"
    echo -e "\e[33;1m> gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE\e\n[0m"
    gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE
done
popd

rm -f $HOME/RESULT/fakeDODOL
for II in $HOME/RESULT/myW*.tar.bz2.asc $HOME/RESULT/fakeDODOL ; do
   echo -e "\e[36mCheck and move $II...\e[0m"
   [ -f $II ] && mv -f $II .
done

echo -e "\n\e[36mDeleting previous files\n\e[33;1m> rm -f $SHA $SHA.asc\e[0m"
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
