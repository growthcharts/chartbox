# make_charts_who.R
#
# Writes selected WHO growth charts

library(chaco)
library(chartbox)

wholist <- c("WJAA", "WMAA", "WJBA", "WMBA")

sides <- wholist



# write to chartbox
project <- path.expand("~/package/chartbox/chartbox")
chartbox <- file.path(project, "inst/library/who")
for (chartcode in sides) {
  outfile <- file.path(chartbox, paste(chartcode, "rds", sep = "."))
  g <- growthchart(chartcode, paper = "A4")
  saveRDS(g, file = outfile, compress = "xz")
}

# check - reload every file
files <- dir(chartbox)
chartcodes <- unlist(strsplit(files, split = "[.]"))[seq(1, 2 * length(files), 2)]

# check - which sides do not have files?
sides[!sides %in% chartcodes]

# export chart to pdf
pdfdir <- file.path(project, "pdf")
pdf.options(useDingbats = FALSE, colormodel = "srgb", family = "Helvetica")

setpalet <- function(chartcode) {
  palettes <- create.palettes()
  parsed <- parse_chartcode(chartcode)
  palette(palettes[parsed$population,])
}

for (chartcode in chartcodes) {
  infile <- file.path(chartbox, paste(chartcode, "rds", sep = "."))
  g <- readRDS(file = infile)
  filename <- file.path(pdfdir, "who", paste(chartcode, "pdf", sep = "."))
  pdf(filename, height = 29.7/2.54, width = 21/2.54)
  setpalet(chartcode)
  grid::grid.draw(g)
  dev.off()
}

