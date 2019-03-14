#' Obtain the viewport number of the chart
#'
#' @param chartgrp Chart group
#' @param chartcode The chart code, returned by \code{chartbox::create_chartcode()}
#' @param yname Names of the response variable
#' @return An integer with the viewport number
#' @export
get_viewport <- function(chartgrp, chartcode, yname) {
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
  tab[idx, "vp"]
}
