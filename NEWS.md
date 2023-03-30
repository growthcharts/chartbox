# chartbox 1.13.0

* Regenerates `nl2010` charts from chartdesigner `0.40.1`

# chartbox 1.12.0

* Updates nl2010 chart from `chartdesigner 0.40.0`. This update corrects a bug that used the nl5 instead of the nl3 references for weight for age 0-15 months.

# chartbox 1.11.0

* Updates all chart from `chartdesigner 0.39.0`
* Expands on the `chartgrp` documentations

# chartbox 1.10.0

* Add four head circumference charts

# chartbox 1.9.0

* Sync version numbering with `chartcatalog` package

# chartbox 1.8.0

* Adds 28 charts for growth of children with Down syndrome to `nl2010` library

# chartbox 1.7.0

* Removes `chartdesigner` from suggests to ease container building

# chartbox 1.6.0

* Rebuilds all charts in R 4.1.0
* Found out the hard way that there were undocumented changes made to the internal structure of grobs saved to disk `grid 4.1.0`. Using `grid::draw()` on an object created by the `grid` package in R 4.0.5 (or earlier) resulted in the error from the C code in grid: `attempt to set index 26/22 in SET_VECTOR_ELT In call: grid.Call.graphics(C_setviewport, vp, TRUE)`. If you have this, update to R 4.1, rebuild the graphs, and save them.

# chartbox 1.5.0

* Update of all charts in an attempt to evade grid drawing problems

# chartbox 1.4.0

* Adds GitHub actions `R-CMD-check` and `pkgdown`

# chartbox 1.3.0

* Transfers repo to `growthcharts` organisation
* Added a `NEWS.md` file to track changes to the package.
