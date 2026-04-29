# typst sdu os slide

使用Typst还原山东大学计算机科学与技术学院操作系统课程的幻灯片模板.

## Quick Start

### Clone the repository

```bash
git clone https://github.com/arshtyi/typst-sdu-os-slide.git
```

### Build the template

```typ
#import "slide.typ": setup, theme
#show: setup.with(
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    author: "arshtyi",
    term: "2026 Spring",
    date: datetime.today(),
)
```

an example: [`template/template.typ`](template/template.typ)

<details>
<summary>Preview</summary>

![template.png](https://raw.githubusercontent.com/arshtyi/typst-sdu-os-slide/main/template/template.png)

</details>

## Features

- 还原了原幻灯片的整体风格和布局.
- 主要使用了以下字体:
  - [LxgwWenkai](https://github.com/lxgw/LxgwWenkai)
  - [source-han-sans](https://github.com/adobe-fonts/source-han-sans)
- 基于typst特性,`sidebar`组件额外实现了跳转.

## Note

- 原幻灯片可以在[arshtyi/SDU-Operating-System-PPTs](https://github.com/arshtyi/SDU-Operating-System-PPTs)等处获取.
- 模板中有几处细节不好确定, 可能与原幻灯片不完全一致, 但整体风格和布局是相似的.
- 模板中没有添加任何功能性组件, 仅还原了外观.

## Bug?

目前为了保持`sidebar`的正常高亮,一、二级`heading`默认`pagebreak`,这个问题可能应当被修复.

## Incoming

- `pause`
