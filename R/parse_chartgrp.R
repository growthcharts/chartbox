
#' Parses the chart group
#'
#' @aliases parse_chartgrp
#' @param chartcode the chart code, usually constructed by \code{get_chartcode()}
#' @return The function returns a string with the chart group
#' @export
parse_chartgrp <- function(chartcode = NULL) {

  if (is.null(chartcode)) return(NULL)
  chartcode <- chartcode[1]

  switch(EXPR = substr(chartcode, 1, 1),
         'N' = 'nl2010',
         'M' = 'nl2010',
         'T' = 'nl2010',
         'P' = 'preterm',
         'E' = 'nl2010',
         'H' = 'nl2010',
         'W' = 'who',
         NULL)
}
