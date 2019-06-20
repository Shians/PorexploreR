# PorexploreR

<!-- badges: start -->
[![Travis build status](https://travis-ci.org/Shians/PorexploreR.svg?branch=master)](https://travis-ci.org/Shians/PorexploreR)
<!-- badges: end -->

PorexploreR is a package for exploring raw Nanopore sequencing signals.

## Installation

You can install the released version of PorexploreR from GitHub with:

``` r
if (!require(remotes)) install.packaages("remotes")
remotes::install_github("shians/PorexploreR")
```

## Example

``` r
library(PorexploreR)

# get example file from package
fast5_file <- system.file("extdata/NA12878_short_read2.fast5", package = "PorexploreR")

# load in the squiggle
squiggle <- Squiggle(fast5_file)

# plot the squiggle
plot_squiggle(squiggle)

# some other information obtainable
raw_signal(squiggle)  # signal as stored in fast5 file
signal(squiggle)      # signal transformed to pA scale
meta(squiggle)        # metadata used to transform signal
```
## See Also

### R Packages
* [NanoR](https://github.com/davidebolo1993/NanoR) - A user-friendly R package to analyze and compare nanopore sequencing data.
* [poRe](https://sourceforge.net/projects/rpore/files/) - An R package to enable visualisation of nanopore sequencing data.
* [IONiseR](http://bioconductor.org/packages/release/bioc/html/IONiseR.html) - Quality assessment tools for Oxford Nanopore MinION data.

### Further Reading
* [A Look at the Nanopore fast5 Format](https://medium.com/@shiansu/a-look-at-the-nanopore-fast5-format-f711999e2ff6) - My blog article on exploring the fast5 format.
