#' Extract rectangular plots from a chart
#'
#' This function will extract the rectangular plots from the chart. It
#' will redefine the axes as rectangular, recalculate the gridlines,
#' extend the axis labels, and move around annotation object. This
#' version preserve the original aspect ratio.
#' @param chartcode The chart code
#' @param ynames    Vector with names of measures to extract
#' @param asp       Aspect ratio. Specify \code{asp = 1} for square
#' data area. The default takes the aspect ratio from the
#' chart.
#' @param width     The width of the plot area + margins. The default
#' is \code{unit("18", "cm")}
#' @examples
#' \dontrun{
#' library(grid)
#' library(chartbox)
#' p <- extract_rectangular("NJAA")
#' palette(palettes[1, ])
#' grid.newpage()
#' grid.draw(p[["hgt"]])
#' }
#' @export
extract_rectangular <- function(chartcode,
                                ynames = c("hgt", "wgt", "hdc", "bmi", "wfh"),
                                asp = NULL,
                                width = unit(18, "cm")) {
  g <- load_chart(chartcode)
  ynames <- ynames[ynames %in% childNames(g)]
  if (length(ynames) == 0L) return(gList())

  collect <- gList()
  for (yname in ynames) {
    gy <- g$children[[yname]]

    # extract and set rectangular format specification
    axes <- gy$children$axes
    form <- set_form_design(axes)

    # define aspect ratio
    if (is.null(asp))
    {
      h <- g$childrenvp[[get_viewport(chartcode, yname)]]$height
      w <- g$childrenvp[[get_viewport(chartcode, yname)]]$width
      asp <- as.numeric(w) / as.numeric(h)
    }

    # define viewport
    xlim <- range(form$xya[, "x"])
    ylim <- range(form$xya[, "y"])
    vp <- chaco::viewport.scatterplot(x = xlim, y = ylim, f = 0,
                                      width = width, asp = asp)

    # define axes
    axeslist <- do.call(chaco::axesGrob, list(form = form))
    axes <- axeslist$graph

    # edit modules
    modules <- gy$children$modules

    xgrid <- gy$children$modules$children$gridlines$children$vertical$x0
    xlwd  <- gy$children$modules$children$gridlines$children$vertical$gp$lwd
    ygrid <- gy$children$modules$children$gridlines$children$horizontal$y0
    ylwd  <- gy$children$modules$children$gridlines$children$horizontal$gp$lwd

    # redraw gridlines
    gridlines <- chaco::gridlinesGrob(xy.axes = axeslist$xy.axes,
                                      at  = list(xgrid, ygrid),
                                      lwd = list(xlwd,  ylwd))

    # save results
    modules <- setGrob(modules, "gridlines", gridlines, strict = TRUE)
    grobs <- gList(axes, modules)
    collect[[yname]] <- gTree(children = grobs, name = yname, vp = vp)
  }
  collect
}
