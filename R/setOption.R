#' setOption
#'
#' An alias for \code{options}
#'
#' @param ... named arguments passed to \code{options} -or- a single named list.
#'
#' It is surprising that base has a \code{getOption} function, but does not have
#' the complimentary \code{setOption} function and uses \code{options} instead.
#' \code{setOption} is an alias for \code{options}
#'
#' @seealso
#'   \code{\link[base]{options}}
#'
#' @examples
#'   setOption( foo = list(bar='baz') )
#'
#' @export

setOption <- base::options
