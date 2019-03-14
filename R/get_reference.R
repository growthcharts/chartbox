#' Obtain the growth reference behind the chart
#'
#' @param chartgrp Chart group
#' @param chartcode The chart code, returned by \code{chartbox::create_chartcode()}
#' @param yname Names of the response variable
#' @return An object of class \code{reference}
#' @seealso \code{\link[clopus]{reference-class}}
#' @examples
#' \dontrun{
#' get_reference("nl2010", "NJAA", "hgt")
#' }
#' @export
get_reference <- function(chartgrp, chartcode, yname) {
  tab <- chartbox::ynames_lookup
  idx <- tab$chartgrp %in% chartgrp[1L] &
    tab$chartcode %in% chartcode[1L] &
    tab$yname %in% yname[1L]
  if (sum(idx) > 1L) {
    warning("Search combination not unique")
    return(NULL)
  }
  if (sum(idx) < 1L) {
    warning("Search combination not found")
    return(NULL)
  }
  eval(parse(text = tab[idx, "reference"]))
}
