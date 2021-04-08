# 服务器配置流程

## 安装

安装ubuntu server并选择entire disk with LVM。


## 添加用户=USERNAME并分配空间流程

1. 从ubuntu-vg中为该用户创建一个逻辑卷（LV）作为用户目录，大小为：```HOME_VOLUME_SIZE=20GB```:

   ```sudo lvcreate -L ${HOME_VOLUME_SIZE} -n home-${USERNAME} ubuntu-vg```

   从data-vg中为该用户创建一个逻辑卷（LV）用于用户数据存放，大小为：```DATA_VOLUME_SIZE=100GB```:

   ```sudo lvcreate -L ${DATA_VOLUME_SIZE} -n data-${USERNAME} data-vg```

2. 将逻辑卷格式化为ext4格式：

   ```sudo mkfs.ext4 /dev/ubuntu-vg/home-${USERNAME}```

   ```sudo mkfs.ext4 /dev/data-vg/data-${USERNAME}```

3. 创建用户：
   
   ```sudo useradd -s /bin/bash -p $(openssl passwd -1 ${PASSWORD}) ${USERNAME}```

4. 创建用户目录：

   ```sudo mkdir -p /home/${USERNAME}```

5. 将该用户的逻辑卷挂载到用户目录下：

   ```sudo mount /dev/ubuntu-vg/home-${USERNAME} /home/${USERNAME}```

6. 创建用户数据目录：

   ```sudo mkdir -p /home/${USERNAME}/data```

7. 挂载用户的数据逻辑卷到data目录下：

   ```sudo mount /dev/data-vg/data-${USERNAME} /home/${USERNAME}/data```

9.  将用户目录模板复制到该目录下：

    ```sudo cp -RT /etc/skel /home/xxx```

9. 修改目录权限：

    ```sudo chown -Rf xxx:xxx /home/xxx```

10. 编辑 /etc/fstab 文件, 设置自动挂载：

   ![](fstab.png)

结束。
