## NeoVim的一些技巧以及快捷键以防忘记

### 跳转到定义
以下面这个为例:

```c
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
  int *a = (int*) malloc(sizeof(int));

  *a = 3;
  return 0;
}
```


我们的光标可以定位到`malloc` 这个方法的调用位置上，然后再使用`<gd>`跳转到定义的位置，可能会打开一个新的页面也有可能在当前的文件下进行光标进行跳转，那么如何回到之前我们编辑的位置上呢?


当然我们也可以使用`:jumps` 这个command进行查看现在的寄存器中的一些记录，查看之前的列表记录。

可以使用`:help jumps`查看关于这个合集的一些说明，再使用。
