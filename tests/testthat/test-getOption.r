#' test-getOption.r
#'
library(testthat)

context('getOption')

   li <- list( bar="baz" )
   options( foo = li )

   expect_is( getOption('foo'), 'list' )             # original
   expect_is( getOption(foo), 'list' )

   expect_identical( getOption('foo'), li )          # original
   expect_identical( getOption(foo), li )

   expect_is( getOption('foo')$bar, 'character')     # original
   expect_is( getOption(foo$bar), 'character' )
   expect_is( getOption(foo[['bar']]), 'character' )
   expect_is( getOption(foo[[1]]), 'character' )

   expect_identical( getOption('foo')$bar, li$bar)   # original
   expect_identical( getOption(foo$bar), li$bar )
   expect_identical( getOption(foo[['bar']]), li$bar )
   expect_identical( getOption(foo[[1]]), li$bar )

   expect_identical( getOption(xdx$ydy, default="default"), "default" )  # does not exist, e.g.
