#' List available growth charts
#'
#' @param chartgrp Optional. String chart group name, e.g. \code{chartgrp = "who"}.
#' If omitted, \code{list_charts()} return all charts groups.
#' @return A \code{data.frame} with eight columns:
#' \describe{
#' \item{\code{chartgrp}}{Chart group code}
#' \item{\code{chartcode}}{Unique chart code}
#' \item{\code{population}}{Population code: DS (Down Syndrome), HS (Hindostanic),
#' MA (Morrocan), NL (Dutch), PT (Preterm), TU (Turkish), WHOblue (WHO male),
#' WHOpink (WHO female)}
#' \item{\code{sex}}{Either \code{"male"}  or \code{"female"}}
#' \item{\code{design}}{Chart design A: 0-15m, B: 0-4y (WFH), C: 1-21y, D: 0-21y, E: 0-4y (WFA)}
#' \item{\code{side}}{Outcome measure: hgt (height), wgt (weight), hdc (head circumference),
#' wfh (weight for height), bmi (body mass index), front (multiple), back (multiple),
#' -hdc (back, no head circumference)}
#' \item{\code{language}}{Chart language: dutch}
#' \item{\code{week}}{Weeks of gestation 25-36, or missing (>= 37 weeks)}
#' }
#' @examples
#' # list all available charts
#' list_charts()
#' @export
list_charts <- function(chartgrp = NULL) {

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
    chartgrp = gp,
    chartcode = cd,
    att3,
    stringsAsFactors = FALSE)

  # subset if needed
  #
  if (!is.null(chartgrp)) df <- df[df$chartgrp == chartgrp, ]
  df
}
