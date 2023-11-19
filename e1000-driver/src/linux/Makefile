obj-m := e1000_for_linux.o

PWD := $(shell pwd)
ARCH ?= arm64
KDIR ?= /home/notaroo/kernel_dev/linux/build

default:
	@[ -e ../Makefile ] || ln -s linux/Makefile ../
	$(MAKE) ARCH=$(ARCH) LLVM=1 -C $(KDIR) M=$(PWD)/../ modules

rustsetup:
	$(MAKE) ARCH=$(ARCH) LLVM=1 -C $(KDIR) M=$(PWD)/../ rust-analyzer

clean:
	$(MAKE) ARCH=$(ARCH) LLVM=1 -C $(KDIR) M=$(PWD)/../ clean
	@[ -e ../Makefile ] && rm ../Makefile
