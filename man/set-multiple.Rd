% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-set-convenience.R
\name{set-multiple}
\alias{set-multiple}
\alias{set_all_borders}
\alias{set_all_border_colors}
\alias{set_all_border_styles}
\alias{set_all_padding}
\alias{set_outer_borders}
\title{Set left, right, top and bottom properties}
\usage{
set_all_borders(ht, row, col, value, byrow = FALSE)

set_all_border_colors(ht, row, col, value, byrow = FALSE)

set_all_border_styles(ht, row, col, value, byrow = FALSE)

set_all_padding(ht, row, col, value, byrow = FALSE)

set_outer_borders(ht, row, col, value)
}
\arguments{
\item{ht}{A huxtable.}

\item{row}{A row specifier. See \code{\link{rowspecs}} for details.}

\item{col}{An optional column specifier.}

\item{value}{Value(s) to set. Set to \code{NA} to reset to the default.}

\item{byrow}{If \code{TRUE}, fill in values by row rather than by column.}
}
\value{
The modified huxtable.
}
\description{
These are convenience functions which set left, right, top and bottom properties
simultaneously for the specified cells.
}
\details{
\code{set_outer_borders} sets borders round the top, bottom, left and right of a group
of cells. Behaviour is undefined unless \code{row} and \code{col} specify contiguous sequences.
}
\examples{
ht <- huxtable(a = 1:3, b = 1:3)
set_all_borders(ht, 1:3, 1:2, 1)
ht <- set_all_border_colors(ht, 'red')
ht <- set_all_border_styles(ht, 'double')
ht <- set_all_padding(ht, 1:3, 1:2, "20px")
ht2 <- huxtable(a = 1:3, b = 1:3)
set_outer_borders(ht2, 1)
set_outer_borders(ht2, 2:3, 1:2, 1)

# Problems with colspan:
rowspan(ht2)[2, 1] <- 2
set_outer_borders(ht2, 1:2, 1:2, 1)

}
