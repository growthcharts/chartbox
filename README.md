
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chartbox

<!-- badges: start -->

<!-- badges: end -->

The `chartbox` package stores generated growth charts. With the package
you can

  - list the available growth charts;
  - set the color palette;
  - load one of the growth charts for further processing.

The package obtains its charts from the
[chartdesigner](https://github.com/stefvanbuuren/chartdesigner) package.

## Installation

In order to install `chartbox` you need a personal access token (PAT)
from <https://github.com/settings/tokens>. I assume the token is stored
in the environmental variable `GITHUB_PAT`, so that
`Sys.getenv("GITHUB_PAT")` returns your token.

The following statements will install the `chartbox` package

``` r
install.packages("remotes")
remotes::install_github("stefvanbuuren/chartbox")
```

## Example

The `load_chart()` function makes the stored growth charts available for
further processing. Here’s an example that writes chart `PJAAN25` to a
PDF file.

``` r
library(chartbox)

# choose and load chart
chartcode <- "PJAAN25"
g <- load_chart(chartcode)

# set the correct color palette
pop <- chartcatalog::parse_chartcode(chartcode)$population
old_pal <- palette(palettes[pop, ])

# create the pdf
pdf(paste(chartcode, "pdf", sep = "."), height = 29.7/2.54, width = 21/2.54)
grid::grid.draw(g)
dev.off()
#> quartz_off_screen 
#>                 2

# restore palette
palette(old_pal)
```
