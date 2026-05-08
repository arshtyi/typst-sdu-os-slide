#import "@preview/tidy:0.4.3"

#let red = rgb("#9c0b15")
#let red-soft = rgb("#ce858a")
#let red-pale = rgb("#f5eeee")
#let ink = rgb("#202124")
#let muted = rgb("#5f6368")
#let paper = rgb("#fbfaf8")
#let panel = rgb("#ffffff")
#let rule = rgb("#e7dada")
#let cream = rgb("#fff7ed")
#let green-soft = rgb("#e2f4df")
#let blue-soft = rgb("#e7f0ff")

#let colors = (
    tidy.styles.default.colors
        + (
            default: rgb("#f4eeee"),
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
            module: rgb("#e9f5f6"),
            length: rgb("#fff0cf"),
            color: gradient.linear(angle: 12deg, rgb("#f9d4d8"), rgb("#fdeec8"), rgb("#dcefe0")),
            "none": rgb("#f2d2ca"),
            "auto": rgb("#f2d2ca"),
            "signature-func-name": red,
        )
)

#let _local(key, style-args) = tidy.utilities.get-local-name(key, style-args: style-args)

#let setup(body) = {
    set document(title: "SDU OS Slide Manual", author: "arshtyi")
    set page(
        paper: "a4",
        fill: paper,
        margin: (x: 1.9cm, y: 2.05cm),
        numbering: "1",
        header: context {
            if counter(page).get().first() > 1 {
                set text(size: 8pt, fill: muted)
                grid(
                    columns: (1fr, auto),
                    [SDU OS Slide Manual], counter(page).display(),
                )
                v(3pt)
                line(length: 100%, stroke: 0.45pt + rule)
            }
        },
    )
    set text(size: 10.5pt, fill: ink, font: ("Source Han Sans SC", "Calibri"))
    set par(justify: true, leading: 0.72em)
    set list(indent: 1.2em, body-indent: 0.45em)
    set table(stroke: 0.45pt + rule, inset: 7pt)
    show link: set text(fill: red)
    show raw: set text(font: ("IBM Plex Mono", "Source Han Sans SC"))
    show raw.where(block: false): box.with(
        fill: red-pale,
        inset: (x: 0.28em, y: 0.02em),
        outset: (y: 0.18em),
        radius: 2pt,
    )
    show raw.where(block: true): block.with(
        width: 100%,
        fill: panel,
        stroke: 0.55pt + rule,
        inset: 9pt,
        radius: 3pt,
    )
    show heading.where(level: 1): it => {
        block(below: 0.9em, {
            text(size: 22pt, weight: "bold", fill: red, it.body)
            v(5pt)
            line(length: 100%, stroke: 1.1pt + red)
        })
    }
    show heading.where(level: 2): it => block(
        above: 0.8em,
        below: 0.4em,
        text(size: 15pt, weight: "bold", fill: red, it.body),
    )
    show heading.where(level: 3): it => block(
        above: 0.55em,
        below: 0.25em,
        text(size: 11.5pt, weight: "bold", fill: ink, it.body),
    )
    show ref: it => {
        if it.element != none and it.element.func() == heading {
            link(it.target, it.element.body)
        } else {
            it
        }
    }

    body
}

#let code(src) = raw(block: true, lang: "typ", src.text)

#let pill(body, fill: red-pale, stroke: none) = box(
    fill: fill,
    stroke: stroke,
    inset: (x: 6pt, y: 2pt),
    radius: 2pt,
    body,
)

#let card(title, body, fill: panel, accent: red) = block(
    width: 100%,
    fill: fill,
    stroke: (left: 3pt + accent, rest: 0.55pt + rule),
    inset: (x: 11pt, y: 8pt),
    radius: 4pt,
    [
        #text(weight: "bold", fill: accent, title)
        #parbreak()
        #body
    ],
)

#let note(title, body) = card(title, body, fill: cream, accent: rgb("#b35c18"))
#let tip(title, body) = card(title, body, fill: green-soft, accent: rgb("#3f7f4a"))
#let info(title, body) = card(title, body, fill: blue-soft, accent: rgb("#3768a6"))

#let option-table(..rows) = table(
    columns: (1.1fr, 1.8fr, 2.8fr),
    fill: (_, row) => if row == 0 { red } else { panel },
    table.header(
        text(fill: white, weight: "bold")[Name],
        text(fill: white, weight: "bold")[Type / Default],
        text(fill: white, weight: "bold")[Effect],
    ),
    ..rows.pos(),
)

#let example-pair(src, preview) = grid(
    columns: (1.15fr, 0.85fr),
    gutter: 10pt,
    align: (top, top),
    block(
        fill: panel,
        stroke: 0.55pt + rule,
        inset: 9pt,
        radius: 4pt,
        raw(block: true, lang: "typ", src.text),
    ),
    block(fill: red-pale, stroke: 0.55pt + rule, inset: 9pt, radius: 4pt, preview),
)

#let show-outline(module-doc, style-args: (:)) = {
    let prefix = module-doc.label-prefix
    let link-def(name, suffix: "") = if style-args.enable-cross-references {
        link(label(prefix + name + suffix), raw(name + suffix, lang: none))
    } else {
        raw(name + suffix, lang: none)
    }

    if module-doc.functions.len() + module-doc.variables.len() == 0 {
        return none
    }

    block(
        width: 100%,
        fill: red-pale,
        stroke: 0.55pt + rule,
        inset: (x: 11pt, y: 8pt),
        radius: 4pt,
        {
            set list(marker: none, indent: 0pt, body-indent: 0pt)
            if module-doc.functions.len() > 0 {
                list(..module-doc.functions.map(fn => link-def(fn.name, suffix: "()")))
            }
            if module-doc.variables.len() > 0 {
                v(4pt)
                text(weight: "bold", fill: red, _local("variables", style-args))
                list(..module-doc.variables.map(var => link-def(var.name)))
            }
        },
    )
    v(1em)
}

#let show-type(type-name, style-args: (:)) = {
    let active-colors = if style-args.colors == auto { colors } else { style-args.colors }
    let fill = active-colors.at(type-name, default: active-colors.at("default", default: rgb("#eff0f3")))
    let border = if type(fill) == color { fill.darken(12%) } else { rule }
    box(
        fill: fill,
        stroke: 0.35pt + border,
        inset: (x: 4pt, y: 1.2pt),
        outset: (x: 1.5pt, y: 1.5pt),
        radius: 2pt,
        raw(type-name, lang: none),
    )
}

#let show-parameter-list(fn, style-args: (:)) = {
    block(
        width: 100%,
        fill: panel,
        stroke: 0.55pt + rule,
        inset: 9pt,
        radius: 4pt,
        {
            set text(font: ("IBM Plex Mono", "Source Han Sans SC"), size: 0.86em, weight: 360)
            text(fn.name, fill: colors.at("signature-func-name"))
            "("
            let inline = fn.args.len() <= 2
            if not inline { linebreak() + h(1em) }
            let items = ()
            for (name, info) in fn.args {
                if style-args.omit-private-parameters and name.starts-with("_") { continue }
                let shown = if (
                    style-args.enable-cross-references
                        and not (
                            info.at("description", default: "") == "" and style-args.omit-empty-param-descriptions
                        )
                ) {
                    link(label(style-args.label-prefix + fn.name + "." + name.trim(".")), name)
                } else {
                    name
                }
                let types = if "types" in info {
                    [#h(0.2em): #info.types.map(x => show-type(x, style-args: style-args)).join(h(2pt))]
                } else {
                    []
                }
                items.push(shown + types)
            }
            items.join(if inline { [, ] } else { [,#linebreak()#h(1em)] })
            if not inline { linebreak() }
            ")"
            if "return-types" in fn and fn.return-types != none {
                [ #h(0.25em)-> #fn.return-types.map(x => show-type(x, style-args: style-args)).join(h(2pt))]
            }
        },
    )
}

#let show-parameter-block(
    function-name: none,
    name,
    types,
    content,
    style-args,
    show-default: false,
    default: none,
) = {
    block(
        width: 100%,
        fill: rgb("#fffefe"),
        stroke: (left: 2.2pt + red-soft, rest: 0.45pt + rule),
        inset: (x: 10pt, y: 7pt),
        radius: 3pt,
        breakable: style-args.break-param-descriptions,
        {
            [
                #text(weight: "bold", raw(name, lang: none))
                #if function-name != none and style-args.enable-cross-references {
                    label(function-name + "." + name.trim("."))
                }
            ]
            if types.len() > 0 {
                h(0.8em)
                types.map(x => show-type(x, style-args: style-args)).join(text(size: 0.72em, fill: muted)[ or ])
            }
            if show-default {
                h(0.8em)
                text(size: 0.78em, fill: muted)[default]
                h(0.25em)
                raw(default, lang: "typc")
            }
            parbreak()
            content
        },
    )
    v(0.35em)
}

#let show-function(fn, style-args) = {
    if style-args.colors == auto {
        style-args.colors = colors
    }

    [
        #heading(raw(fn.name + "()", lang: none), level: style-args.first-heading-level + 1)
        #if style-args.enable-cross-references {
            label(style-args.label-prefix + fn.name + "()")
        }
    ]

    tidy.utilities.eval-docstring(fn.description, style-args)

    block(breakable: false, {
        heading(_local("parameters", style-args), level: style-args.first-heading-level + 2)
        show-parameter-list(fn, style-args: style-args)
    })

    for (name, info) in fn.args {
        if style-args.omit-private-parameters and name.starts-with("_") { continue }
        let description = info.at("description", default: "")
        if description == "" and style-args.omit-empty-param-descriptions { continue }
        show-parameter-block(
            name,
            info.at("types", default: ()),
            tidy.utilities.eval-docstring(description, style-args),
            style-args,
            show-default: "default" in info,
            default: info.at("default", default: none),
            function-name: style-args.label-prefix + fn.name,
        )
    }
    v(2.4em, weak: true)
}

#let show-variable(var, style-args) = {
    if style-args.colors == auto {
        style-args.colors = colors
    }
    [
        #heading(raw(var.name, lang: none), level: style-args.first-heading-level + 1)
        #if style-args.enable-cross-references {
            label(style-args.label-prefix + var.name)
        }
    ]
    if "type" in var {
        show-type(var.type, style-args: style-args)
        v(0.35em)
    }
    tidy.utilities.eval-docstring(var.description, style-args)
    v(2.4em, weak: true)
}

#let show-reference(label, name, style-args: none) = link(label, raw(name, lang: none))

#let show-example(..args) = tidy.styles.default.show-example(..args)
