#!/bin/bash

sudo qemu-system-riscv64 \
	-machine 'virt' \
	-m 1G \
	-device virtio-net-device,netdev=net -netdev user,id=net,hostfwd=tcp::2222-:22 \
	-kernel /home/notaroo/kernel_dev/linux/build/arch/riscv/boot/Image \
	-drive format=raw,file=rootfs.img,id=hd0 \
	-device virtio-blk-device,drive=hd0 \
	-append "root=/dev/vda rw console=ttyS0"
