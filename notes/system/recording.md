## 录屏相关

使用`wf-recorder` 这个软件来进行录屏操作。

通过`pacman` 进行安装。

```bash
sudo pacman -S wf-recorder
```

### 对整个屏幕进行录屏
```bash
# 指定录屏的文件名称，以及录制声音
wf-recorder -a -f recording.mkv
```

### 指定录制的Rate
```bash
wf-recorder -a -f recording.mkv -r 60
```

<++>

### 选择某块区域进行录制

```bash
wf-recorder -g "$(slurp)"
```

如果想要录制声音则可以使用
```bash
wf-recorder -a -g "$(slurp)"
```


