#import "@preview/hydra:0.6.1": hydra

#import "utils.typ": balanced-cols, fakesc, font, font-size, heading-numbering, prefix-chapter

/// Styles for the acknowlegments, abstract and table of content/figures/... 
/// To be applied right before the preamble (but after the cover)
#let preamble(body) = {
  // Count pages with letters
  set page(header: none, numbering: "i")
  // Do not count the contents as a chapters.
  show heading: set heading(numbering: none)

  body
}

/// Style for appendices
#let appendix(body, root-level: 3) = {
  // The supplement for the sections and subsections is "appendix".
  show heading.where(level: root-level): set heading(supplement: "Appendix")
  
  // Subsections are numbered with capital letters, without the section number.
  show heading.where(level: root-level+1): set heading(
    numbering: heading-numbering.with(levels: root-level+1, style: "A.1."),
    supplement: "Appendix"
  )

  body
}

/// General styles for the template. To be applided at the beginning of the document.
#let matisse-thesis(
  author: "",
  title: "",
  body-paper: "a4",
  draft: false,
  font-size: font-size,
  font: font,
  body,
) = {
  //////////////////////////////////////////////////////////////////////////////
  /// GENERAL SETTINGS
  set document(
    author: author,
    title: title,
  )


  set page(
    body-paper,
    // ------------ MARGINS ------------ //
    margin: (outside: 15mm, inside: 20mm, top: 20mm, bottom: 15mm),

    // ------------ PAGE NUMBERS ------------ //
    numbering: "1",
    number-align: center,

    // ------------ HEADER ------------ //
    header: context {
      // disable linebreaks in header
      show linebreak: none

      // get the current page number
      let current-page = here().page()
      // let current-page = counter(page).get().first()

      // if the page starts a level-2 heading (i.e., chapters), display nothing
      let all-chapters = query(heading.where(level: 2))
      if all-chapters.any(it => it.location().page() == current-page) {
        return
      }

      // if the page is odd vs even
      if calc.odd(current-page) {
        // display the last level-2 heading (i.e., chapters)
        let header-content = hydra(
          2,
          display: (_, it) => {
            if it.numbering != none {
              let nb = counter(heading).at(it.location())
              let nb-fmt = numbering(it.numbering, ..nb)
              [#it.supplement #nb-fmt -- _ #it.body _]
            } else { emph(it.body) }
          },
        )
        text(size: font-size.text, header-content)
      } else {
        // display last level-3 heading (current page included)
        let header-content = hydra(
          3,
          use-last: true,
          display: (_, it) => {
            if it.numbering == none [_ #it.body _] else {
              let nb = counter(heading).at(it.location())
              let nb-fmt = numbering(
                it.numbering,
                ..nb,
              )
              [_ #nb-fmt #it.body _]
            }
          },
        )
        align(right, text(size: font-size.text, header-content))
      }

      // horizontal rule
      v(-.3cm)
      line(length: 100%, stroke: .2mm)
    },
  )

  // ------------ HEADINGS ------------ //
  set heading(
    offset: 1,
    // Default numbering is display only sections, subsections, ... numbers
    numbering: heading-numbering.with(levels: 2),
  )

  // Level 1 headings are parts
  show heading.where(level: 1): set heading(supplement: [Part])
  show heading.where(level: 1): it => {
    set page(numbering: none, header: none)
    set align(center + horizon)
    pagebreak(to: "odd")

    text(
      size: font-size.heading.display.supplement,
      font: font.decorated,
      smallcaps[#it.supplement #it.numbering],
    )
    v(-1cm)
    text(smallcaps(it.body), font: font.title, size: font-size.heading.display.title)
  }

  // Level 2 headings are chapters
  show heading.where(level: 2): set heading(supplement: [Chapter], numbering: heading-numbering.with(levels: 2))
  show heading.where(level: 2): it => context {
    // always start on odd pages and make sure that there is no headers on the blank pages
    {
      set page(numbering: none, header: none)
      pagebreak(to: "odd", weak: false)
    }
  
    // Reset the equation numbers and set the figures counters
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    
    // Style the chapter number
    // Whether or not to display the chapter number/supplement "Chapter X". E.g.
    // for the acknowledgements, we do not display it
    let number = if it.numbering != none {
      let chap-nb = counter(heading).get().at(1)
      let fmt-nb = numbering("1", chap-nb)
      
      box(fill: black,width: 3.8cm, height: 3.8cm, {
        set text(fill: white)
        set align(horizon)
        h(1fr)
        box(
          inset: (right: .5em),
          rotate(-90deg, reflow: true, fakesc(text(font:"UniRennes", size: 23pt)[Chapter]))
        )
        h(.1fr)
        text(font:"UniRennes Inline", size: 120pt, fmt-nb)
        h(1fr)
      })
    }
  
    // Heading body
    set par(justify: false)
    grid(
      columns: (1fr, auto),
      gutter: 2em,
      align: bottom,
      text(font: font.title, size: font-size.heading.display.title, hyphenate: false, smallcaps(it.body)),
      // text(font: font.text, size: font-size.heading.display.title, hyphenate: false, it.body),
      number
    )
    v(4em)
  }

  // Headings with level 3 and 4 are sections and subsections
  show heading.where(level: 3): set text(font: font.heading, size: font-size.heading.text.at(0))
  show heading.where(level: 3): set heading(supplement: "Section", numbering: heading-numbering.with(levels: 3))
  
  show heading.where(level: 4): set text(font: font.heading, size: font-size.heading.text.at(1))
  show heading.where(level: 4): set heading(supplement: "Subsection", numbering: heading-numbering.with(levels: 3))

  // Headings of level 5 are unnumbered, they represent paragraphs
  show heading.where(level: 5): set heading(numbering: none, outlined: false, bookmarked: false)
  show heading.where(level: 5): it => {
    it.body + h(font-size.text / 2)
  }


  // ----------- TEXT ----------- //
  set par(justify: true)
  set par.line(
    numbering: if draft {
      num => text(font: "Fira Mono", fill: black, size: 8pt, [#num])
    } else { none }
  )  
  set text(font: font.text, size: font-size.text, fill: black, lang: "en")
  // Current NewsReader font file does not support small caps
  show smallcaps: it => fakesc(it)


  // ------------ FIGURES ------------ //
  // Figure numbers are (chap_no.eq_no). 
  // The eq_no counter is reset every chapter in the corresponding show rule.  
  show figure.where(kind: image): set figure(numbering: prefix-chapter, placement: top)
  show figure.where(kind: table): set figure(numbering: prefix-chapter, placement: top)
  show figure.where(kind: raw): set figure(placement: top, supplement: "Algorithm")
  
  show figure.caption: it => box(
    inset: (left: 1em, right: 1em),
    align(left, it),
  )

  // ------------ OUTLINE ------------ //
  // Parts and Chapters should have the same indentation level on outline
  set outline(indent: n => {
    if n == 0 or n == 1 {
      0em
    } else {
      (n - 1) * 1em
    }
  })
  
  // Style the outline entries
  show outline.entry: e => if e.element.func() == heading {
    if e.level == 1 {
      v(5mm, weak: true)
      strong(e)
    } else if e.level == 2 {
      v(5mm, weak: true)
      strong(e)
    } else if e.level == 4 {
      emph(e)
    } else {
      e
    }
  } else { e }

  // ------------ MATH ------------ //
  // Equation numbers are (chap_no.eq_no). 
  // The eq_no counter is reset every chapter in the corresponding show rule.
  set math.equation(numbering: prefix-chapter.with(enclosing: ("(", ")")))
  show math.equation: it => {
    // Math with a compliant font
    set text(font: font.math)
    it
  }

  // ------------ FOOTNOTES ------------ //
  show footnote.entry: it => {
    let loc = it.note.location()
    numbering(
      "1. ",
      ..counter(footnote).at(loc),
    )
    it.note.body
  }

  // ------------ REFERENCES ------------ //
  show ref: it => {
    let el = it.element

    if el == none { return it }

    // Remove the trailing point at the end of parts, chapters and sections when referencing them.
    // Example: Chapter 1 instead of Chapter 1.
    if el.func() == heading {
      let supplement = if it.supplement == auto {el.supplement} else {it.supplement}

      // Get the chapter number and the appendix number
      let number = if supplement == [Appendix] {
        heading-numbering(
          ..counter(el.func()).at(el.location()),
          style: "1.A.1",
          levels: (2, 4)
        )
      } else {
        heading-numbering(
          ..counter(el.func()).at(el.location()),
          style: "1.1",
          levels: 2
        )
      }
      
      return link(el.location(), [#supplement #number])
    }

    return it
  }

  // --------- BLOCKQUOTES ----------- //
  show quote.where(block: true): it => {
    v(-3em)
    align(right, block(width: 70%, align(left, it)))
    v(3em)
  }



  // ------------ BIBLIOGRAPHY ------------ //
  set bibliography(style: "association-for-computing-machinery")

  // ------------ BODY ------------ //
  body
}