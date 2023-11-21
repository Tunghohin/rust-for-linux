## build linux

首先安装 clang-11 并将 clang 默认版本切换到 clang-11

```sh
sudo apt install clang-11
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 100 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-11
clang --version //看看是不是11版本
clang++ --version //同上
```

获取 linux 源码并生成 linux 默认编译参数

```sh
git clone https://github.com/Rust-for-Linux/linux -b rust --depth=1
make ARCH=riscv LLVM=1 O=build defconfig

```

配置 rust 环境

```sh
make LLVM=1 rustavailable
rustup override set $(scripts/min-tool-version.sh rustc)
rustup component add rust-src
cargo install --locked --force --version $(scripts/min-tool-version.sh bindgen) bindgen
```

进入 menuconfig 修改配置文件，然后进行编译

```sh
make ARCH=riscv LLVM=1 O=build menuconfig #打开 rust 支持，勾选 sample，并关闭 kvm 支持模块
bear -- make ARCH=riscv LLVM=1 LLVM_IAS=0 -j8 #编译并生成 compile_commands.json
```

制作根文件系统

```sh
qemu-img create -f raw rootfs.img 3G
mkfs.ext4 rootfs.img
sudo mkdir /mnt/rootfs
sudo mount -o loop rootfs.img /mnt/rootfs
sudo debootstrap --arch riscv64 unstable /mnt/rootfs https://mirrors.tuna.tsinghua.edu.cn/debian/
```

运行

```sh
#!/bin/bash

sudo qemu-system-riscv64 \
	-machine 'virt' \
	-m 1G \
	-device virtio-net-device,netdev=net -netdev user,id=net,hostfwd=tcp::2222-:22 \
	-kernel /home/notaroo/kernel_dev/linux/build/arch/riscv/boot/Image \
	-drive format=raw,file=rootfs.img,id=hd0 \
	-device virtio-blk-device,drive=hd0 \
	-append "root=/dev/vda rw console=ttyS0"
```
