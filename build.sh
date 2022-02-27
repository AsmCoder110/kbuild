#!/usr/bin/env bash

BWD=$(pwd)
echo "$BWD"

if [ -d build ]; then
	rm -rfi build/* && \
		cd build && \
		wget "https://kernel.org/"
			kURL=$(wget $(grep -E "cdn" -m 1 index.html | cut -d\" -f2)) && \



else
	exit;
fi

