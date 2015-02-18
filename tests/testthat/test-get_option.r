#' test-getOption.r
#'
library(testthat)

context('get_option')

   li <- list( bar="baz" )
   options( foo = li )

   expect_is(get_option('foo'), 'list' )             # original
   expect_is(get_option(foo), 'list' )

   expect_identical(get_option('foo'), li )          # original
   expect_identical(get_option(foo), li )

   expect_is(get_option('foo')$bar, 'character')     # original
   expect_is(get_option(foo$bar), 'character' )
   expect_is(get_option(foo[['bar']]), 'character' )
   expect_is(get_option(foo[[1]]), 'character' )

   expect_identical(get_option('foo')$bar, li$bar)   # original
   expect_identical(get_option(foo$bar), li$bar )
   expect_identical(get_option(foo[['bar']]), li$bar )
   expect_identical(get_option(foo[[1]]), li$bar )

   expect_identical(get_option(xdx$ydy, default="default"), "default" )  # does not exist, e.g.
