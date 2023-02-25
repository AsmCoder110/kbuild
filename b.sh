[[ -f ".config" ]] && make -j12 && make -j12 modules && sudo make modules_install \
        && sudo cp -v arch/x86/boot/bzImage /boot/vmlinuz-asmcoder \
		&& sudo mkinitcpio -p linux514asmcoder \
		&& sudo grub-mkconfig -o /boot/grub/grub.cfg
