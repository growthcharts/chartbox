#' List available growth charts
#'
#' @param chartgp The chart group
#' @return A data frame
#' @examples
#' # list all available charts
#' list_charts()
#' @export
list_charts <- function(chartgp = NULL) {

  lib <- file.path(find.package("chartbox"), "library")
  fn <- list.files(lib, recursive = TRUE)

  # process into data frame
  f1 <- unlist(strsplit(unlist(strsplit(fn, split = "\\.")), "/"))
  gp <- f1[seq(1, length(f1), 3)]
  cd <- f1[seq(2, length(f1), 3)]
  att <- t(sapply(cd, parse_chartcode))
  att2 <- matrix(as.character(att), ncol = 6)
  att3 <- data.frame(att2, stringsAsFactors = FALSE)
  colnames(att3) <- dimnames(att)[[2]]
  df <- data.frame(
    chartgp = gp,
    chartcode = cd,
    att3,
    stringsAsFactors = FALSE)

  # subset if needed
  #
  if (!is.null(chartgp)) df <- df[df$chartgp == chartgp, ]
  df
}
