#import "utils.typ": balanced-cols, fakesc, font, font-size, heading-numbering, prefix-chapter
#import "cover.typ" as cover
#import "styles.typ" as styles
#import "../common/src/colors.typ" as colors


// Divide the manuscript into parts. The Chapters still use the `= ` syntactic
// sugar and are numbered independently of parts.
#let part(title) = heading(level: 1, outlined: true, numbering: "I", title)

// The inscription at the beginning of the document (e.g. "To my fammily...")
#let insciption(body) = {
  pagebreak(weak: true, to: "odd")
  align(horizon + right, text(style: "italic", body))
}
