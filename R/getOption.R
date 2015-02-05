#' getOption - dropin replacement
#'
#' Dropin replacement for \code{getOption} that allows for deep retrieval rather
#' than access by name alone
#'
#' @param x unquoted expression for retrieving the option
#'
#' @param default if the specified option is not set in the options list, this
#' value is returned. This facilitates retrieving an option and checking whether
#'  it is set and setting it separately if not.
#'
#' @description
#'
#' \code{getOption} allows for deep-inspection of Global Options. The problem
#' with the base implementation of \code{getOption} is that retrieves options
#' by name. This make is difficult to work with deeply layered options and
#' promotes package developers to create top-level global options like
#' \code{data.table.xxx} rather than using \code{data.table$xxx}
#'
#' @return
#' The current value for option \code{x} or \code{NULL} if unset.
#'
#' @seealso
#'   \code{\link[base]{getOption}} \cr
#'   \code{\link{setOption}}
#'
#' @examples
#'    options( foo = list( bar="baz" ) )
#'
#'    getOption( 'foo' )
#'    getOption( foo )
#'    getOption( foo$bar )       # "baz"
#'    getOption( foo[['bar']] )  # "baz"
#'
#'    options( lets = letters )
#'    getOption( lets[1:5] )
#'
#' @export

getOption <- function(x, default = NULL) {

  x_ <- substitute(x)
  if( class(x_) == 'character' ) return( base::getOption( x_, default ) )

  ret <- eval(x_, .Options)

  if( is.null(ret) ) return(default)
  return(ret)

}




# eval( quote(foo$bar), as.environment( as.list( .Options ) ), enclos = .GlobalEnv )
