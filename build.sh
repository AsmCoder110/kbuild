#!/usr/bin/env bash

BWD=$(pwd)

if [ -d build ]; then
	find ./build/ -name ".config" -quit -exec cp {} $BWD/ ;
	rm -rfi build;
else
	exit;
fi

