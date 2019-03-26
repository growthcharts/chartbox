#' Obtain the viewport name of the chart
#'
#' @param chartcode The chart code, returned by \code{chartbox::create_chartcode()}
#' @param yname Names of the response variable
#' @param chartgrp The chart group. If not specified, it is calculated
#' automatically.
#' @return Name of the viewport
#' @export
get_viewport <- function(chartcode,
                         yname,
                         chartgrp = get_chartgrp(chartcode)) {
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
