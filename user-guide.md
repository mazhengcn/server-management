# ZYlab servers
<!-- TOC -->

- [ZYlab servers](#zylab-servers)
  - [1. 服务器信息](#1-服务器信息)
    - [1.1 服务器](#11-服务器)
    - [1.2 账号文件结构](#12-账号文件结构)
  - [2. 账号申请](#2-账号申请)
    - [2.1 申请须知](#21-申请须知)
    - [2.2 申请方式](#22-申请方式)
  - [3. 注意事项](#3-注意事项)

<!-- /TOC -->
## 1. 服务器信息

### 1.1 服务器

1. zylab-70
    - IP：111.186.40.70
    - 用户组成：ZYlab博士生及硕士生
    - 管理员：王志伟，竺烨锟

2. zylab-147
    - IP：202.120.13.147
    - 用户组成：ZYlab老师以及其他老师的博士生及硕士生
    - 管理员：张众望，竺烨锟

3. zylab-184
    - IP：202.120.13.184
    - 用户组成：其他学生
    - 管理员：周瀚旭

<!-- 4. zylab-3090
    - IP：111.186.40.79
    - 用户组成：ZYlab博士(含已直博本科生)
    - 管理员：马征老师 -->

### 1.2 账号文件结构

```
zylab-xxx
|-- home
    |-- user1
    |   |-- user1's envs/src files
    |   `-- data
    |       |-- user1's data files
    `-- user2
        |-- user2's envs/src files
        `-- data
        |   |-- user2's data files
```

账号初始空间：     
  - /home/username
    - 大小：50G
    - 用于运行环境和代码 (**重装即抹除**)
  - /home/username/data
    - 大小：100G
    - 用于储存数据 (**重装不抹除**)


## 2. 账号申请

### 2.1 申请须知

1. 每人只可选择**一台**服务器申请账号。
2. **ZYlab博士生及硕士生**只能在70或者147有一个账号。
3. 遇到不可控情况重装服务器系统后，原则上**不可变更所在服务器**。
4. 获得账号后请尽快**重置密码**, 用户密码应满足如下全部三项要求：
    1. 大于等于8位；
    2. 包含大写字母、小写字母、数字、符号中至少两种类型字符；
    3. 密码中不能包含用户名子字符串 (>=3字符)。

### 2.2 申请方式

联系服务器对应管理员申请账号(微信联系或者邮件联系)。

交大邮箱地址：
- 竺烨锟：zhuyekun123@sjtu.edu.cn
- 王志伟：victorywzw@sjtu.edu.cn
- 张众望：0123zzw666@sjtu.edu.cn


## 3. 注意事项

1. 服务器**每个月初重启维护**，会提前通知。请仔细阅读[账号文件结构](#12-账号文件结构)，确保重要文件不被删除。
2. 如使用中有需要可向管理员**申请临时扩容**。
3. 获得账号后请尽快**重置密码**。
4. 建议每个用户主要在一台机器跑代码，仅在特殊情况用第二台。
5. 如使用有任何问题请询问所在服务器的管理员。

