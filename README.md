# options

The `options` package provides a lazy replacement of R's global option / 
singleton functions: `getOption` and `options` in two easy-to-remember 
functions: `get_option` and `set_option`.

The `get_option` function accepts an unquoted expression that is evaluated on 
the global option environment. This allows for deep retrieval of an option 
allowing for a more natural syntax. Similarly, the `set_option` function allows 
for deep setting of options.

### Overview 

    set_option( foo = list( bar = "baz" ) )
   
    get_option( foo )
    get_option( foo$bar )
    get_option( foo[['bar']] )
    get_option( foo[[1]] )

    get_option( foobar )              # NULL (undefined)
    get_option( foobar, "UNDEFINED" ) # "UNDEFINED"
    

### Installation 

    # SOON: install.packages("options")
    devtools::install_github("decisionpatterns/options.tools")
   

### Improvements to R's global options mechanism

R's internal global option mechanism is fairly important.  It is used to define singletons, set options for function, allow for load-time options for packages, etc.  Despite it's numerous uses, R's internal global option mechanism lacks some feature. As of this writing, there are only three functions: `options`, `get_option` and `.Options`.  The aim of this package is to fill in some of the missing functionality. Below is describe the functionality provide by this package.


### set_option

There is a function `get_option`, why not the complement `set_option`?  The `options` packages provides one.

    set_option( foo = list( bar = "baz" ) )


### Deep Introspection and Retrieval of Global Options

The standard way of retrieving an option is using `getOption` from the `base` package. The limitiation with the base function is that options are retrieved by name (provided by a character string). This encourages bad practices.  

The `options` package provides a lazy, drop-in replacement of `get_option` that accepts an expression as an argument that is subsequently evaluated on the Global Option environment. This allows for:

    get_option(foo$bar)    # INSTEAD OF:
    get_option(foo)$bar    


This has three advantages. 

1. Syntax is clear as to the intent. 
2. The `default` argument is compared to the option at the correct level. This simplifies using options in function definitions.  For example:

    f <- function( x = get_option(foo$bar,20) ) ...   # INSTEAD OF:
    f <- function( x = if( is.null( get_option('foo')$bar ) ) get_option('foo')$bar else 20 

3. It encourages package developers to place all of the options related to a package in a element rather than polluting the options pairlist. 

```
set_option( mypackage = list( width=10, length=Inf ) ) 
get_option( mypackage$width )

# INSTEAD OF 
options( mypackage.width = 10, mypackage.length = Inf )
```


## NOT YET IMPLEMENTED 

### Deep Assignment of Global Options

The complement to deep introspection and retrieval is deep assignment.Under 
base R, the entire options has to be assigned. The `options` packages allows 
for deep assignment

     set_options( foo$bar = 'baz' )

## OVER-ZEALOUS CHECKING

The package checking mechanism will complain about any unquoted arguments to *_option though these are syntactically valid.  The error given is that there is an undefined variable with the name of the options. The solution is to define this variable as `NULL`.


