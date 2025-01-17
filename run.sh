#!/bin/bash

qemu-system-x86_64 \
	-m 1G \
	-drive format=raw,file=rootfs.img \
	-device e1000,netdev=net \
	-netdev user,id=net,hostfwd=tcp::2222-:22 \
	-kernel /home/notaroo/kernel_dev/linux/arch/x86_64/boot/bzImage \
	-append "root=/dev/vda rw"
#-nographic

# qemu-system-aarch64 \
# 	-machine 'virt' \
# 	-cpu 'cortex-a57' \
# 	-m 1G \
# 	-drive format=raw,file=rootfs.img \
# 	-device e1000,netdev=net \
# 	-netdev user,id=net,hostfwd=tcp::2222-:22 \
# 	-kernel /home/notaroo/kernel_dev/linux-rust-dev/arch/arm64/boot/Image.gz \
# 	-append "root=/dev/vda rw console=ttyAMA0"
# #-nographic
