# My goal

进入手机行业的开发以来，更多的关注的是业务上的事情，对于代码和嵌入式的认知 有所生疏和迟钝，大学时期对于嵌入式技术的探索在毕业后 变得杂乱无章。

为了贯彻认知，使用2440 开发板 来强化对于底层各个方面的认知。 为了使项目持续下去， 遂指定schedule 和 项目规划：

* 阶段一：bring up && stable
	- the system bring up
	- 客制化
	- uboot code 优化
	- 启动流程 code review


* 阶段二: uboot 和 kernel driver 的开发
	- 串口驱动优化
	- 时钟配置
	- usb 驱动
 	- 网卡驱动
	- LCD 驱动
	- TP
	- nand flash 驱动

* 阶段三 ：新版本移植 ,新feature 引入
	- 新版本的uboot
	- 新版本的kernel
	- 添加新功能的支持
	- 使用设备树

* 阶段四 ：构建系统的引入

* 阶段五 ：


## todo

write on:2019年5月1日 :01点28分。

- 1. 需要添加对NFS 启动之支持。
- 2. 完善rootfs,并且验证开机
- 3. 完成sop。

## 阶段一 bring up && stable


### bring up

#### 1. 编译uboot
到 build_script  文件夹下，执行:

```bash
./auto.pl build uboot
```
#### 2. 下载uboot 到开发板中
```bash
./auto.pl download
```
#### 3. 下载kernel uImage 到板子中去
```bash
nand erase 0x400000 0x600000
tftp 0x30000000 uImage
nand write 0x30000000 0x400000 size
```
#### 4. 烧写rootfs
nand erase 0x1000000 0x5000000
tftp 0x30000000 rootfs.yaffs2
nand write.yaffs 0x30000000  0x1000000  0x529080



### stable


### 客制化

#### 编译客制化

build_script 目录下 存放有 编译 脚本。


#### 初期编译脚本开发


### uboot code 优化


### 启动流程 review






##日志


### 2019年5月1日
