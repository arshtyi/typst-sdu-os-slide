#import "@preview/tidy:0.4.3"
#import "../slide.typ" as sdu

#let red = rgb("#9c0b15")
#let red-soft = rgb("#ce858a")
#let ink = rgb("#202124")
#let muted = rgb("#5f6368")
#let paper = rgb("#fbfaf8")
#let panel = rgb("#ffffff")
#let rule = rgb("#e7dada")

#let api-colors = (
    default: rgb("#f5eeee"),
    content: rgb("#f4d7da"),
    str: rgb("#e7f0ff"),
    string: rgb("#e7f0ff"),
    int: rgb("#fff0cf"),
    bool: rgb("#e2f4df"),
    datetime: rgb("#e9e1ff"),
    dictionary: rgb("#ececec"),
    array: rgb("#ececec"),
    arguments: rgb("#ececec"),
    function: rgb("#f7e0f4"),
    "none": rgb("#f2d2ca"),
    "auto": rgb("#f2d2ca"),
    "signature-func-name": red,
)

#set document(title: "SDU OS Slide Manual", author: "arshtyi")
#set page(
    paper: "a4",
    fill: paper,
    margin: (x: 2cm, y: 2.2cm),
    numbering: "1",
    header: context {
        if counter(page).get().first() > 1 {
            set text(size: 8pt, fill: muted)
            grid(
                columns: (1fr, auto),
                [SDU OS Slide], counter(page).display(),
            )
            v(3pt)
            line(length: 100%, stroke: 0.45pt + rule)
        }
    },
)
#set text(size: 10.5pt, fill: ink, font: ("Source Han Sans SC", "Calibri"))
#set par(justify: true, leading: 0.72em)
#set list(indent: 1.25em, body-indent: 0.45em)
#show link: set text(fill: red)
#show raw: set text(font: ("IBM Plex Mono", "Source Han Sans SC"))
#show raw.where(block: false): box.with(
    fill: rgb("#f4eeee"),
    inset: (x: 0.28em, y: 0.02em),
    outset: (y: 0.18em),
    radius: 2pt,
)
#show raw.where(block: true): block.with(
    width: 100%,
    fill: panel,
    stroke: 0.55pt + rule,
    inset: 9pt,
    radius: 3pt,
)
#show heading.where(level: 1): it => {
    block(below: 0.9em, {
        text(size: 22pt, weight: "bold", fill: red, it.body)
        v(5pt)
        line(length: 100%, stroke: 1.1pt + red)
    })
}
#show heading.where(level: 2): it => block(
    above: 0.85em,
    below: 0.4em,
    text(size: 15pt, weight: "bold", fill: red, it.body),
)
#show heading.where(level: 3): it => block(
    above: 0.55em,
    below: 0.25em,
    text(size: 11.5pt, weight: "bold", fill: ink, it.body),
)

#let card(title, body) = block(
    width: 100%,
    fill: panel,
    stroke: (left: 3pt + red, rest: 0.55pt + rule),
    inset: (x: 11pt, y: 8pt),
    radius: 3pt,
    [
        #text(weight: "bold", fill: red, title)
        #parbreak()
        #body
    ],
)

#let code(src) = raw(block: true, lang: "typ", src.text)

#let api-module(title, path, description) = {
    heading(level: 2, title)
    text(fill: muted, description)
    v(0.5em)
    let docs = tidy.parse-module(
        read(path),
        name: title,
        label-prefix: title + "-",
        scope: (sdu: sdu),
    )
    tidy.show-module(
        docs,
        style: tidy.styles.default,
        first-heading-level: 2,
        show-module-name: false,
        show-outline: true,
        sort-functions: none,
        colors: api-colors,
        omit-private-definitions: true,
        omit-private-parameters: true,
        local-names: (
            parameters: [Parameters],
            default: [Default],
            variables: [Variables],
        ),
    )
}

#v(1fr)
#align(center)[
    #stack(
        spacing: 12pt,
        image("../assets/sdu.png", width: 6.3cm),
        text(size: 30pt, weight: "bold", fill: red)[SDU OS Slide],
        text(size: 14pt, fill: muted)[A Typst slide template for SDU operating-system lectures],
        text(size: 9.5pt, fill: muted)[Guide and API reference],
    )
]
#v(1fr)

#columns(2)[
    #outline(
        title: align(center, box(width: 100%)[Guide]),
        indent: 1em,
        target: selector(heading).before(<reference>, inclusive: false),
    )
    #colbreak()
    #outline(
        title: align(center, box(width: 100%)[Reference]),
        indent: 1em,
        target: selector(heading).after(<reference>, inclusive: true),
    )
]

#pagebreak()
= Guide

SDU OS Slide recreates the visual language of the Shandong University operating-system course slides while keeping the source small and ordinary Typst. The public surface is intentionally narrow: import the setup function, write headings and content, and use a few overlay markers when a slide should build step by step.

== Quick Start

#code(
    `#import "slide.typ": setup, pause, meanwhile, jump, theme

#show: setup.with(
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    author: "arshtyi",
    term: "2026 Spring",
    date: datetime.today(),
    handout: false,
    sidebar-ring-style: 1,
)

= Chapter
== Slide Title

Always visible.

#pause

Visible on the next overlay.`,
)

#card[Import path][
    Use a relative import when working from this repository.
]

== Document Model

- `= Section` starts a new slide and appears as a top-level sidebar entry.
- `== Slide` starts a new slide, appears in the sidebar, and is highlighted while active.
- `=== Topic` starts a new slide but is rendered as a centered in-slide title instead of a sidebar entry.
- Deeper headings also inherit the slide-break rule, but they are best kept rare.

The right sidebar is built from outlined level 1 and level 2 headings. Each entry is a link to the original slide location.

== Visual Frame

`setup` renders a cover page, page frame, SDU logo, right sidebar, and decorative lower-right ring. The option `sidebar-ring-style` controls the ring/sidebar layering:

#table(
    columns: (auto, 1fr),
    stroke: 0.45pt + rule,
    inset: 7pt,
    fill: (_, row) => if row == 0 { red } else { panel },
    table.header(text(fill: white, weight: "bold")[Value], text(fill: white, weight: "bold")[Effect]),
    [`1`], [Current style. The ring is drawn above the sidebar table. This is the default.],
    [`2`],
    [Final style. Normal row fills sit below the ring, active row fill sits above it, and gutters mask the ring.],
)

Theme constants are exported as `theme`, so user documents can read values such as `theme.colors.primary` or `theme.page.sidebar-width` without duplicating them.

== Overlays

`pause`, `meanwhile`, and `jump` are small content markers processed by the theme's overlay renderer.

#table(
    columns: (auto, 1fr),
    stroke: 0.45pt + rule,
    inset: 7pt,
    fill: (_, row) => if row == 0 { red } else { panel },
    table.header(text(fill: white, weight: "bold")[Marker], text(fill: white, weight: "bold")[Meaning]),
    [`#pause`], [Advance by one overlay step. Later content is hidden until the next step.],
    [`#meanwhile`], [Reset following content back to the first overlay step. Useful for parallel build sequences.],
    [`#jump(n)`], [Low-level overlay control. Use `relative: true` to move relative to the current step.],
)

Set `handout: true` to output only the final overlay state of each slide.

== Build

The template is plain Typst. Useful smoke tests are:

#code(
    `typst compile --root . template/template.typ template/typst-sdu-os-slide.pdf
typst compile --root . docs/manual.typ docs/manual.pdf`,
)

#pagebreak()
= Reference <reference>

#api-module(
    "slide",
    "../slide.typ",
    [Public entry point. Most users import from this file only.],
)

#api-module(
    "theme",
    "../lib/theme.typ",
    [Main setup function and page-level theme wiring.],
)

#api-module(
    "overlays",
    "../lib/core/overlays.typ",
    [Overlay markers and the renderer used by `setup`.],
)

#api-module(
    "foundation-theme",
    "../lib/foundation/theme.typ",
    [Shared fonts, colors, and page geometry.],
)

#api-module(
    "cover",
    "../lib/components/cover.typ",
    [Cover-page component.],
)

#api-module(
    "sidebar",
    "../lib/components/sidebar.typ",
    [Right-side outline, active-row detection, and sidebar/ring layering helpers.],
)

#api-module(
    "draw",
    "../lib/utils/draw.typ",
    [Low-level drawing helpers.],
)
