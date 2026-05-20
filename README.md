# typst sdu os slide

[![Repo](https://img.shields.io/badge/GitHub-repo-444)](https://github.com/arshtyi/typst-sdu-os-slide)
[![Manual](https://img.shields.io/badge/docs-manual.pdf-blue)](docs/manual.pdf?raw=true)

使用Typst还原山东大学计算机科学与技术学院操作系统课程的幻灯片模板.

## Quick Start

### Clone the repository

```bash
git clone https://github.com/arshtyi/typst-sdu-os-slide.git
```

### Start

```typ
#import "slide.typ": setup, theme, pause, meanwhile, jump, theme

#show: setup.with(
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    author: "arshtyi",
    term: "2026 Spring",
    date: datetime.today(),
    // sidebar-ring-style: 2, // 该参数控制右下角圆环与侧边栏的遮挡关系,设置为2后圆环会被侧边栏遮挡(原幻灯片的样式).但是这种样式并不美观,所以默认值为1,即圆环在侧边栏之上(虽然不符合原幻灯片,但更美观一些)
    // handout: true, // 该参数控制是否生成阅读版,默认为false,即生成放映版(包含所有overlay状态),设置为true后会生成只包含最终overlay状态的阅读版
)
```

## Example

### Sidebar 1

- [放映版](https://raw.githubusercontent.com/arshtyi/typst-sdu-os-slide/main/template/typst-sdu-os-slide-sidebar1.pdf)
- [阅读版](https://raw.githubusercontent.com/arshtyi/typst-sdu-os-slide/main/template/typst-sdu-os-slide-sidebar1-handout.pdf)

### Sidebar 2

- [放映版](https://raw.githubusercontent.com/arshtyi/typst-sdu-os-slide/main/template/typst-sdu-os-slide-sidebar2.pdf)
- [阅读版](https://raw.githubusercontent.com/arshtyi/typst-sdu-os-slide/main/template/typst-sdu-os-slide-sidebar2-handout.pdf)

## Features

- 还原了原幻灯片的整体风格.
- 支持类似 Touying 的 `#pause` 与 `#meanwhile` 覆盖层语义和 `handout: true` 生成只包含最终 overlay 状态的阅读版.
- 基于typst特性,`sidebar`组件额外实现了跳转.

## typ2pptx

[typ2pptx](https://github.com/touying-typ/typ2pptx), just a try.

```sh
uvx typ2pptx --root . -v template/template.typ -o template/typ2pptx.pptx
```

这个效果目前很差,不建议使用.

## Acknowledgments

- [touying](https://github.com/touying-typ/touying)
- [typst-talk](https://github.com/OrangeX4/typst-talk)
