# This scripts updates
# 1) the entire chart library
# 2) the pdf folder
# by calling the growthchart function in chartdesigner

stopifnot(packageVersion("chartdesigner") >= "0.45.0")

source("data-raw/R/make_charts_nl2010.R")
source("data-raw/R/make_charts_preterm.R")
source("data-raw/R/make_charts_who.R")
