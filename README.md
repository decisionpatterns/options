# options

## Overview 

    setOption( foo = list( bar = "baz" ) )
   
    getOption( foo$bar )
    getOption( foo[['bar']]
    getOption( foo[[1]] )


## Installation 

    # SOON: install.packages("options")
    devtools::install_github("decisionpatterns/options.tools")
    
  

# 
Improvements to R's global options mechanism

R's internal global option mechanism is fairly important.  It is used to define singletons, set options for function, allow for load-time options for packages, etc.  Despite it's numerous uses, R's internal global option mechanism lacks some feature. As of this writing, there are only three functions: `options`, `getOption` and `.Options`.  The aim of this package is to fill in some of the missing functionality. Below is describe the functionality provide by this package.


## setOption

There is a function `getOption`, why not the complement `setOption`?  `options` provides one.


## Deep Introspection and Retrieval of Global Options

The preferred way of retrieving an option is using `getOption` from the `base` package. The limitiation with the base function is that options are retrieved by name (provided by a character string). This encourages bad practices for any complex options.  

`options` provides a drop-in replacement of `getOption` that accepts an expression as an argument that is subsequently evaluated on the Global Option environment. This allows for:

    getOption(foo$bar)    # INSTEAD OF:
    getOption(foo)$bar    

This has three advantages. First the syntax is clearer as to the intent. Second, the `default` argument is compared to the option at the correct level. This simplifies using options for functions.  For example:

   f <- function( x = getOption(foo$bar,20) ) ...   # INSTEAD OF:
   f <- function( x = if( is.null( getOption('foo')$bar ) ) getOption('foo')$bar else 20 

The third advantage is that it encourages package developers to place all of the options related to a package in a single list


## Deep Assignment of Global Options

The complement to deep introspection and retrieval is deep assignment.  Under base R, the entire options has to be assigned. `options` allows for deep assignment

     setOptions( foo$bar = 'baz' )
  
