## 加载模块

将 .ko 拷贝到制作好的 rootfs 里
运行

```sh
insmod rust_hello.ko
```

## 碰到的问题

#### 1. 根文件系统构建

安装 debootstrap 和 qemu-utils

```sh
sudo apt-get install debootstrap qemu-utils
```

创建磁盘镜像文件格式化并挂载

```sh
qemu-img create -f raw rootfs.img 3G
mkfs.ext4 rootfs.img
sudo mkdir /mnt/rootfs
sudo mount -o loop rootfs.img /mnt/rootfs
```

安装 debian 镜像

```sh
sudo debootstrap --arch arm64 stable /mnt/rootfs https://mirrors.tuna.tsinghua.edu.cn/debian/
```

运行 `run.sh`

#### 2. rust-analyzer

```sh
make LLVM=1 ARCH=arm64 rust-analyzer
```

#### 3. deboostrap 下载慢

加上清华的源

```
https://mirrors.tuna.tsinghua.edu.cn/debian/
```

#### 4. 根文件系统挂载不上

在根文件创建 /dev/vda，在 qemu 中指定 root=/dev/vda rw

#### 5. qemu 连不上网

配置 `/etc/network/interfaces`

```
auto eth0
allow-hotplug eth0
iface eth0 inet dhcp
```

同时在 qemu 里根文件指定路径后添加 rw

## 运行结果

<img src="./imgs/Screenshot from 2023-11-09 10-10-02.png">
