// Preamble
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(stroke: 1pt + gray)

#let title = ""
#let author = "Emil Motrøen"
#let abstract = ""

#set text(font: "New Computer Modern", lang: "en", region: "nb", size: 12pt)
#show math.equation: set text(weight: 400)
#set par(justify: true)


#align(left)[
  #text(35pt, title) \
  #text(20pt, author)
]

#if abstract != "" {
  v(50%)
  align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(smallcaps[Abstract], size: 16pt)
    )
    #abstract
  ]
}

#pagebreak()

#set heading(numbering: "1.1.1")
#set text(size: 12pt)
#outline(depth: 5, indent: 10pt + 5%)

#pagebreak()
#set page(
  paper: "a4",
  numbering: "1 of 1",
  number-align: right,
  header: align(right + horizon, title),
  columns: 1
)

#counter(page).update(1) 

// Contents

