
options(width = 80) # keeps to_screen examples unchanged

example_code_for_topic <- function (fname) {
  path <- devtools::find_topic(fname)[1] # sometimes we get multiples!

  if (is.null(path)) stop('No help exists for ', fname)
  expath <- tempfile(paste0('test-example-', fname))
  tools::Rd2ex(path, expath, commentDontrun = TRUE, commentDonttest = TRUE)
  if (! file.exists(expath)) stop('Could not make example for ', fname)
  parse(expath)
}


code_path_for_topic <- function (fname) file.path(test_path(), 'example-rds',
      paste0(fname, '-example-code.rds'))


# runs example and checks output & values haven't changed; optionally reset files if code has changed
test_ex_same <- function(fname, reset_on_change = TRUE) {
  skip_on_R_CMD_check()
  excode <- example_code_for_topic(fname)
  codepath <- code_path_for_topic(fname)
  if (file.exists(codepath)) {
    comp <- testthat::compare(deparse(excode), readRDS(codepath))
    if (! comp$equal) {
      warning('Example code for ', fname, ' changed')
      if (reset_on_change) reset_example_test(fname)
      return(invisible())
    }
  } else {
    remake_code_file(fname)
  }

  exenv <- new.env()
  i <- 1
  for (expr in excode) {
    out <- capture.output(res <- eval(expr, envir = exenv))
    rds_name <- paste0(fname, '-example-value-', i, '.rds')
    fp <- file.path(testthat::test_path(), 'example-rds', rds_name)
    expect_equal_to_reference(res, fp, info =
          paste0('In "', fname, '", expression changed value: ', deparse(expr, nlines = 1)))
    rds_name <- paste0(fname, '-example-output-', i, '.rds')
    fp <- file.path(testthat::test_path(), 'example-rds', rds_name)
    expect_equal_to_reference(out, fp, info =
          paste0('In "', fname, '", expression changed output: ', deparse(expr, nlines = 1)))

    i <- i + 1
  }
}


reset_example_test <- function (fnames) {
  devtools::load_all('.')

  for (fname in fnames) {
    # get rid of output and code files
    fs <- list.files(file.path(testthat::test_path()))
    fs <- grep(paste0('^', fname, '-example-.*'), fs, value = TRUE)
    fs <- file.path(testthat::test_path(), fs)
    sapply(fs, file.remove)
    remake_code_file(fname)
    # rewrite code file
  }

  invisible()
}


remake_code_file <- function (fname) {
  excode <- example_code_for_topic(fname)
  codepath <- code_path_for_topic(fname)
  saveRDS(deparse(excode), file = codepath)
}


skip_without_pandoc <- function () {
  if (! rmarkdown::pandoc_available('1.12.3')) skip('Not testing, pandoc >= 1.12.3 is not available')
}


skip_on_R_CMD_check <- function () {
  skip_if(exists('we_are_in_R_CMD_check'), 'Not testing, code doesn\'t play well with R CMD check')
  skip_if(Sys.getenv('COVERAGE') != '', 'Not testing, code doesn\'t play well with R CMD check')
}


require_temp_artefacts_dir <- function () {
  if (dir.exists('temp-artefacts')) return(TRUE)
  if (dir.create('temp-artefacts', showWarnings = FALSE)) {
    return(TRUE)
  } else {
    skip('Couldn\'t create temp-artefacts dir')
  }
}
