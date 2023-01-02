
#' Add raku engine to knitr.
#'
#' Invoke the raku engine like so:
#'
#' ````
#' ```{raku}
#' ...
#' ```
#' ````
#'
#' @param libname Not used.
#' @param pkgname Not used.
#'
#' @return Nothing (invisible)
#' @export
#'
#' @author fnaufel
#' @importFrom knitr knit_engines engine_output
.onAttach <- function(libname, pkgname) {

  knitr::knit_engines$set(
    raku = function(options) {
      code <- paste(options$code, collapse = '\n')
      out  <- system2(
        'raku',
        c('-e', shQuote(code)),
        stdout = TRUE
      )
      knitr::engine_output(options, code, out)
    }
  )

  packageStartupMessage(
    'Enabling Raku knitr engine.\n',
    'Use ```{raku} in code chunk.\n'
  )

  invisible()

}
