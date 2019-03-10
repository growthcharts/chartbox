#' Load growth chart
#'
#' @param chartcode A string containing the chart code. If a vector
#' only the first element is processed.
#' @param chartgp A string with the chart group name. Use
#' \code{list_groups()} to see available groups.
#' @return A grid object
#' @examples
#' z <- load_chart("NJAA")
#' @export
load_chart <- function(chartcode, chartgp = "nl2010") {

  lib <- file.path(path.package("chartbox"), "library")
  found <- intersect(chartgp, dir(lib))
  if (length(found) == 0L) {
    warning("Chart group ", chartgp, " not found.")
    return(NULL)
  }

  fn <- file.path(lib, chartgp, paste(chartcode[1L], "rds", sep = "."))
  if (!file.exists(fn)) {
    warning("File ", fn, " not found.")
    return(NULL)
  }

  readRDS(file = fn)
}
