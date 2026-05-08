#import "@preview/tidy:0.4.3"
#import "../slide.typ" as sdu
#import "manual-style.typ" as manual-style: (
    code, example-pair, info, muted, note, option-table, panel, pill, red, red-soft, rule, tip,
)

#show: manual-style.setup

#let param(module-name, fn, arg, full: false) = {
    let label-prefix = module-name + "-"
    let func-name = fn.text
    let arg-name = arg.text
    let arg-link = link(label(label-prefix + func-name + "." + arg-name), raw(arg-name, lang: none))
    if full {
        [the #arg-link option of #link(label(label-prefix + func-name + "()"), raw(func-name + "()", lang: none))]
    } else {
        arg-link
    }
}

#let api-module(title, path, description, only: none) = {
    heading(level: 2, title)
    text(fill: muted, description)
    v(0.5em)
    let docs = tidy.parse-module(
        read(path),
        name: title,
        label-prefix: title + "-",
        scope: (
            sdu: sdu,
            theme: sdu.theme,
            setup: sdu.setup,
            pause: sdu.pause,
            meanwhile: sdu.meanwhile,
            jump: sdu.jump,
            param: param,
        ),
    )
    if only != none {
        docs.functions = only.map(name => docs.functions.find(fn => fn.name == name)).filter(x => x != none)
        docs.variables = only.map(name => docs.variables.find(var => var.name == name)).filter(x => x != none)
    }
    tidy.show-module(
        docs,
        style: manual-style,
        first-heading-level: 2,
        show-module-name: false,
        show-outline: true,
        sort-functions: none,
        colors: manual-style.colors,
        omit-private-definitions: true,
        omit-private-parameters: true,
        local-names: (
            parameters: [Parameters],
            default: [Default],
            variables: [Variables],
        ),
    )
}

#v(0.35fr)
#grid(
    columns: (1.2fr, 0.8fr),
    gutter: 18pt,
    align: (horizon, horizon),
    [
        #image("../assets/sdu.png", width: 6.3cm)
        #v(20pt)
        #text(size: 31pt, weight: "bold", fill: red)[SDU OS Slide]
        #v(7pt)
        #text(size: 13.5pt, fill: muted)[Manual for the Shandong University OS slide template]
        #v(12pt)
        #line(length: 72%, stroke: 1.1pt + red)
        #v(12pt)
        #text(size: 9.5pt, fill: muted)[Guide, examples, and API reference]
    ],
    [
        #block(
            fill: panel,
            stroke: 0.55pt + rule,
            inset: 14pt,
            radius: 4pt,
            [
                #text(size: 8.5pt, fill: muted)[PUBLIC SURFACE]
                #parbreak()
                #pill[`setup()`] #h(3pt) #pill[`pause`] #h(3pt) #pill[`meanwhile`] #h(3pt) #pill[`jump()`]
                #v(10pt)
                #text(size: 8.5pt, fill: muted)[DESIGN TOKENS]
                #parbreak()
                #pill(fill: rgb("#f4d7da"))[`theme.colors.primary`]
                #h(3pt)
                #pill(fill: rgb("#e7f0ff"))[`theme.page.sidebar-width`]
            ],
        )
    ],
)
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
        target: selector(heading.where(level: 1)).or(heading.where(level: 2)).after(<reference>, inclusive: true),
    )
]

#pagebreak()
= Guide

SDU OS Slide recreates the visual language of the Shandong University operating-system course slides while keeping the authoring model deliberately small. A deck imports one setup function, writes ordinary Typst headings, and uses three overlay markers when a slide should build step by step.

#info[What the template owns][
    `setup()` installs the cover, page frame, right sidebar, logo, heading behavior, raw-code styling, and overlay renderer. Your deck remains normal Typst content inside that frame.
]

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

#tip[Import path][Use a relative import while working from this repository.]

== Slide Model

The template uses Typst headings as slide boundaries:

- `= Section` starts a new slide and appears as a major sidebar entry.
- `== Slide` starts a new slide, appears in the sidebar, and is highlighted while active.
- `=== Topic` starts a new slide but is rendered as a centered in-slide title instead of a sidebar entry.
- Deeper headings inherit the slide-break rule, but they are best reserved for rare focus pages.

The right sidebar is built from outlined level 1 and level 2 headings. Each row is linked to the original heading location, so exported PDFs keep navigable section entries.

== Setup Options

#option-table(
    [`title`],
    [`str` / `"SDU OS Slide"`],
    [Main cover title.],
    [`subtitle`],
    [`str` / `"Slide for SDU OS"`],
    [Cover subtitle and sidebar title.],
    [`author`],
    [`str` / `"arshtyi"`],
    [Cover badge and sidebar footer.],
    [`term`],
    [`str` / `"2026 Spring"`],
    [Cover badge.],
    [`date`],
    [`datetime` / `datetime.today()`],
    [Sidebar footer date, shown as `YYYY.MM`.],
    [`handout`],
    [`bool` / `false`],
    [When true, each slide keeps only its final overlay state.],
    [`sidebar-ring-style`],
    [`int` / `1`],
    [Controls the layering between the right sidebar and the lower-right decorative ring.],
)

#note[Sidebar ring styles][
    `sidebar-ring-style: 1` keeps the decorative ring above the sidebar table. `sidebar-ring-style: 2` recreates the original slide layering more closely: normal row fills sit below the ring, the active row sits above it, and gutters mask the ring.
]

== Theme Tokens

Theme constants are exported as `theme` so user documents can read canonical values without copying magic numbers.

#table(
    columns: (1.5fr, 2.4fr),
    fill: (_, row) => if row == 0 { red } else { panel },
    table.header(text(fill: white, weight: "bold")[Token], text(fill: white, weight: "bold")[Use]),
    [`theme.colors.primary`], [SDU red for frame, cover badges, active sidebar rows, and headings.],
    [`theme.colors.primary-soft`], [Muted red for sidebar title rows and softer table fills.],
    [`theme.colors.primary-muted`], [Quiet sidebar row fill.],
    [`theme.page.sidebar-width`], [Reserved width for the right sidebar.],
    [`theme.fonts.content`], [Default body font pair used inside slides.],
)

== Overlays

`pause`, `meanwhile`, and `jump` are metadata markers processed by the overlay renderer. They do not draw anything by themselves.

#table(
    columns: (auto, 1fr),
    fill: (_, row) => if row == 0 { red } else { panel },
    table.header(text(fill: white, weight: "bold")[Marker], text(fill: white, weight: "bold")[Meaning]),
    [`#pause`], [Advance by one overlay step. Later content is hidden until the next step.],
    [`#meanwhile`], [Reset following content back to overlay step 1. Useful for two parallel reveal sequences.],
    [`#jump(n)`],
    [Low-level overlay control. With `relative: true`, moves relative to the current step; otherwise jumps to an absolute step.],
)

#example-pair(
    `Always visible.

#pause

Visible on overlay 2.

#meanwhile

Also visible from overlay 1.`,
    [
        #text(weight: "bold", fill: red)[Reveal timeline]
        #v(4pt)
        #table(
            columns: (auto, 1fr),
            stroke: none,
            fill: (_, row) => if row == 0 { red-soft } else { white },
            table.header(text(fill: white)[Step], text(fill: white)[Visible content]),
            [1], [Always visible; meanwhile branch begins.],
            [2], [Everything from step 1 plus content after `pause`.],
        )
    ],
)

#tip[Handout build][
    Set `handout: true` to output only the final overlay state of each slide. This is useful for reading PDFs or course handouts.
]

== Build Commands

The template is plain Typst. These are useful smoke tests before publishing changes:

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
