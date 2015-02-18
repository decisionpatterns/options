#' set_option
#'
#' An alias for \code{options}
#'
#' @param ... named arguments passed to \code{options} -or- a single named list.
#'
#' Base has a \code{getOption} function, but does not have the complimentary
#' \code{setOption} function.  The \code{options} function is used instead.
#' \code{set_option} aliases for \code{options}
#'
#' @return
#'   If an argument is provided, behavior is as \code{\link[base]{options}}:
#'   For \code{options(name)}, a list of length one containing the set value,
#'   or NULL if it is unset. For uses setting one or more options, a list with
#'   the previous values of the options changed (returned invisibly).
#'
#'   If no argument is provided the \code{NULL} is returned invisibly. This is
#'   different from \code{\link[base]{options}}.
#'
#' @seealso
#'   \code{\link[base]{options}}
#'
#' @examples
#'   set_option( foo = list(bar='baz') )
#'
#'   set_option()  # NULL, Non-op
#'
#'   # NOT IMPLEMENTED YET:
#'   \dontrun{
#'     set_option( foo$bar := 'baz' )
#'     set_option( foo$bar ~ 'baz' )
#'   }
#'
#' @export

set_option <- function(...) {
  if( length(substitute(alist(...))) <= 1 ) return( invisible(NULL) )  else
  base::options(...)
}

# set_options <- function(...) {
#
#   x_ = substitute(alist(...))
#
# #   for( elem in x_[-1] ) { # removes alist
# #
# #     # if( elem ==  )
# #
# #   }
#   x_
#
# }
#
# for( el in 2:length(x) ) {
#   if( x[[el]][[1]] == ':=' ) {
#
#     opt <- x[[el]][[2]][[2]]  # name for the option
#
#   }
#
# }
#
# set_options( foo = 2, NULL, foo$bar := 10 )
