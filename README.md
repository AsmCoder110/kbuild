Building a kernel for Dell G5SE 5505 because of this: https://gitlab.freedesktop.org/drm/amd/-/issues/1707

To set this up on Arch follow: https://wiki.archlinux.org/title/Kernel/Traditional_compilation#Default_Arch_configuration

The .config in this repo is a modified Arch Linux .config with "reasonable" modules enabled and some built right into the kernel (ex. k10temp).

In the build script I initially thought of saving the .config with each new iteration right into the repository,
however we can do better by just using the one the current kernel was built with because presumably we're going to building these a lot
until they fix the bug and saving each one to the repo is work we don't need to do.

If you want you can copy the .config and add it to the repo yourself, the script is just not going to bother with it.
