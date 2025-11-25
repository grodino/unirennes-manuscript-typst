#import "@local/unirennes-manuscript:0.3.0": styles, cover, insciption, part

#let info = (
  // Author information
  author: "« Prénom NOM »", // Must be a string (and not content), as it is used as PDF metadata
  affiliation: [« voir README et le site de de votre école doctorale »],
  // Jury information
  jury: (
    president: ("Prénom NOM", "Fonction et établissement d’exercice"),
    examinateurs: (
      ("Prénom NOM", "Fonction et établissement d’exercice"),
      ("Prénom NOM", "Fonction et établissement d’exercice"),
      ("Prénom NOM", "Fonction et établissement d’exercice"),
    ),
    rapporteurs: (
      ("Prénom NOM", "Fonction et établissement d’exercice"),
      ("Prénom NOM", "Fonction et établissement d’exercice"),
      ("Prénom NOM", "Fonction et établissement d’exercice"),
    ),
    invites: (
      ("Prénom NOM", "Fonction et établissement d’exercice"),
    ),
  ),
  // Supervisors information
  supervision: (
    directeurs: (
      ("Prénom NOM", "Fonction et établissement d’exercice"),
      ("Prénom NOM", "Fonction et établissement d’exercice"),
    ), // Directeur.ice.s de thèse
    encadrants: (
      ("Prénom NOM", "Fonction et établissement d’exercice"),
      ("Prénom NOM", "Fonction et établissement d’exercice"),
    ), // Co-encadrant.e.s de thèse (dans le cas d'une CIFRE par exemple), peut être vide
  ),
  // Thesis defense information
  defense-place: [« Lieu »],
  defense-date: [« date »],
  thesis-number: [« If required »], // Otherwise, remove this line
  // french info
  title-fr: [« Titre de la thèse »],
  keywords-fr: [de 3 à 6 mots clefs],
  abstract-fr: lorem(150),
  // english info
  title-en: [« Title of the manuscript »],
  keywords-en: [3 to 6 keywords],
  abstract-en: lorem(150),
)
#show: styles.matisse-thesis.with(author: info.author, title: info.title-en)

// Print the matisse cover
#cover.front(..info)

// Print the aknowledgements, list of figures, ...
// Put everything in a different scop from the main 
// text such that the styles apply only to the acknowledgements
#[
  #show: styles.preamble
  #insciption([To twotwo you Too])
  
  #outline(title: none, target: figure.where(kind: image))
  #outline(title: none)
  
  = Acknowledgements 
  Thanks a lot

  
  TODO: style acknowledgements
]

#part[Doctoral College]

= Doctoral College  instructions <chap:doctoral_college_instructions>
The Doctoral College instructions can be found here: #link("https://www.doctorat-bretagne.fr/sites/www.doctorat-bretagne.fr/files/medias/files/CoverThesisInstructions.pdf").

@chap:doctoral_college_instructions @chap:doctoral_college_instructions[rset]


== How to setup the front matter
Instructions on the modifiable parameters of the coverage model provided by the Doctoral College.

+ In the case of international thesis co-supervision (« cotutelle internationale de thèse »): indicate the names of the two institutions issuing the degree. Also add the logo of the foreign establishment
+ Indicate scientific specialty
+ The first name must be in lower case (Jean) and the SURNAME in upper case (BRITTEF)
+ Give the full title of the thesis, possibly the subtitle, if necessary on several lines
+ Indicate the date and place of defence of the thesis
+ Indicate the name of the laboratory(ies) in which the thesis work was carried out, also indicate, if desired, the name of the host establishment / organisation if it is different from the institution issuing the doctorate.
+ Indicate the thesis number (provided by the institution issuing the degree), if appropriate, or remove this item from the cover
+ Indicate the First name in lowercase and the Last name in uppercase, the title of the person and the establishment in which he is carrying out his research

== Cover page required information
- The *name of the establishment* issuing the doctorate and the name of the doctoral school. In the case of an international thesis co-supervision, mention the name of each of the establishments.
- The *research unit*
- The type of doctorate
- The *disciplinary field* in which the thesis is defended
- The *title of the thesis* or the title of the main works (the choice of the words of the title is particularly important, all these words being systematically indexed in the catalogues).
- The first names (in lowercase) and surnames (in capitals) of the *author*. The administrative rule is that the patronymic name is used first, possibly followed by the usual name, whether it results from marriage or filiation. Both names are indexed and searchable in catalogs and thesis reporting databases. The words “wife”, “husband”, “says” or “born” must not be used. So that there is no possible confusion between the surnames and first names of the author, all names must appear in capital letters.
- The first and last names of the *research director*. If there are two directors, mention the main director first. For theses that are defended within the framework of an international co-supervision, use a slash "/" to separate the two thesis supervisors.
- The eventual volume number.
- The final defence date.
- The composition of the jury. The surnames and first names of the members of the jury according to the same rules as those described above, with indication of the function of the person and the role within the jury. N.B.: The title page is the first page of the document. It is counted in the pagination but is never numbered

== Back cover required information
- *The summary in French:* Composed of a maximum of 1700 characters, spaces included, it is precise and allows you to understand how the subject is approached. All words in the abstract are indexed and can be searched.
- *Keywords in French:* they are chosen by the doctoral researcher in agreement with his thesis director, according to the terminology in force in his discipline. The institution's library will use the words chosen to define Rameau indexing, the language used in union catalogues.
- *The title of the thesis in French:* the choice of title words is particularly important, all these words being systematically indexed in the catalogues).
- *The title in English:* This is used for reporting the thesis in international databases. All words are indexed and can be used for research.
- *Abstract:* Composed of a maximum of 1700 characters, spaces included, it is the faithful transposition into English of the French summary, without being a pure literal translation. In the case of a thesis under international joint supervision, if the language of the thesis is not French, a substantial summary in French is required in addition to the summaries provided for above. This digest, of about ten pages, is then placed before the table of contents.
- *Keywords in English:* They are used for reporting the thesis in international databases and for OAI harvesting.
- *The title and address of the unit or laboratory to which it is attached:* If they do not appear on the title page, respecting the forms prescribed by the defence institution

= Using this theme <chap:using_theme>
#set heading(offset: 2)
Look at the docs #emoji.face.smile

$a +b = c$

= section

== Subsection

=== Paragraph
sdkjf sdfiijhsdhf 

// #counter(figure.where(kind: image)).update((0,0))
// Ha #context counter(figure.where(kind: image)).get()
#figure(
  image("../common/assets/logos/unirennes-logo.svg"),
  caption: [Logo de l'Université de Rennes]
)
// Hello #context counter(figure.where(kind: image)).get()
= A other section

#figure(
  image("../src/assets/matisse.png"),
  caption: [Logo de l'école doctorale]
)

#[
  #show: styles.appendix
  See the proofs in @apx:proof and more results in @apx:more_results
  
  = Appendix
  this is the appendix
  == Proofs <apx:proof>
  == Additional results <apx:more_results>
]

#set heading(offset: 1)
= An other chapter
#figure(
  image("../common/assets/logos/unirennes-logo.svg"),
  caption: [Logo de l'université de rennes, encore...]
)

// Print the matisse back cover
#cover.back(..info)
