#!/usr/bin/env bash

BWD=$(pwd)
echo "$BWD"

if [ -d build ]; then
	rm -rfi build/* && \
		cd build && \
		wget "https://kernel.org/"

		kURL=$(wget $(grep -E "cdn" -m 1 index.html | cut -d\" -f2))
		ksURL=$(echo $kURL | sed 's/xz/sign/g')
		lNAME=$(echo $kURL | cut -d\/ -f8)
		lsNAME=$(echo $lNAME | sed 's/xz/sign/g')

		wget -c $kURL
		unxz $lNAME
		gpg --homedir /home/asmcoder/.local/share/gnupg --verify





else
	exit;
fi

