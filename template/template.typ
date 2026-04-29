#import "../slide.typ": setup, theme
#import "@preview/octique:0.1.1": octique-inline

#show: setup.with(
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    author: "arshtyi",
    term: "2026 Spring",
    date: datetime.today(),
)
// Some utils
#let typst-color = rgb("#239DAD")
#let Typst = text(fill: typst-color, weight: "bold", "Typst")
#let Touying = text(fill: rgb("#425066"), weight: "bold", "Touying")
#let Markdown = text(fill: rgb(purple), weight: "bold", "Markdown")
#let TeX = {
    set text(font: "New Computer Modern", weight: "regular")
    box(width: 1.7em, {
        [T]
        place(top, dx: 0.56em, dy: 0.22em)[E]
        place(top, dx: 1.1em)[X]
    })
}
#let LaTeX = {
    set text(font: "New Computer Modern", weight: "regular")
    box(width: 2.55em, {
        [L]
        place(top, dx: 0.3em, text(size: 0.7em)[A])
        place(top, dx: 0.7em)[#TeX]
    })
}
// Functions
#let linkto(url, icon: "link") = link(url, box(baseline: 30%, move(dy: -.15em, octique-inline(icon))))
#let keydown(key) = box(stroke: 2pt, inset: .2em, radius: .2em, baseline: .2em, key)
// Styles
#set text(weight: "medium")
#set par(justify: true)
#set underline(stroke: .05em, offset: .25em)
#show raw: set text(font: ("IBM Plex Mono", "Source Han Sans SC", "Noto Sans CJK SC"))
#show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: .3em, y: 0em),
    outset: (x: 0em, y: .3em),
    radius: .2em,
)
#show raw.where(block: true): set par(justify: false)
= Intro
== What is Typst
#Typst #linkto("https://typst.app") is a new *markup-based* typesetting system for the sciences. It is designed to be an alternative both to advanced tools like #LaTeX and simpler tools like Word and Google Docs.
== Why Use Typst
#Typst = #LaTeX 的排版能力 + #Markdown 的简洁语法 + 强大且现代的脚本语言
= How to Use
== Installation
Just use VSCode #linkto("https://code.visualstudio.com/") + Typst Extension #linkto("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist") to enjoy the best experience.
== Writing
=== Modes
#set text(size: 20pt, font: (theme.fonts.content.cjk, theme.fonts.content.latin))
#show terms: terms-list => {
    let term-cells = ()
    set par(justify: false)
    for item in terms-list.children {
        term-cells.push(block(text(fill: theme.colors.primary, item.term)))
        term-cells.push(block(item.description))
    }
    grid(
        columns: (auto, 1fr),
        column-gutter: 2em,
        row-gutter: 0.6em,
        align: (left, left),
        ..term-cells,
    )
}
/ Markup mode: use markup syntax like `=`, `**`, `-`, ... to write content.
/ Script mode: use `#` to enter script mode, where you can write code to generate content. You can also use `#{...}` to embed script in markup mode.
/ Math mode: use `$...$` for inline math and `$ ... $` for display math.

下面这套方法虽然能够实现上述列表样式,但原Slide中与之类似的内容又多又复杂多变,因此此行为弃用.一种更好的方式是需要时再手动调整一份.
=== Notes
```typ
#set text(size: 20pt, font: (theme.fonts.content.cjk, theme.fonts.content.latin))
#show terms: terms-list => {
    let term-cells = ()
    set par(justify: false)
    for item in terms-list.children {
        term-cells.push(block(text(fill: theme.colors.primary, item.term)))
        term-cells.push(block(item.description))
    }
    grid(
        columns: (auto, 1fr),
        column-gutter: 2em,
        row-gutter: 0.6em,
        align: (left, left),
        ..term-cells,
    )
}
```
