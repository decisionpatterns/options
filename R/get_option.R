#' get_option - lazy, drop-in replacement for getOption
#'
#' Lazy, drop-in replacement for \code{base::getOption} that allows for deep
#' retrieval rather than access by name alone
#'
#' @param x character or unquoted expression for retrieving the option
#'
#' @param default if the specified option is not set in the options list, this
#' value is returned. This facilitates retrieving an option and checking whether
#' it is set and setting it separately if not.
#'
#' @description
#'
#' \code{get_option} allows for deep-inspection of Global Options. The problem
#' with \code{base::getOption} is that retrieves options
#' by name only. This make is difficult to work with deeply layered options and
#' promotes package developers to create top-level global options like
#' \code{data.table.xxx} rather than using \code{data.table$xxx}
#'
#' \code{base::getOption}
#'
#' @return
#' The current value for option \code{x} or \code{NULL} if unset.
#'
#' @seealso
#'   \code{\link[base]{getOption}} \cr
#'   \code{\link{set_option}}
#'
#' @examples
#'    set_option( foo = list( bar="baz" ) )
#'
#'    get_option('foo')
#'    get_option(foo)             # same, unquoted
#'
#'    # DEEP RETRIEVAL
#'    get_option(foo$bar)         # "baz"
#'    get_option( foo[['bar']] )  # "baz"
#'
#'    set_option( lets = letters[1:5] )
#'    get_option( lets[1:5] )
#'
#'    # USES DEFAULT
#'    get_option(xdx$ydy, default="default")  # does not exist, e.g.
#'
#' @export

get_option <- function(x, default = NULL) {

  x_ <- substitute(x)
  if( class(x_) == 'character' ) return( base::getOption( x_, default ) )

  try( ret <- eval(x_, .Options), silent=TRUE )

  if( ! exists('ret') || is.null(ret) ) return(default)
  return(ret)

}
