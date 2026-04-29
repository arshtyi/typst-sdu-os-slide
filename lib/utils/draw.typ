#import "@preview/cetz:0.5.0"

#let place-circle(center-x, center-y, radius, ..style) = place(
    top + left,
    dx: center-x - radius,
    dy: center-y - radius,
    cetz.canvas({
        import cetz.draw: *
        circle((0pt, 0pt), radius: radius, ..style)
    }),
)
