#let primary = (dark: rgb("#000000"), light: rgb("#ffffff"))
#let accent-green = (dark: rgb("#007852"), light: rgb("#65b32e"))
#let accent-cyan = (dark: rgb("#004070"), light: rgb("#00abe4"))
#let accent-blue = (dark: rgb("#3a1c67"), light: rgb("#4054a1"))
#let accent-purple = (dark: rgb("#751b74"), light: rgb("#a877b2"))
#let accent-pink = (dark: rgb("#a8004d"), light: rgb("#ed6ea7"))
#let accent-red = (dark: rgb("#b51f1f"), light: rgb("#e63312"))
#let accent-orange = (dark: rgb("#cc621a"), light: rgb("#f7a600"))

#let display-palette() = {
  let colors = (
    primary: primary,
    accent-green: accent-green,
    accent-cyan: accent-cyan,
    accent-blue: accent-blue,
    accent-purple: accent-purple,
    accent-pink: accent-pink,
    accent-red: accent-red,
    accent-orange: accent-orange,
  )
  grid(
    columns: 3,
    align: center + horizon,
    inset: 1cm,
    [],
    grid.vline(stroke: 2pt),
    [dark],
    [light],
    grid.hline(stroke: 2pt),
    ..for (name, colors) in colors.pairs() {
      (name, grid.cell(fill: colors.dark)[], grid.cell(fill: colors.light)[])
    }
  )
}
