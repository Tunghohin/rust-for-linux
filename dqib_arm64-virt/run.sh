#!/bin/bash

qemu-system-aarch64 \
	-machine 'virt' \
	-cpu 'cortex-a57' \
	-m 1G \
	-device virtio-blk-device,drive=hd \
	-drive file=image.qcow2,if=none,id=hd \
	-device virtio-net-device,netdev=net \
	-netdev user,id=net,hostfwd=tcp::2222-:22 \
	-kernel /home/notaroo/kernel_dev/linux-rust/build/arch/arm64/boot/Image.gz \
	-initrd initrd \
	-append "root=LABEL=rootfs console=ttyAMA0"
#-nographic
