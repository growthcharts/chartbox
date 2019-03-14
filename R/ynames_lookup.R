#' Details of installed charts
#'
#' A data set containing the kind of outcomes present on each chart
#' in \code{inst/library}
#'
#' @format A data frame with 5 variables:
#' \describe{
#' \item{chartgrp}{Chart group}
#' \item{chartcode}{Chart code as defined by \code{chartbox::get_chartcode()}. This
#' chart code can be decomposed by \code{chartbox::parse_chartcode()}}
#' \item{yname}{Name of the outcome present on the chart, e.g. one of \code{hdc},
#' \code{hgt}, \code{wgt}, \code{wfh}, \code{bmi}}
#' \item{vp}{The viewport number for editing the outcome. Use this to
#' specify the \code{vp} argument as
#' \code{vp = g$childrenvp[[{viewport number}]]}.
#' }
#' \item{reference}{A string indicating the reference in \code{clopus}.
#' The \code{get_reference()} function actually pulls out the relevant
#' references from \code{clopus}}
#' }
"ynames_lookup"
