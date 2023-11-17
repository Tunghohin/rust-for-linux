## binding

#### 1.在 include/linux 中创建文件

<img src="./imgs/Screenshot from 2023-11-18 00-55-12.png">

#### 2.在 rust/bindings/bindings_helper.h 中 include 头文件，并将其于 /rust/helpers.c 中 export

<img src="./imgs/Screenshot from 2023-11-18 00-54-12.png" width=60%>
<img src="./imgs/Screenshot from 2023-11-18 00-54-50.png" width=60%>

#### 3.通过 rust 模块调用

<img src="./imgs/Screenshot from 2023-11-18 00-53-33.png">
