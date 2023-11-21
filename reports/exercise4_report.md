## 要点

#### dma

DMA（Direct Memory Access）可以使得外部设备可以不用 CPU 干预，直接把数据传输到内存，这样可以解放 CPU，提高系统性能

使用 dma_alloc_coherent/dma_free_coherent，分配/释放网卡 tx_ring 和 rx_ring 的 dma 空间

#### napi

由于当网络包首发密集时，频繁地触发中断会严重影响 cpu 的执行效率，napi 是 linux 上采用的以提高网络处理效率的技术。
网卡接收到数据，通过硬中断通知 CPU 进行处理，但是当网卡有大量数据涌入时，频繁中断消耗大量的 CPU 处理时间在中断自身处理上，使得网卡和 CPU 工作效率低下，所以系统采用了硬中断进入轮询队列 + 软中断退出轮询队列技术，提升数据接收处理效率

#### ring buffer

e1000 网卡环形缓冲区，通过 DMA 映射到内存

#### sk_buff

网络是分层的，对于应用层而言不用关心具体的底层是如何工作的，只需要按照协议将要发送或接收的数据打包成 packet 即可。

要使用 sk_buff 必须先分配
使用 alloc_skb_ip_align 分配一个 sk_buff

接收数据时，将网卡 rx_ring 受到的 packet 写入到 sk_buff
发送数据时，将 sk_buff 的数据使用 e1000_transmit 发送到网卡的 tx_ring

#### 参考资料

https://www.zhihu.com/people/wenfh2020/posts?page=2

https://stackoverflow.com/questions/47450231/what-is-the-relationship-of-dma-ring-buffer-and-tx-rx-ring-for-a-network-card?answertab=votes#tab-top

https://github.com/fujita/rust-e1000

https://elixir.bootlin.com/linux/v4.19.121/source/drivers/net/ethernet/intel/e1000
