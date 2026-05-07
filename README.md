# typst sdu os slide

使用Typst还原山东大学计算机科学与技术学院操作系统课程的幻灯片模板.

## Incoming

目前唯一的样式缺失应该是`sidebar`与右下角圆环的遮挡关系,但是暂时没有好的实现方案.除此之外的样式都与原幻灯片几乎一模一样(一些方面甚至加强).

## Quick Start

### Clone the repository

```bash
git clone https://github.com/arshtyi/typst-sdu-os-slide.git
```

### Build the template

```typ
#import "slide.typ": setup, theme, pause, meanwhile
#show: setup.with(
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    author: "arshtyi",
    term: "2026 Spring",
    date: datetime.today(),
    handout: false,
)
```

## Example

- [放映版](https://raw.githubusercontent.com/arshtyi/typst-sdu-os-slide/main/template/typst-sdu-os-slide.pdf)
- [阅读版](https://raw.githubusercontent.com/arshtyi/typst-sdu-os-slide/main/template/typst-sdu-os-slide-handout.pdf)

## Features

- 还原了原幻灯片的整体风格和布局.
- 支持类似 Touying 的 `#pause` 与 `#meanwhile` 覆盖层语义和 `handout: true` 生成只包含最终 overlay 状态的阅读版.
- 主要使用了以下字体:
  - [LxgwWenkai](https://github.com/lxgw/LxgwWenkai)
  - [source-han-sans](https://github.com/adobe-fonts/source-han-sans)
- 基于typst特性,`sidebar`组件额外实现了跳转.

## Note

- 原幻灯片可以在[arshtyi/SDU-Operating-System-PPTs](https://github.com/arshtyi/SDU-Operating-System-PPTs)等处获取.
- `pause`/`meanwhile` 会在播放版中展开 overlay, 在 `handout: true` 时只保留最终状态.

## Reference

- [touying](https://github.com/touying-typ/touying)
- [typst-talk](https://github.com/OrangeX4/typst-talk)
