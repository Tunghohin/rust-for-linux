## 编译 linux

#### 1. 获取源码

```sh
git clone https://github.com/Rust-for-Linux/linux -b rust-dev --depth=1
```

#### 2. 安装依赖

- 获取依赖包

```sh
sudo apt-get -y install \
  binutils build-essential libtool texinfo \
  gzip zip unzip patchutils curl git \
  make cmake ninja-build automake bison flex gperf \
  grep sed gawk bc \
  zlib1g-dev libexpat1-dev libmpc-dev \
  libglib2.0-dev libfdt-dev libpixman-1-dev libelf-dev libssl-dev
```

- 获取 clang 和 llvm

```sh
sudo apt install clang llvm
```

#### 3. 编译 linux 内核

```sh
make ARCH=arm64 LLVM=1 defconfig
make ARCH=arm64 LLVM=1 menuconfig # general setup 里打开 rust support
cd ./build
bear -- make ARCH=arm64 LLVM=1 -j12 # 顺便生成 compile_commands.json
```

#### 4. 获取 dqib 系统镜像

```sh
https://people.debian.org/~gio/dqib/
```

使用脚本运行 qemu

```sh
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
```

## 运行结果

<img src="./imgs/Screenshot from 2023-11-08 13-11-58.png">
