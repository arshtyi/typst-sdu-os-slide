#import "../slide.typ": jump, meanwhile, pause, setup, theme
#import "utils.typ": *

#show: setup.with(
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    author: "arshtyi",
    term: "2026 Spring",
    date: datetime.today(),
    handout: false,
)

= Overview

== Template Goals

#feature-table(
    [Look],
    [Cover, frame, sidebar, SDU logo, and course-flavored color tokens.],
    [Structure],
    [`= Section` and `== Slide` are slide boundaries and sidebar entries.],
    [Animation],
    [`#pause`, `#meanwhile`, and `#jump` provide incremental overlays.],
    [Docs],
    [Public functions are documented with tidy-friendly `///` comments.],
)

== Writing Model

- Use markup for prose, lists, headings, and emphasis.
- Use `#` to call functions, read theme values, and generate repeated content.
- Use math mode for formulas, for example $H = - sum_i p_i log p_i$.

#note-box[Heading rule][
    Level 1, level 2, and level 3 headings start new slide pages. Level 3 headings are rendered as centered red titles.
]

= Usage

== Minimal

Start with the public entry point `slide.typ`.

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

= Chapter
== Slide Title

Write slide content here.
```

== Theme Values

The exported `theme` dictionary contains the shared design tokens.

#feature-table(
    [`theme.fonts.cover`],
    [Cover-page title font.],
    [`theme.fonts.content`],
    [CJK and Latin fonts for normal slide text.],
    [`theme.colors.primary`],
    [Main SDU red used for frame, highlights, and active sidebar rows.],
    [`theme.page.sidebar-width`],
    [Width of the right outline sidebar.],
)

=== Level 3 Slide

This page is created by a level 3 heading. It is not shown in the sidebar, but it is still a slide boundary and is rendered as a centered title.

= Overlays

== Pause

This example is in presentation mode because `handout: false`. Change it to
`handout: true` when you want a distribution PDF with only the final state of
each slide.

`#pause` advances to the next overlay. Content after it is hidden first and revealed later.

Always visible.

#pause

Visible on overlay 2.

#pause

Visible on overlay 3.

=== Handout Mode

Use `handout: true` for a distribution PDF. In handout mode, every slide is rendered once with the final overlay state.

```typ
#show: setup.with(
    handout: true,
)
```

== Meanwhile

`#meanwhile` resets subsequent content back to the first overlay. It is useful when two groups should build independently.

Left story starts here.

#pause

Left story continues on overlay 2.

#meanwhile

Right story is visible from overlay 1.

#pause

Right story continues on overlay 2.

== Jump

`#jump` is the lower-level primitive behind `pause` and `meanwhile`.

- `#pause` is the same as `#jump(1, relative: true)`.
- `#meanwhile` is the same as `#jump(1)`.
- Relative jumps can skip or revisit overlay steps when you need manual control.

#jump(2, relative: true)

This line appears after skipping one overlay step.

= Components

== Sidebar

The sidebar is built from level 1 and level 2 headings.

#feature-table(
    [Level 1],
    [Rendered as a section heading in the outline.],
    [Level 2],
    [Rendered as a slide heading and highlighted while active.],
    [Links],
    [Sidebar entries jump to the original heading locations.],
)

== Code and Keys

Inline code uses a quiet gray background, and block code is framed for scanning.

Press #keydown("Ctrl") + #keydown("S") to save, then compile with:

```bash
typst compile --root . template/template.typ template/template.pdf
```

== Terms Layout

#show terms: terms-list => {
    let term-cells = ()
    set par(justify: false)
    for item in terms-list.children {
        term-cells.push(block(text(fill: primary, weight: "bold", item.term)))
        term-cells.push(block(item.description))
    }
    grid(
        columns: (auto, 1fr),
        column-gutter: 1.6em,
        row-gutter: 0.45em,
        align: (left, left),
        ..term-cells,
    )
}

/ `setup`: Applies page layout, cover, sidebar, heading rules, and overlays.
/ `pause`: Reveals following content one overlay later.
/ `meanwhile`: Starts a parallel reveal sequence from overlay 1.
/ `theme`: Provides fonts, colors, and dimensions for custom slide content.

= Closing

== Checklist

- Import from `slide.typ`, not directly from `lib`.
- Use `= / ==` for slide boundaries.
- Use `===` for in-slide section titles.
- Use `#pause` and `#meanwhile` for incremental content.
- Keep custom styles local to the slide when possible.

#note-box[Next step][
    Open `docs/manual.pdf` for the generated manual and API reference. Use this file as a visual smoke test for template changes.
]
