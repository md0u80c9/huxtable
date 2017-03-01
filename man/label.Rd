% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/attributes.R
\name{label}
\alias{label}
\alias{label<-}
\alias{set_label}
\title{Get or Set Table Label}
\usage{
label(ht)
label(ht) <- value
set_label(ht, value)
}
\arguments{
\item{ht}{A huxtable.}

\item{value}{A length-one character vector to be used as a table label in LaTeX. Set to \code{NA}}
}
\value{
For \code{label}, the \code{label} attribute. For \code{label<-}, the
value of the right hand side (technically, the function itself returns the \code{ht} object, but this is an
implementation detail of how R handles replacement functions). For \code{set_label}, the \code{ht} object.
}