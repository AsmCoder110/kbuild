[[ -f ".config" ]] && make -j12 && make -j12 modules && sudo make modules_install \
		&& sudo mkinitcpio -p linux514asmcoder \
		&& sudo grub-mkconfig -o /boot/grub/grub.cfg
