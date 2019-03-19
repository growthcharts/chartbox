context("curve_interpolation")

# with single observation per group
data1 <- data.frame(
  id = c(1, 1, 1, 2, 3, 3, 3),
  age = c(0, 0.2, 1.2, 0.5, 0.1, 1, 1.3),
  hgt = c(52, 60, 78, 69, 62, 78, 82),
  stringsAsFactors = FALSE)

# with two or more observations per group
data2 <- data.frame(
  id = c(1, 1, 1, 2, 2, 3, 3, 3),
  age = c(0, 0.2, 1.2, 0.5, 0.7, 0.1, 1, 1.3),
  hgt = c(52, 60, 78, 69, 70, NA, NA, NA),
  stringsAsFactors = FALSE)

ref <- clopus::nl2009[["nl2009.mhgtNL"]]

test_that("handles id with single observations", {
  expect_equal(c(52, 60.0, 68.4, 75.9, 78.0, 69.0, 62.0, 72.5, 78.0, 82.0),
               curve_interpolation(data1, xname = "age", yname = "hgt", xout = seq(0, 1.3, 0.5),
                                   reference = ref)$hgt,
               tolerance = 0.001)
  })

test_that("handles id with all missing outcome measurements", {
  expect_equal(c(52, 60.0, 68.4, 75.9, 78.0, 69.0, 70.0, NA, NA, NA, NA),
               curve_interpolation(data2, xname = "age", yname = "hgt", xout = seq(0, 1.3, 0.5),
                                   reference = ref)$hgt,
               tolerance = 0.001)
})

