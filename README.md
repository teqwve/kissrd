# kissrd

An extremely simple initramfs generator.

## Installation

Dependencies:
* `busybox` (with `FEATURE_SH_STANDALONE` and `ASH_BASH_COMPAT`)
* `cryptsetup` (for LUKS)
* `lvm` (for LVM)

Installation:

    make install            # install kissrd, data and default config
    make install-gentoo     # additionally install the kernel-install hook

## Usage

Generate an initramfs for the current kernel:

    sudo kissrd

Configure the binaries and modules in `/etc/kissrd.conf`:

    # Additional binaries to include in the initramfs.
    KISSRD_BINARIES="lvm cryptsetup"

    # Kernel modules to include in the initramfs.
    KISSRD_MODULES="dm-crypt"

Select and unlock the root device from the kernel command line:

    root=/dev/mapper/vg-root rd.modules=dm_crypt rd.actions=luks:/dev/sda1:cryptroot,lvm:vg/root

Kernel command line parameters:
* `root=$ROOT_DEVICE` - root device to mount
* `rd.modules=$MODULE,$MODULE` - comma separated modules to load
* `rd.actions=$ACTION,$ACTION` - comma separated actions to execute (in order)
    * `lvm:$LV_NAME` - scan available devices and activate `$LV_NAME`
    * `luks:$LUKS_DEVICE:$LUKS_NAME` - open `$LUKS_DEVICE` as `$LUKS_NAME`
* `rd.shell` - spawn a shell after mounting root instead of booting
