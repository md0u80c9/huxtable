#!/usr/local/bin/Rscript

# script to rebuild website files


for (f in list.files("docs", pattern = "*.Rmd", full.names = TRUE)) {
  message("Rendering ", f)
  rmarkdown::render(f, output_format = "html_document")
  rmarkdown::render(f, output_format = "pdf_document")
}

setwd('docs')
knitr::knit("index.Rhtml", "index.html")
setwd('..')

pkgdown::build_reference_index()
pkgdown::build_reference()
pkgdown::build_news()
message("Now commit and push to github. Don't forget to reinstall the dev version!")
