#!/usr/bin/env bash

cd /home/asmcoder/Code/kbuild || exit

if [ -d build ]; then
	rm -rf build/* && \
		cd build && \
		curl "https://kernel.org/" -o index.html

		kURL=$(grep -E "cdn" -m 1 index.html | cut -d\" -f2)  	# Stable kernel URL
        ksURL=${kURL//xz/sign}
		lTAR=$(echo "$kURL" | cut -d/ -f8 | sed 's/.xz//g') 		# Kernel archive name without the suffix .xz
        lDIR=${lTAR//.tar/}

		# Download Kernel
		curl -C - -O "$kURL"
		curl -C - -O "$ksURL"

		# Unxz it
		unxz "$lTAR".xz

		# Verify its correctness
		gpg --homedir "$XDG_DATA_HOME"/gnupg --verify "$lTAR".sign "$lTAR" 2>gpg.log
        grep -q 'Good' gpg.log || (echo "Bad gpg signature" && exit)

		# Untar it
		tar -xvf "$lTAR" >/dev/null
		chown -R "$USER":"$USER" "$lDIR"

		# Make sure to put the patch in the directory this script was ran from.
		cp ../0001-Revert-PCI-Add-a-REBAR-size-quirk-for-Sapphire-RX-56.patch "$lDIR"/
		cp ../b.sh "$lDIR"/
        cp ../.config "$lDIR"/
		cd "$lDIR" || exit

		# Build it
		make mrproper

		# Using the configuration of the kernel already in use.
		zcat /proc/config.gz > .config
		patch -p1 < 0001-Revert-PCI-Add-a-REBAR-size-quirk-for-Sapphire-RX-56.patch

		[[ -f ".config" ]] &&  make -j12 && make -j12 modules && sudo make modules_install \
		&& mkdir ../previous_kernel && cp -v /boot/vmlinuz-asmcoder /boot/initramfs-asmcoder.img ../previous_kernel/ && sudo cp -v arch/x86/boot/bzImage /boot/vmlinuz-asmcoder \
		&& sudo mkinitcpio -p linux514asmcoder \
		&& sudo grub-mkconfig -o /boot/grub/grub.cfg
else
	exit;
fi
