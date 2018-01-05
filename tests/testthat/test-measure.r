context("Measurement model specification")

# Test cases
## Format 1 (includes all verbs)
mm <- constructs(
  reflective("Image",        multi_items("IMAG", 1:5)),
  reflective("Quality",      single_item("PERQ1")),
  composite("Satisfaction",  multi_items("CUSA", 1:3),weights = regression_weights),
  composite("Complaints",    single_item("CUSCO"),weights = correlation_weights)
)

# Testing

test_that("constructs correctly specifies the measurement matrix object", {
  expect_equal(colnames(mm), c("latent","measurement","type"))
  expect_equal(nrow(mm), 10)
  expect_equal(ncol(mm), 3)
})

test_that("composite correctly specifies mode B constructs", {
  expect_equal(as.vector(mm[7,]), c("Satisfaction","CUSA1","B"))
})

test_that("composite correctly specifies mode A constructs", {
  expect_equal(as.vector(mm[10,]), c("Complaints","CUSCO","A"))
})

test_that("reflect correctly specifies a reflective constructs", {
  expect_equal(as.vector(mm[1,]), c( "Image", "IMAG1","C"))
  expect_equal(as.vector(mm[6,]), c("Quality", "PERQ1","C"))
})

test_that("multi_items correctly allocates measurement items", {
  expect_equal(as.vector(mm[1:5,]), c("Image", "Image", "Image", "Image", "Image",
                                      "IMAG1", "IMAG2", "IMAG3", "IMAG4", "IMAG5",
                                      "C","C","C","C","C"))
  expect_equal(as.vector(mm[7:9,]), c("Satisfaction", "Satisfaction", "Satisfaction",
                                      "CUSA1", "CUSA2", "CUSA3",
                                      "B","B","B"))
})

test_that("single_item correctly allocates a measurement item", {
  expect_equal(as.vector(mm[6,]),  c("Quality","PERQ1","C"))
  expect_equal(as.vector(mm[10,]), c("Complaints","CUSCO","A"))
})
