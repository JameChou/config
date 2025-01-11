## Git使用说明以及LazyGit
> git是目前世界上最先进的分布式版本控制系统（没有之一）。
> 对于文件操作，长期使用电脑办公的人想必深有体会。对于学生而言，当我们对报告、论文、工作进展等等一改再改、一版再版时，我们需要这样一个工具来帮我们记录我们对文件执行过的增删修改操作，甚至可以对版本进行回滚。这个时候，git就派上大用场啦。


###  安装Ubuntu
```bash
sudo apt-get install git
```

### 查看相关配置

```bash
# 列出当前配置
git config --list
# 在库当中查看当前库里的所有配置信息
# 一般可以列出当前库的remote等信息
git config --local --list
# 列出全局配置
git config --global --list
```

### 配置
这一段是关于git的配置处理

#### 设置用户名以及邮箱
```bash
git config --global user.name "Xinyu"
git config --global user.email "zhouxy.vortex@gmail.com"
```

#### 命令以及广西编辑器相关
```bash
# 设置git命令输出为彩色
git config --global color.ui auto
# 设置igt使用的文本编辑器
git config --global core.editor vim
```

### 配置文件
**Repository配置对应的配置文件路径** 
```bash
<repo>/.git/config
```

**用户全局的配置文件路径[--global]**:
```bash
~/.gitconfig
```

**系统配置对应的配置文件路径** 
```bash
/etc/gitconfig
```

### 创建版本库
```bash
mkdir some_foler
cd some_folder
pwd

# 初始化这个目录进入git
git init
```

### 本地修改
```bash
# 显示工作路径下已修改的文件:
git status

# 显示与上次提交版本文件的不同:
git diff

# 把当前所有修改添加到下次提交之中:
git add .

# 把对某个文件的修改添加到下次提交中:
git add -p <file>

# 提交本地的所有修改:
git commit -a

# 提交之前已标记的变化:
git commit

# 附加消息提交:
git commit -m "message here"

# 把当前分支中未提交的修改移动到其他分支:
git stash
git checkout branch2
git stash pop

# 将stash changes 应用到当前分支:
git stash apply

# 删除最新一次的stashed changes:
git stash drop

```

### 搜索
```bash
# 从当前目录的所有文件中查找文件内容:
git grep "hello"

# 在某一版中搜索文本:
git grep "hello" v2.5
```

### 提交历史
```bash
# 从最新提交开始，显示所有提交记录(显示hash，作者信息，提交的标题和时间)
git log

# 显示所有提交(仅显示提交的hash和message):
git log --oneline

# 显示某个用户的所有提交:
git log --author="username"

# 显示某个文件的所有修改:
git log -p <file>

# 仅显示远端<remote/master>分支与远端<origin/master>分支提交记录的差集:
git log --oneline <origin/master>..<remote/master> --left-right

# 谁，在什么时间，修改了文件什么内容:
git blame <file>

# 显示reflog:
git reflog show

# 删除reflog:
git reflog delete
```

### 分支与标签
```bash
# 列出所有分支
git branch

# 列出所有远端分支:
git branch -r

# 切换分支
git checkout <branch>

# 创建并切换到新分支:
git checkout -b <branch>

# 基于当前分支创建新分支:
git branch <new-branch>

# 基于远程分支创建新的可追溯的分支:
git branch --track <new-branch> <remote-branch>

# 删除本地分支:
git branch -d <branch>

# 强制删除一个本地分支:
git branch -D <branch>

# 给当前版本打标签:
git tag <tag-name>

# 给当前版本打标签并附加消息:
git tag -a <tag-name>

```

### 更新与发布
```bash
# 列出当前配置的远程端
git remote -v

# 显示远程端的信息:
git remote show <remote>

# 添加新的远程端:
git remote add <remote> <url>

# 下载远程端版本，但不合并到HEAD中:
git fetch <remote>

# 下载远程端版本，并自动与HEAD版本合并:
git remote pull <remote> <url>

# 以rebase方式将远端分支与本地合并:
git pull --rebase <remote> <branch>

# 将本地版本发布到远程端:
git push <remote> <branch>

# 删除远程端分支:

git push <remote> :<branch> # (since git v1.5.0)
# or
git push <remote> --delete <branch> # (since git v1.7.0)

# 发布标签:
git push --tags

```



<++>

