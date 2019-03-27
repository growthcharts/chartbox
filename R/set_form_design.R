set_form_design <- function(ax) {

  if (ax$name != "axes")
    stop("Expected object with name `axes`")

  # extract old xya
  old_xya <- matrix(
    c(ax$children$axis1$xy$x, ax$children$axis2$xy$x,
      ax$children$axis3$xy$x, ax$children$axis4$xy$x,
      ax$children$axis1$xy$y, ax$children$axis2$xy$y,
      ax$children$axis3$xy$y, ax$children$axis4$xy$y,
      rep(1, length(ax$children$axis1$xy$x)),
      rep(2, length(ax$children$axis2$xy$x)),
      rep(3, length(ax$children$axis3$xy$x)),
      rep(4, length(ax$children$axis4$xy$x))),
    ncol = 3L, byrow = FALSE, dimnames = list(NULL, c("x", "y", "a")))

  # set rectangular axis
  xlim <- range(old_xya[, "x"])
  ylim <- range(old_xya[, "y"])
  xya <- matrix(
    c(xlim, rep(xlim[1L], 2L),  xlim, rep(xlim[2L], 2L),
      rep(ylim[1L], 2L), ylim, rep(ylim[2L], 2L), ylim,
      rep(1:4, each = 2L)),
    ncol = 3L, byrow = FALSE, dimnames = list(NULL, c("x", "y", "a")))

  # extract label positions
  old_ats <- list(ax$children$axis1$at,
                  ax$children$axis2$at,
                  ax$children$axis3$at,
                  ax$children$axis4$at)

  # set new label position
  all.x <- unique(c(old_ats[[1L]], old_ats[[3L]]))
  all.y <- unique(c(old_ats[[2L]], old_ats[[4L]]))
  add1 <- setdiff(all.x, old_ats[[1L]])
  add2 <- setdiff(all.y, old_ats[[2L]])
  add3 <- setdiff(all.x, old_ats[[3L]])
  add4 <- setdiff(all.y, old_ats[[4L]])
  ats <- list(
    c(old_ats[[1L]], add1),
    c(old_ats[[2L]], add2),
    c(add3, old_ats[[3L]]),
    c(add4, old_ats[[4L]]))

  # extract labels
  old_labels <- list(ax$children$axis1$label,
                     ax$children$axis2$label,
                     ax$children$axis3$label,
                     ax$children$axis4$label)

  # set labels
  labels <- list(TRUE, TRUE, TRUE, TRUE)
  if (length(old_labels[[1L]]) > 1L)
    labels[[1L]] <- c(old_labels[[1L]], add1)
  if (length(old_labels[[2L]]) > 1L)
    labels[[2L]] <- c(old_labels[[2L]], add2)
  if (length(old_labels[[3L]]) > 1L)
    labels[[3L]] <- c(add3, old_labels[[3L]])
  if (length(old_labels[[4L]]) > 1L)
    labels[[4L]] <- c(add4, old_labels[[4L]])

  # extract fontsize
  fontsize <- list(ax$children$axis1$gp$fontsize,
                   ax$children$axis2$gp$fontsize,
                   ax$children$axis3$gp$fontsize,
                   ax$children$axis4$gp$fontsize)

  # extract fontsize
  lineheight <- list(ax$children$axis1$gp$lineheight,
                     ax$children$axis2$gp$lineheight,
                     ax$children$axis3$gp$lineheight,
                     ax$children$axis4$gp$lineheight)

  return(list(xya = xya, ats = ats, labels = labels,
              fontsize = fontsize, lineheight = lineheight))
}
