# save_palettes.R

palettes <- chartdesigner::create_palettes()
usethis::use_data(palettes, overwrite = TRUE)
