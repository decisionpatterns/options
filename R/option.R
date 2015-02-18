#' option
#'
#' Get or set a single option
#'
#' @param ... quoted or unquoted name -OR- name = value expression used to set
#' the option
#'
#' \code{option} gets the argument if it is a single quoted or unquoted name.
#' If the argument is a name = value pair, the option with the name is set.
#'
#' Unlike \code{\link{get_option}}, \code{option}
#' does not support a \code{default} argument.
#'
#' @note
#'   Though it might be desirous to set options wih syntax like:
#'       \code{option(x) <- 5}
#'   this is not currently possible due to how the R works. This is discussed
#'   at length at Stack Overflow: \cr
#'     \url{http://stackoverflow.com/questions/15252537/why-are-arguments-to-replacement-functions-not-evaluated-lazily}
#'
#' @references
#'   \url{http://stackoverflow.com/questions/15252537/why-are-arguments-to-replacement-functions-not-evaluated-lazily}
#'
#' @seealso
#'   \code{\link{set_option}} \cr
#'   \code{\link{get_option}} \cr
#'
#' @examples
#'
#'   # option(xdx) <- 10  # does not work
#'   set_option(foo="bar")
#'
#'   option(foo)
#'   option(baz)          # NULL, MISSING
#'   option(NA)           # NA, BY DEFINITION
#'
#'   # NOT IMPLEMENTED YET:
#'   # option( foo=1 )
#'   # option( foo$bar=1 ) # DEEP ASSIGNMENT
#'
#' @export

option <- function(...) {

  x_ <- substitute(x)
  if( class(x_) == 'character' ) return( base::getOption(x_) )

  try( ret <- eval(x_, .Options), silent=TRUE )

  if( ! exists('ret') || is.null(ret) ) return(NULL)
  return(ret)

}

