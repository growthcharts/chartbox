#' Load growth chart
#'
#' @param chartcode A string containing the chart code. If a vector
#' only the first element is processed.
#' @return A grid object
#' @examples
#' z <- load_chart("NJAA")
#' @export
load_chart <- function(chartcode) {

  chartgrp <- switch(EXPR = substr(chartcode[1L], 1L, 1L),
                     "N" = "nl2010",
                     "M" = "nl2010",
                     "T" = "nl2010",
                     "P" = "preterm",
                     "E" = "nl2010",
                     "H" = "nl2010",
                     "W" = "who")

  lib <- file.path(find.package("chartbox"), "library")
  found <- intersect(chartgrp, dir(lib))
  if (length(found) == 0L) {
    warning("Chart group ", chartgrp, " not found.")
    return(NULL)
  }

  fn <- file.path(lib, chartgrp, paste(chartcode[1L], "rds", sep = "."))
  if (!file.exists(fn)) {
    warning("File ", fn, " not found.")
    return(NULL)
  }

  readRDS(file = fn)
}
