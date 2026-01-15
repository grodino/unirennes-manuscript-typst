#let fakesc(s, scaling: 0.75) = {
  show regex("\p{Ll}+"): it => {
    context text(scaling * 1em, tracking: 1pt, upper(it))
  }
  text(s)
}
