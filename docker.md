# Docker use for ZYlab
## `Docker` 介绍
----
### 高效利用环境资源
由于容器不需要进行硬件虚拟以及运行完整操作系统等额外开销,`Docker` 对系统资源的利用率更高。无论是应用执行速度、内存损耗或者文件存储速度，都要比传统虚拟机技术更高效。因此，相比虚拟机技术，一个相同配置的主机，往往可以运行更多数量的应用。
### 快速的启动时间
传统的虚拟机技术启动应用服务往往需要数分钟，而 `Docker` 容器应用，由于直接运行于宿主内核，无需启动完整的操作系统，因此可以做到秒级、甚至毫秒级的启动时间。大大的节约了开发、测试、部署的时间。
### 一致的运行环境
开发过程中一个常见的问题是环境一致性问题。由于开发环境、测试环境、生产环境不一致，导致有些 bug 并未在开发过程中被发现。而 `Docker` 的镜像提供了除内核外完整的运行时环境，确保了应用运行环境一致性，从而不会再出现 「这段代码在我机器上没问题啊」 这类问题.
### 持续交付和部署
对开发和运维（[DevOps](https://zh.wikipedia.org/wiki/DevOps)）人员来说，最希望的就是一次创建或配置，可以在任意地方正常运行。
使用 `Docker` 可以通过定制应用镜像来实现持续集成、持续交付、部署。开发人员可以通过 `Dockerfile` 来进行镜像构建，并结合 持续集成(Continuous Integration) 系统进行集成测试，而运维人员则可以直接在生产环境中快速部署该镜像，甚至结合 持续部署(Continuous Delivery/Deployment) 系统进行自动部署。
而且使用 `Dockerfile` 使镜像构建透明化，不仅仅开发团队可以理解应用运行环境，也方便运维团队理解应用运行所需条件，帮助更好的生产环境中部署该镜像。

---
## 基本概念
**Docker** 包括三个基本概念：
* 镜像（ `Image` ）
* 容器（ `Container` ）
* 仓库 ( `Repository`)

---
## `Docker` 本地安装与配置
1. 本地安装 `docker desktop`
    - **Windows**：
    - **Mac**：
2. 安装 [visual studio code](https://code.visualstudio.com)
3. 安装 [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) 扩展

---
## Rootless mode
`Docker` 需要用户具有 root 权限，这导致运行 docker 会有一些潜在的风险，而
`rootless mode` 允许以非 root 用户身份运行。

### 安装
如果安装的 Docker 20.10 或者是更新的版本，在 `/usr/bin` 有 rootless mode 的安装脚本 `dockerd-rootless-setuptool.sh`。
```bash
# set up the daemon as a non-root user
$ dockerd-rootless-setuptool.sh install
```
如果没有 `dockerd-rootless-setuptool.sh`，我们需要自行安装 docker-ce-rootless-extras
```bash
$ sudo apt-get install -y docker-ce-rootless-extras
```

### ZYlab 文件结构
```
zylab-xxx
| -- home
        | -- user1
            | -- src/env files
            | -- data 
                -- data files
        | -- user2
            | --src/env files
            | --data
                --data files
```

### 修改 `Docker` 存储位置
* `Docker` 的数据目录默认是 `~/.local/share/docker`，可以通过 `docker info`  查看
* 由于实验室服务器的文件结构，为了方便使用，最好将 `~/.local/share/docker` 放到 `～/data/docker-data`
* daemon 的配置文件默认是 `~/.config/docker`, 我们需要对docker的默认路径进行配置
```bash
# 进入 ~/.config/docker
$ cd ~/.config/docker

# 创建并打开 daemon.json
$ vim daemon.json
# i 键进入编辑模式, 将下面内容写进文件
# {
#     "data-root":"/home/user/data/docker-data"
# }
# esc 退出编辑模式
# :wq 退出vim


# 检查 docker root dir 是否更改成功
$ docker info


# 更改成功后，移动 docker root dir
$ mv ~/.local/share/docker/ ~/data/docker-data
```
### 使用
完成上面配置后，我们需要启动 `Docker` 服务
```bash
# 启动服务
$ systemctl --user start docker
# or
$ service docker start

# 关闭服务
$ systemctl --user stop docker
# or
$ service docker stop
```
---
## 实例: hello docker!
[Docker Hub](https://hub.docker.com)上有许多已经打包好的镜像，我们可以直接获取。

1. 从 `Docker` 镜像仓库获取镜像的命令是 `docker pull`

    ```bash
    $ docker pull [选项] [Docker Registry 地址[:端口号]/]仓库名[:标签]
    ```
    具体的选项可以通过 `docker pull --help` 命令看到。

2. 镜像名称的格式：
    - `Docker` 镜像仓库地址：地址的格式一般是 <域名/IP>\[:端口号]。默认地址是 Docker Hub(docker.io)。
    - 仓库名：仓库名一般是两段式名称，即 <用户名>/<软件名>。对于 Docker Hub，如果不给出用户名，则默认为 library，也就是官方镜像。

    比如：
    ```bash
    # 下面命令等价于 docker pull docker.io/library/hello-world:latest
    $ docker pull hello-world

    # 获取最新的 ubuntu 
    $ docker pull ubuntu

    # 获取最新的 tensorflow-gpu
    $ docker pull tensorflow/tensorflow:latest-gpu
    ```

3. 列出镜像
    
    - 可以使用 `docker image ls` 命令来查看已经下载的镜像。

        ```bash
        $ docker image ls
        # or
        $ docker images
        ```

        列表包含了 仓库名、标签、镜像 ID、创建时间 以及 所占用的空间。其中，镜像 ID 则是镜像的唯一标识，一个镜像可以对应多个标签。
    - 可以使用 `docker system df` 命令来查看查看镜像、容器、数据卷所占用的空间。

4. 删除镜像
    可以使用 `docker image rm` 命令来删除已下载的镜像
    ```bash
    $ docker image rm [选项] <镜像1> [<镜像2> ...]
    ```

5. 运行镜像
    有了镜像后，我们就能够以这个镜像为基础启动并运行一个容器。可以使用 `docker run` 来运行镜像。以 `hello-world` 为例：
    ```bash
    $ docker run hello-world

    Hello from Docker!
    This message shows that your installation appears to be working correctly.
    ... ...
    ```
    出现上述结果后，容器就会停止运行，容器自动终止。

    `docker run` 有很多可选的参数，可以通过 `docker run --help` 查看。
    比如，我常用的启动命令
    ```bash
    # -name 指定 container 的名称
    # -i 则让容器的标准输入保持打开。
    # -t 让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上
    # -v 文件映射，将指定文件映射到相应的容器文件
    # image_name 想要运行的镜像
    # bash 可交互的终端
    $ docker run --name dev_test -it -d -v homedir:dockerdir image_name bash

    # 进入可交互界面
    $ docker exec -it dev_test bash

    # 退出容器
    $ exit
    ```

---
## 利用 vscode 访问远程镜像(for Mac)
vscode + docker desktop 构建开发环境
### 生成 ssh 秘钥对
```bash
# ssh-keygen -t ed25519
$ ssh-keygen -t rsa

Generating public/private rsa key pair.
# 存储地址，默认回车即可
Enter file in which to save the key (/XXX/XXX/.ssh/id_rsa):  
# 请设置密码短语，并记住。输入的时候屏幕无显示(也可以不设置， 直接回车)
Enter passphrase (empty for no passphrase):                   
Enter same passphrase again: 

# 将本地主机的公钥 id_rsa.pub添加到远程主机的信任列表中
$ ssh-copy-id username@host

# 如果创建密钥时，未设置密码，则可以直接连接远程服务器
# 测试是否成功
$ ssh username@host

# 把本地的私钥加入 ssh 的守护进程
# ssh-add id_ed25519 
$ ssh-add id_rsa
```

### 配置本地使用远程 Docker 服务
```bash
# 创建一个context
$ docker context create [context name] --docker "host=ssh:username@host"


# 切换到上述context
$ docker context use [context name]

# 测试是否成功，如果成功的话，下面命令的输出会和远程服务器上运行 docker info 结果相同
$ docker info
```

### 在 vscode 中开发
- 打开VSCode，按下 `ctrl+shift+p` 运行 `docker contexts use` , 选择上面创建的docker context

- 按下 `ctrl+shift+p` 运行 `Remote-Containers:Attach to Running Container...` 连接远程服务器中正在运行的容器

