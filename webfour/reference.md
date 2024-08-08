---
layout: page
title: APA 7th Reference Style Guide
---

# Introduction

This file contains information on how to format references that will be added to the 
different pages that are generated within this web site.  The use is 
<a href="https://apastyle.apa.org/style-grammar-guidelines/references" 
target="_blank">APA 7th Reference Style Guide</a>. The use of this style is to be 
able to keep things are consistent as possible with the way that references are 
being described within a given publication which includes books and journal papers.  
The objective is to provide a simple format that can then we used to generate the 
reference pages that are used by a particular page or set of pages.  Let us then 
look at the different formats that can be used within a given page. Note that this 
format will evolve as we add more types of references.  It is hoped that the current 
format will be extendable in such a way that the prior format will not be affected 
by the addition of new reference type formats.

# YAML Field Reference

The following table contains the current set of fields that will be used to generate
the reference list assocaited with a given set of pages.  This list currently 
contains information that will be part of the current reference page generation.  
This doesn't exclude the possibility of including updates to the list.  The hope is 
that these entries will be added without updating or removing the prior fields.

| Field Name | Description |
| :---: | :--- |
| title | This is the title and optional colon separated subtile of the reference |
| author | This will contain all of the authors, comma seperated |
| editor | This will contain all of the editors, comma seperated |
| translator | This will contain all of the translators, comma seperated |
| illustrator | This will contain all of the illustrators, comma seperated |
| years | Year or years of publication |
| org_years | Year of original reference publication |
| edition | The current edition of the book |
| volumn | A list of volumns for this set of books |
| publisher | The name of the book publisher |
| reference | Referencing url such as doi |
| type | States which type of reference this is, can be "book" and "paper" |

While the above list contains information about which fields should be used to add a
reference entry.  It doesn't offer any styling options for a reference generations.
The following will explain the default styling that will be used to generate the
above reference types.  The following list will contain the fields that will be
reference, the referencing class style and the default style used.  These css style
are defined depending on the type of reference that we are referencing.  Let us
then look at what each reference type css styles are generated with their defaults.

Let us then look at what fields can be used by the different type of reference

### Books

The books and ebook reference have the following fields associated with the reference.

| Field | Required |
| :--- | :---: |
| title | yes |
| year | yes |
| author | if avaliable* |
| editor | if avaliable* |
| translator | if avaliable* |
| reference | if avaliable |
| org_years | if avaliable |
| edition | if avaliable |
| org_year | if avaliable |
| publisher | yes |

## Books/eBooks

The following table contains the fields that are used to generate a book reference.
These fields are not all required and the generation of the reference will be able
to handle the different fields that have been defined for each reference.  The only
caveat is that you are expected to use the data required by the APA 7th Reference
Style Guide.  Not following the reference guide style can produce incorrect 
references.  Let us then look at each field and its default css style.

| Fields | Class | Default |
| :--- | :-- | :-- |
| authors, editors, translators, illustrators | ref-book-creators | normal |
| title | ref-book-title | italics |
| years | ref-book-year | normal |
| edition | ref-book-edition | normal |
| volumn | ref-book-volumn | normal |
| publisher | ref-book-publisher | normal |

## Articles

Articles include research journals and other types of article like references.

| Fields | Class | Default |
| :--- | :-- | :-- |
| authors | ref-paper-creators | normal |
| title | ref-paper-title | italics |

# Books/Ebook References

This section will look at how to manage references to books which include ebooks.
This section is a copy of the information from the following link [Book/Ebook References](https://apastyle.apa.org/style-grammar-guidelines/references/examples/book-references) on August 3rd, 2024.

## Whole authored book

Jackson, L. M. (2019). *The psychology of prejudice: From attitudes to social action* (2nd ed.). American Psychological Association. [https://doi.org/10.1037/0000168-000](https://doi.org/10.1037/0000168-000)

Sapolsky, R. M. (2017). *Behave: The biology of humans at our best and worst*. Penguin Books.

Svendsen, S., & Løber, L. (2020). *The big picture/Academic writing: The one-hour guide* (3rd digital ed.). Hans Reitzel Forlag. [https://thebigpicture-academicwriting.digi.hansreitzel.dk/](https://thebigpicture-academicwriting.digi.hansreitzel.dk/)

- **Parenthetical citations**: (Jackson, 2019; Sapolsky, 2017; Svendsen & Løber, 2020)
- **Narrative citations**: Jackson (2019), Sapolsky (2017), and Svendsen and Løber (2020)

With the above format note the following:

- Provide the author, year of publication, title, and publisher of the book. Use the same format for both print books and ebooks.
- Use the copyright date shown on the book’s copyright page as the year of publication in the reference, even if the copyright date is different than the release date.
- Include any edition information in parentheses after the title, without italics.
- If the book includes a DOI, include the DOI in the reference after the publisher name.
- Do not include the publisher location.
- If the ebook without a DOI has a stable URL that will resolve for readers, include the URL of the book in the reference (as in the Svendsen and Løber example, which is from the iBog database, where ebooks are referred to as “internetbooks”). Do not include [the name of the database](https://apastyle.apa.org/style-grammar-guidelines/references/database-information) in the reference.
- If the ebook is from an academic research database and has no DOI or stable URL, end the book reference after the publisher name. Do not include [the name of the database](https://apastyle.apa.org/style-grammar-guidelines/references/database-information) in the reference. The reference in this case is the same as for a print book.

## Whole edited book

Hygum, E., & Pedersen, P. M. (Eds.). (2010). *Early childhood education: Values and practices in Denmark*. Hans Reitzels Forlag. [https://earlychildhoodeducation.digi.hansreitzel.dk/](https://earlychildhoodeducation.digi.hansreitzel.dk/)

Kesharwani, P. (Ed.). (2020). *Nanotechnology based approaches for tuberculosis treatment*. Academic Press.

Torino, G. C., Rivera, D. P., Capodilupo, C. M., Nadal, K. L., & Sue, D. W. (Eds.). (2019). *Microaggression theory: Influence and implications*. John Wiley & Sons. [https://doi.org/10.1002/9781119466642](https://doi.org/10.1002/9781119466642)

- **Parenthetical citations**: (Hygum & Pedersen, 2010; Kesharwani, 2020; Torino et al., 2019)
- **Narrative citations**: Hygum and Pedersen (2010), Kesharwani (2020), and Torino et al. (2019)

With the above format note the following:

- Use the abbreviation “(Ed.)” for one editor and the abbreviation “(Eds.)” for multiple editors after the editor names, followed by a period. In the case of multiple editors, include the role once, after all the names.
- Include any edition information in parentheses after the title, without italics.
- If the book includes a DOI, include the DOI in the reference after the publisher name.
- Do not include the publisher location.
- If the ebook without a DOI has a stable URL that will resolve for readers, include the URL of the book in the reference (as in the Hygum and Pedersen example, which is from the iBog database). Do not include [the name of the database](https://apastyle.apa.org/style-grammar-guidelines/references/database-information) in the reference.
- If the ebook is from an academic research database and has no DOI or stable URL, end the book reference after the publisher name. Do not include [the name of the database](https://apastyle.apa.org/style-grammar-guidelines/references/database-information) in the reference. The reference in this case is the same as for a print book.

## Republished book, with editor

Watson, J. B., & Rayner, R. (2013). *Conditioned emotional reactions: The case of Little Albert* (D. Webb, Ed.). CreateSpace Independent Publishing Platform. [http://a.co/06Se6Na](http://a.co/06Se6Na) (Original work published 1920)

- **Parenthetical citation**: (Watson & Rayner, 1920/2013)
- **Narrative citation**: Watson and Rayner (1920/2013)

With the above format note the following:

- The book by Watson and Rayner was originally published in 1920. It was edited by Webb and republished in 2013.
- Sometimes an authored book also credits an editor on the cover. In this case, include the editor in parentheses without italics after the book title.
- Provide the year of the republication in the main date element of the reference. Provide the year of original publication at the end of the reference in parentheses after the words “Original work published.”
- Both publication years appear in the in-text citation, separated with a slash, with the earlier year first.

## Book published with new foreword by another author

Kübler-Ross, E. (with Byock, I.). (2014). *On death & dying: What the dying have to teach doctors, nurses, clergy & their own families* (50th anniversary ed.). Scribner. (Original work published 1969)

- **Parenthetical citation**: (Kübler-Ross, 1969/2014)
- **Narrative citation**: Kübler-Ross (1969/2014)

With the above format note the following:

- Use this format when a person other than the original author has added a new part to the work, such as a foreword or introduction.
- Provide the author of the whole book in the main author element of the reference. Then provide the name of the person who wrote the foreword, introduction, or other new part, in parentheses, after the word “with.” In the example, Byock wrote a new foreword to the book by Kübler-Ross.
- When citing the main book, include only the name of the book author in the in-text citation.
- When citing the foreword or introduction, include the name of the author of that part in the in-text citation:
    - **Parenthetical citation of foreword**: Workers in the medical community should “listen to the people who need our help and respond with all the knowledge and skill we can bring to bear” (Kübler-Ross, 1969/2014, foreword by Byock, p. xv).
    - **Narrative citation of foreword**: Byock stated that Kübler-Ross’s (1969/2014) work “challenged the authoritarian decorum and puritanism of the day” (p. xii).

## Several volumes of a multivolume work

Harris, K. R., Graham, S., & Urdan T. (Eds.). (2012). *APA educational psychology handbook* (Vols. 1–3). American Psychological Association.

- **Parenthetical citation**: (Harris et al., 2012)
- **Narrative citation**: Harris et al. (2012)

With the above format note the following:

- Provide the name(s) of the editor(s)-in-chief as the editors of the work, even if the volume editors are different.

Learn more

Book/ebook references are covered in the seventh edition APA Style manuals in the Publication Manual Section 10.2 and the Concise Guide Section 10.2

## Translated Book

This section was retreived from [https://uow.libguides.com/uow-apa7/book-translated](https://uow.libguides.com/uow-apa7/book-translated).

Author, A. A. (year). Title of the book (Translator first initial, last name, Trans.). Publisher. (Original work published Year). DOI or Web address – if available.
For example:

Camus, A. (2012). *The Outsider* (S. Smith, Trans.). Penguin Books Ltd. (Original work published 1942).

Kafka, F. (2010). *The Trial* (I. Parry, Trans.) Penguin Books Ltd. (Original work published 1924).

# Journal Article References

The following contains information on how to generate different journal type 
references.

## Journal article

Grady, J. S., Her, M., Moreno, G., Perez, C., & Yelinek, J. (2019). Emotions in storybooks: A comparison of storybooks that represent ethnic and racial groups in the United States. *Psychology of Popular Media Culture*, 8(3), 207–217. [https://doi.org/10.1037/ppm0000185](https://doi.org/10.1037/ppm0000185)

- **Parenthetical citation**: (Grady et al., 2019)
- **Narrative citation**: Grady et al. (2019)

With the above format note the following:

- If a journal article has a DOI, include the DOI in the reference.
- Always include the issue number for a journal article.
- If the journal article does not have a DOI and is from an academic research database, end the reference after the page range (for an explanation of why, see the [database information page](https://apastyle.apa.org/style-grammar-guidelines/references/database-information)). The reference in this case is the same as for a print journal article.
- Do not include database information in the reference unless the journal article comes from a database that publishes works of limited circulation or original, proprietary content, such as [UpToDate](https://apastyle.apa.org/style-grammar-guidelines/references/examples/uptodate-article-references).
- If the journal article does not have a DOI but does have a URL that will resolve for readers (e.g., it is from an online journal that is not part of a database), include the URL of the article at the end of the reference.

## Journal article with an article number

Jerrentrup, A., Mueller, T., Glowalla, U., Herder, M., Henrichs, N., Neubauer, A., & Schaefer, J. R. (2018). Teaching medicine with the help of “Dr. House.” *PLoS ONE*, 13(3), Article e0193972. https://doi.org/10.1371/journal.pone.0193972

- **Parenthetical citation**: (Jerrentrup et al., 2018)
- **Narrative citation**: Jerrentrup et al. (2018)

With the above format note the following:

- If the journal article has an article number instead of a page range, include the word “Article” and then the article number instead of the page range.

## Journal article with missing information

<em>Missing volume number</em>

Lipscomb, A. Y. (2021, Winter). Addressing trauma in the college essay writing process. *The Journal of College Admission*, (249), 30–33. <a href="https://www.catholiccollegesonline.org/pdf/national_ccaa_in_the_news_-_nacac_journal_of_college_admission_winter_2021.pdf">https://www.catholiccollegesonline.org/pdf/national_ccaa_in_the_news_-_nacac_journal_of_college_admission_winter_2021.pdf</a>

<em>Missing issue number</em>

Sanchiz, M., Chevalier, A., & Amadieu, F. (2017). How do older and young adults start searching for information? Impact of age, domain knowledge and problem complexity on the different steps of information searching. *Computers in Human Behavior*, 72, 67–78. [https://doi.org/10.1016/j.chb.2017.02.038](https://doi.org/10.1016/j.chb.2017.02.038)

<em>Missing page or article number</em>

Butler, J. (2017). Where access meets multimodality: The case of ASL music videos. *Kairos: A Journal of Rhetoric, Technology, and Pedagogy*, 21(1). [http://technorhetoric.net/21.1/topoi/butler/index.html](http://technorhetoric.net/21.1/topoi/butler/index.html)


- **Parenthetical citations**: (Butler, 2017; Lipscomb, 2021; Sanchiz et al., 2017)
- **Narrative citations**: Butler (2017), Lipscomb (2021), and Sanchiz et al. (2017)

With the above format note the following:

- If the journal does not use volume, issue, and/or article or page numbers, omit the missing element(s) from the reference.
- If the journal is published quarterly and the month or season (Fall, Winter, Spring, Summer) is noted, include that with the date element; see the Lipscomb example.
- If the volume, issue, and/or article or page numbers have simply not yet been assigned, use the format for an advance online publication (see Example 7 in the *Publication Manual*) or an in-press article (see Example 8 in the *Publication Manual*).

## Retracted journal article

Joly, J. F., Stapel, D. A., & Lindenberg, S. M. (2008). Silence and table manners: When environments activate norms. *Personality and Social Psychology Bulletin*, 34(8), 1047–1056. [https://doi.org/10.1177/0146167208318401](https://doi.org/10.1177/0146167208318401) (Retraction published 2012, *Personality and Social Psychology Bulletin*, 38[10], 1378)

- **Parenthetical citation**: (Joly et al., 2008)
- **Narrative citation**: Joly et al. (2008)

With the above format note the following:

- Use this format to cite the retracted article itself, for example, to discuss the contents of the retracted article.
- First provide publication details of the original article. Then provide information about the retraction in parentheses, including its year, journal, volume, issue, and page number(s).

## Retraction notice for a journal article

de la Fuente, R., Bernad, A., Garcia-Castro, J., Martin, M. C., & Cigudosa, J. C. (2010). Retraction: Spontaneous human adult stem cell transformation. *Cancer Research*, 70(16), 6682. [https://doi.org/10.1158/0008-5472.CAN-10-2451](https://doi.org/10.1158/0008-5472.CAN-10-2451)

The Editors of the Lancet. (2010). Retraction—Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children. *The Lancet*, 375(9713), 445. [https://doi.org/10.1016/S0140-6736(10)60175-4](https://doi.org/10.1016/S0140-6736(10)60175-4)


- **Parenthetical citations**: (de la Fuente et al., 2010; The Editors of the Lancet, 2010)
- **Narrative citations**: de la Fuente et al. (2010) and The Editors of the Lancet (2010)

With the above format note the following:

- Use this format to cite a retraction notice rather than a retracted article, for example, to provide information on why an article was retracted.
- The author of the retraction notice may be an editor, editorial board, or some or all authors of the article. Examine the retraction notice to determine who to credit as the author.
- Reproduce the title of the retraction notice as shown on the work. Note that the title may include the words “retraction,” “retraction notice,” or “retraction note” as well as the title of the original article.

## Abstract of a journal article from an abstract indexing database

Hare, L. R., & O'Neill, K. (2000). Effectiveness and efficiency in small academic peer groups: A case study (Accession No. 200010185) [Abstract from Sociological Abstracts]. *Small Group Research*, 31(1), 24–53. [https://doi.org/10.1177/104649640003100102](https://doi.org/10.1177/104649640003100102)

- **Parenthetical citation**: (Hare & O’Neill, 2000)
- **Narrative citation**: Hare and O’Neill (2000)

With the above format note the following:

- Although it is preferable to cite the whole article, the abstract can be cited if that is your only available source.
- The foundation of the reference is the same as for a journal article.
- If the abstract has a database accession number, place it in parentheses after the title.
- Note that you retrieved only the abstract by putting the words “Abstract from” and then the name of the abstract indexing database in square brackets. Place this bracketed description after the title and any accession number.
- Accession numbers are sometimes referred to as unique identifiers or as publication numbers (e.g., as PubMed IDs); use the term provided by the database in your reference.

## Monograph as part of a journal issue

Ganster, D. C., Schaubroeck, J., Sime, W. E., & Mayes, B. T. (1991). The nomological validity of the Type A personality among employed adults [Monograph]. *Journal of Applied Psychology*, 76(1), 143–168. [http://doi.org/10.1037/0021-9010.76.1.143](http://doi.org/10.1037/0021-9010.76.1.143)

- **Parenthetical citation**: (Ganster et al., 1991)
- **Narrative citation**: Ganster et al. (1991)

With the above format note the following:

- For a monograph with an issue (or whole) number, include the issue number in parentheses followed by the serial number, for example, 58(1, Serial No. 231).
- For a monograph bound separately as a supplement to a journal, give the issue number and supplement or part number in parentheses after the volume number, for example, 80(3, Pt. 2).

## Online-only supplemental material to a journal article

Freeberg, T. M. (2019). From simple rules of individual proximity, complex and coordinated collective movement [Supplemental material]. *Journal of Comparative Psychology*, 133(2), 141–142. [https://doi.org/10.1037/com0000181](https://doi.org/10.1037/com0000181)

- **Parenthetical citation**: (Freeberg, 2019)
- **Narrative citation**: Freeberg (2019)

With the above format note the following:

- The foundation of the reference is the same as for a journal article.
- Include the description “[Supplemental material]” in square brackets after the article title.
- If you cite both the main article and the supplemental material, provide only a reference for the article.
