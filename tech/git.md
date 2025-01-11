## Git使用说明以及LazyGit
> git是目前世界上最先进的分布式版本控制系统（没有之一）。
> 对于文件操作，长期使用电脑办公的人想必深有体会。对于学生而言，当我们对报告、论文、工作进展等等一改再改、一版再版时，我们需要这样一个工具来帮我们记录我们对文件执行过的增删修改操作，甚至可以对版本进行回滚。这个时候，git就派上大用场啦。


###  安装Ubuntu
```bash
sudo apt-get install git
```

### 设置用户名以及邮箱
```bash

git config --global user.name "Xinyu"
git config --global user.email "zhouxy.vortex@gmail.com"

```

### 创建版本库
```bash
mkdir some_foler
cd some_folder
pwd

# 初始化这个目录进入git
git init
```
### 缓存区的概念

