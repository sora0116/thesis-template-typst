#let 論文種別_str = (B: "卒業研究", M: "修士", D: "博士")

// 論文種別 = "B" | "M" | "D"
#let thesis-template(
  年度: "令和6年度",
  論文種別: "B",
  題目: [卒業研究/修士/博士論文テンプレート\ in Typst],
  指導教員: ([A 准教授], [B 教授], [C 助教]),
  入学年度: "令和3年度",
  学籍番号: 33114019,
  名前: "大橋　蒔思",
  日付: "令和7年2月7日",
  あらまし: [],
  キーワード: [],
  body) = {
    set text(
      font: ("New Computer Modern", "Harano Aji Mincho"),
      size: 12pt,
      lang: "ja"
    )
    set par(first-line-indent: (amount: 1em, all: true), justify: true, spacing: 1.48em)
    set outline(title: text(font: "Harano Aji Gothic", weight: "medium", size: 17pt)[目 次])
    set outline.entry(fill: pad(x: 0.5em, repeat([.], gap: 0.5em)))
    show outline.entry.where(level: 1): set block(above: 79.21mm - 71.74mm)
    show outline.entry.where(level: 1): set text(
      top-edge: "ascender",
      font: "Harano Aji Gothic",
      weight: "medium",
    )
    show outline.entry.where(level: 2): set block(above: 4.2mm)
    show outline.entry.where(level: 3): set block(above: 4.2mm)
    set heading(numbering: "1.1")
    show heading: set text(font: "Harano Aji Gothic", weight: "medium")
    set page(margin: (top: 33.4mm, left: 23.11mm, bottom: 59.44mm, right: 210mm - 188.06mm))
  [
    #set page(margin: (top: 51.49mm, bottom: 60.06mm, rest: 0mm), numbering: none)
    #set text(
      size: 17pt,
      cjk-latin-spacing: none,
      top-edge: "ascender",
      bottom-edge: "descender"
    )
    #set par(spacing: 0mm, leading: 0em)
    #set align(center)

    #年度　#論文種別_str.at(論文種別)論文
    #v(70.27mm - 57.81mm)
    #題目
    #v(91.88mm - 82.73mm)

    #align(left)[
      #pad(left: 112.46mm)[
        #set par(first-line-indent: 0em)
        #set text(size: 14pt)
        #set align(left)
        指導教員\
        #for 教員 in 指導教員 {
          [#h(2em)#教員\ #v(0.5mm)]
        }
      ]
    ]

    #v(1fr)
    #if 論文種別 == "B" [
      名古屋工業大学　工学部情報学科\
    ] else [
      名古屋工業大学大学院　工学部情報学科\
    ]
    #入学年度;入学　#学籍番号;番
    #v(203.78mm - 194.28mm)
    #text(size: 20pt, 名前)
    #v(230.61mm - 210.8mm)
    #日付

    #counter(page).update(n => n - 1)
  ] + [
    #text(font: "Harano Aji Gothic")[あらまし]　#あらまし

    #text(font: "Harano Aji Gothic")[キーワード]　#キーワード
  ] + [
    #pagebreak()
    #set page(header: context if counter(page).get().at(0) == 2 { none } else [目 次#h(1fr)#context counter(page).display("i")])
    #outline()
  ] + [
    #set page(
      header: context {
        let current-page = here().page()

        let chapters = query(heading.where(level: 1))
          .filter(h => h.location().page() <= current-page)

        if chapters.len() > 0 {
          let chapter = chapters.last()
          let number = counter(heading).at(chapter.location()).first()

          [#number. #chapter.body]
        }
      },
    )
    #set heading(hanging-indent: 3em)
    #show heading: it => context {
      set block(below: 5.07mm + 0.71mm)
      block(
        if it.numbering != none {
          counter(heading).display(it.numbering)
          h(1em)
        } + it.body
      )
    }
    #show heading.where(level: 1): it => pagebreak() + it
    #set par(leading: 1em + 0.71mm)
    #body
  ]
}
