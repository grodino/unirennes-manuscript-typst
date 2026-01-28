// The colors for the MATISSE doctoral school.
// TODO: the colors for the other doctoral schools
#let school-color-recto = blue
#let school-color-verso = rgb("0054a0")

#let font = (
  title: "UniRennes",
  heading: "UniRennes",
  // The University of Rennes guide also include a serif font (NewsReader) 
  // but it is too heavy and not easily readable for such a technical text.
  text: "libertinus serif",
  math: "New Computer Modern Math",
  decorated: "UniRennes Inline",
  cover: "Helvetica",
)
#let font-size = (
  text: 10pt,
  heading: (
    display: (title: 28pt, supplement: 48pt),
    text: (12pt, 10pt)
  ),
)


// workaround for: https://github.com/typst/typst/issues/466
#let balanced-cols(n-cols, gutter: 11pt, body) = layout(bounds => context {
  // Measure the height of the container of the text if it was single
  // column, full width
  let text-height = measure(
    box(
      width: (bounds.width - (n-cols - 1) * gutter) / n-cols,
      body,
    ),
  ).height

  // Recompute the height of the new container. Add a few points to avoid the
  // second column being longer than the first one
  let balanced-height = text-height / n-cols + text.size / 2

  box(
    height: balanced-height,
    columns(n-cols, gutter: gutter, body),
  )
})

// Convenience numbering function to allow to display only numbers
// for section, subsections,... or also include parts.
// If levels is an int it is interpreted as a slice levels...max_level
// Else levels must be an array of the levels that will be passed to the numbering function
#let heading-numbering(..nums, levels: 1, style: "1.") = {
  let nums = nums.pos()
  
  let numbers = if type(levels) == int {
    nums.slice(calc.min(levels, nums.len()) - 1)
  } else {
    let numbers = ()
    for idx in levels {
      if nums.len() > idx - 1 {
        numbers.push(nums.at(idx - 1))
      }
    }
    numbers
  }
  
  numbering(style, ..numbers)
}

/// Make sure that the chapter number is that of the outlined chapter and not that of the chapter the outline is in.
#let prefix-chapter(num, location: "here", enclosing: none) = {
    let heading-counters = counter(heading).get()
    
    let numbers = if heading-counters.len() >= 2 {
      numbering("1.1", heading-counters.at(1), num)
    } else {
      numbering("1.1", num)
    }

    if enclosing == none {
      return numbers
    } else {
      return enclosing.at(0) + numbers + enclosing.at(1)
    }
  }

// Fake small caps
// taken from https://github.com/csimide/cuti/blob/6e02dc8e9e8d0017a8df6060ec1d2a23a03a6f1b/lib.typ#L50
#let fakesc(s, scaling: 0.75) = {
  show regex("\p{Ll}+"): it => {
    context text(scaling * 1em, tracking: 1pt, upper(it))
  }
  text(s)
}

// Recusively merge two dictionnaries
// Taken from https://github.com/touying-typ/touying/blob/190f6fe138e817b963edc20265fd5d363d25c009/src/utils.typ#L10
#let add-dicts(dict-a, dict-b) = {
  let res = dict-a
  for key in dict-b.keys() {
    if (
      key in res
        and type(res.at(key)) == dictionary
        and type(dict-b.at(key)) == dictionary
    ) {
      res.insert(key, add-dicts(res.at(key), dict-b.at(key)))
    } else {
      res.insert(key, dict-b.at(key))
    }
  }
  return res
}
