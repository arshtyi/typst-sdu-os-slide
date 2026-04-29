#import "../foundation/theme.typ": theme

#let format-outline-heading(heading-node) = {
    let location = heading-node.location()
    let heading-numbers = counter(heading).at(location)
    let body = if heading-node.numbering == none {
        text(weight: "bold", heading-node.body)
    } else {
        let heading-number = numbering(heading-node.numbering, ..heading-numbers)
        text(weight: "regular", heading-number)
        if heading-node.level == 1 {
            [] + text(weight: "bold", heading-node.body)
        } else {
            h(0.3em) + text(weight: "regular", heading-node.body)
        }
    }
    link(location, body)
}

#let find-active-subheading(outline-headings, current-page) = {
    let active-subheading = none
    for (index, heading-node) in outline-headings.enumerate() {
        if heading-node.level != 2 { continue }
        let start-page = counter(page).at(heading-node.location()).first()
        let next-heading = outline-headings.at(index + 1, default: none)
        let end-page = if next-heading == none {
            none
        } else {
            counter(page).at(next-heading.location()).first()
        }
        if current-page >= start-page and (end-page == none or current-page < end-page) {
            active-subheading = heading-node
        }
    }
    active-subheading
}

#let build-outline-cells(outline-headings, active-subheading) = {
    let fonts = theme.fonts
    let cells = ()
    let active-row = none
    for (index, heading-node) in outline-headings.enumerate() {
        let row = cells.len() + 1
        let is-active = (
            active-subheading != none
                and heading-node.level == 2
                and heading-node.location() == active-subheading.location()
        )
        if is-active {
            active-row = row
        }
        cells.push(
            table.cell(
                align: if heading-node.level == 1 { center + horizon } else { left + horizon },
                inset: (x: 5pt, y: 1pt),
                text(
                    font: fonts.outline,
                    size: 18pt,
                    fill: if is-active { white } else { black },
                    format-outline-heading(heading-node),
                ),
            ),
        )
        if heading-node.level == 2 {
            let next-heading = outline-headings.at(index + 1, default: none)
            if next-heading == none or next-heading.level == 1 {
                cells.push(table.cell([]))
            }
        }
    }
    (cells: cells, active-row: active-row)
}

#let render-sidebar(title, author, date) = context {
    let colors = theme.colors
    let outline-headings = query(heading.where(outlined: true)).filter(heading-node => heading-node.level <= 2)
    let current-page = counter(page).get().first()
    let active-subheading = find-active-subheading(outline-headings, current-page)
    let outline = build-outline-cells(outline-headings, active-subheading)
    let outline-cells = outline.cells
    let row-count = outline-cells.len()
    table(
        columns: (1fr,),
        rows: (1fr,) * (row-count + 2),
        fill: (_, row) => if outline.active-row != none and row == outline.active-row {
            colors.primary
        } else if row == 0 {
            colors.primary-soft
        } else {
            colors.primary-muted
        },
        row-gutter: range(0, row-count + 1).map(index => if index == 0 { 0.2em } else { 0.1em }),
        stroke: none,
        align: center + horizon,
        table.cell(text(size: 20pt, weight: "bold", title)),
        ..outline-cells,
        table.cell(text(size: 12pt, fill: colors.meta)[#author #h(0.4em) #date.display("[year].[month]")]),
    )
}
