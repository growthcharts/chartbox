set_form_design <- function(g) {

  if (g$name != "axes")
    stop("Expected object with name `axes`, but found ", g$name)

  # set rectangular axis
  xlim <- range(as.numeric(g$children$plotarea$x))
  ylim <- range(as.numeric(g$children$plotarea$y))
  xya <- matrix(c(xlim, rep(xlim[1], 2L),  xlim, rep(xlim[2L], 2L),
                  rep(ylim[1L], 2L), ylim, rep(ylim[2L], 2L), ylim,
                  rep(1:4, each = 2L)),
                ncol = 3L,
                dimnames = list(NULL, c("x", "y", "a")),
                byrow = FALSE)

  # extract label positions
  ats <- list(g$children$axis1$at,
              g$children$axis2$at,
              g$children$axis3$at,
              g$children$axis4$at)

  # extract labels
  labels <- list(g$children$axis1$label,
                 g$children$axis2$label,
                 g$children$axis3$label,
                 g$children$axis4$label)

  # extract fontsize
  fontsize <- list(g$children$axis1$gp$fontsize,
                   g$children$axis2$gp$fontsize,
                   g$children$axis3$gp$fontsize,
                   g$children$axis4$gp$fontsize)

  # extract fontsize
  lineheight <- list(g$children$axis1$gp$lineheight,
                     g$children$axis2$gp$lineheight,
                     g$children$axis3$gp$lineheight,
                     g$children$axis4$gp$lineheight)

  return(list(xya = xya, ats = ats, labels = labels,
              fontsize = fontsize, lineheight = lineheight))
}
