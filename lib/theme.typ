#import "@preview/numbly:0.1.0": *
#import "components/cover.typ": render-cover
#import "components/sidebar.typ": render-sidebar
#import "foundation/theme.typ": theme
#import "utils/draw.typ": place-circle

#let setup(
    author: "arshtyi",
    term: "2026 Spring",
    title: "SDU OS Slide",
    subtitle: "Slide for SDU operating system",
    date: datetime.today(),
    body,
) = {
    let colors = theme.colors
    let page-config = theme.page
    set page(
        width: page-config.width,
        height: page-config.height,
        margin: 0cm,
    )
    render-cover(
        title: title,
        subtitle: subtitle,
        author: author,
        term: term,
    )
    set heading(numbering: numbly(
        "{1:一}、",
        "{1:1}.{2:1} ",
        "",
    ))
    show heading: heading-node => {
        pagebreak(weak: true)
        if heading-node.level > 2 {
            set align(center)
            text(size: 20pt, fill: theme.colors.primary, heading-node)
        } else { [] }
    }
    show heading.where(level: 3): set block(below: 2em)
    set page(
        margin: (
            right: page-config.sidebar-width + 1cm,
            left: 1cm,
            top: 1cm,
            bottom: 1cm,
        ),
        foreground: {
            place(
                dx: 27.44cm,
                dy: 0.1cm,
                block(
                    width: 6.02cm,
                    height: 1.59cm,
                    image("../assets/sdu.png"),
                ),
            )
            place(
                dx: 27.12cm,
                dy: 1.88cm,
                block(
                    width: page-config.sidebar-width,
                    height: page-config.sidebar-height,
                    render-sidebar(subtitle, author, date),
                ),
            )
            place-circle(
                32.3cm + 3.56cm / 2,
                17.7cm + 3.56cm / 2,
                3.56cm / 2,
                fill: colors.primary,
                stroke: none,
            )
            place-circle(
                32.3cm + 3.56cm / 2,
                17.7cm + 3.56cm / 2,
                1.005cm,
                fill: rgb("e6c2c4"),
                stroke: none,
            )
            place(
                dx: 0.07cm,
                dy: 0.1cm,
                rect(
                    width: page-config.frame-width,
                    height: page-config.frame-height,
                    radius: 15pt,
                    stroke: 3pt + colors.primary,
                ),
            )
        },
    )
    set text(size: 20pt, font: (theme.fonts.content.cjk, theme.fonts.content.latin))
    // show terms: terms-list => {
    //     let term-cells = ()
    //     set par(justify: false)
    //     for item in terms-list.children {
    //         term-cells.push(block(text(fill: theme.colors.primary, item.term)))
    //         term-cells.push(block(item.description))
    //     }
    //     grid(
    //         columns: (auto, 1fr),
    //         column-gutter: 2em,
    //         row-gutter: 0.6em,
    //         align: (left, left),
    //         ..term-cells,
    //     )
    // }
    body
}
