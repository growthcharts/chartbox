# make_charts_nl2010.R
#
# Writes selected Dutch 2010 growth chart series to the data directory

library(chartdesigner)
library(chartbox)

paper <- "A4"

dutch <- c(
  "NJAA", "NJAB",
  "NJBA", "NJBB", "NJBC",
  "NJCA", "NJCB",
  "NJEA", "NJEB",
  "NMAA", "NMAB",
  "NMBA", "NMBB", "NMBC",
  "NMCA", "NMCB",
  "NMEA", "NMEB")

turkish <- c(
  "TJAA", "TJAB",
  "TJBA", "TJBB",
  "TJCA", "TJCB",
  "TMAA", "TMAB",
  "TMBA", "TMBB",
  "TMCA", "TMCB")

moroccan <- c(
  "MJAA", "MJAB",
  "MJBA", "MJBB",
  "MJCA", "MJCB",
  "MMAA", "MMAB",
  "MMBA", "MMBB",
  "MMCA", "MMCB")

hindostan <- c(
  "HJAA", "HJAB",
  "HJBA", "HJBC",
  "HJCA", "HJCC",
  "HMAA", "HMAB",
  "HMBA", "HMBC",
  "HMCA", "HMCC")

solo <- c(
  "HJAO", "HJAH", "HJAW", "HJBR", "HJBH", "HJCR", "HJCH", "HJCQ",
  "HMAO", "HMAH", "HMAW", "HMBR", "HMBH", "HMCR", "HMCH", "HMCQ",
  "MJAO", "MJAH", "MJAW", "MJBR", "MJBH", "MJBO", "MJCR", "MJCH", "MJCQ", "MJCO",
  "MMAO", "MMAH", "MMAW", "MMBR", "MMBH", "MMBO", "MMCR", "MMCH", "MMCQ", "MMCO",
  "NJAO", "NJAH", "NJAW", "NJBR", "NJBH", "NJBO", "NJCR", "NJCH", "NJCQ", "NJCO",
  "NJAD", "NMAD", "NJBD", "NMBD",
  "NJEW", "NJEH", "NJEO",
  "NMAO", "NMAH", "NMAW", "NMBR", "NMBH", "NMBO", "NMCR", "NMCH", "NMCQ", "NMCO",
  "NMEW", "NMEH", "NMEO",
  "TJAO", "TJAH", "TJAW", "TJBR", "TJBH", "TJBO", "TJCR", "TJCH", "TJCQ", "TJCO",
  "TMAO", "TMAH", "TMAW", "TMBR", "TMBH", "TMBO", "TMCR", "TMCH", "TMCQ", "TMCO")

sides <- c(dutch, turkish, moroccan, hindostan, solo)

# write to chartbox
project <- path.expand("~/package/chartbox/chartbox")
chartbox <- file.path(project, "inst/library/nl2010")
for (chartcode in sides) {
  outfile <- file.path(chartbox, paste(chartcode, "rds", sep = "."))
  g <- growthchart(chartcode, paper = paper)
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
  palettes <- chartbox::palettes
  parsed <- chartcatalog::parse_chartcode(chartcode)
  palette(palettes[parsed$population,])
}

for (chartcode in chartcodes) {
  infile <- file.path(chartbox, paste(chartcode, "rds", sep = "."))
  g <- readRDS(file = infile)
  filename <- file.path(pdfdir, "nl2010", paste(chartcode, "pdf", sep = "."))
  pdf(filename, height = 29.7/2.54, width = 21/2.54)
  setpalet(chartcode)
  grid::grid.draw(g)
  dev.off()
}

