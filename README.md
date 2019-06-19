# PorexploreR

<!-- badges: start -->
<!-- badges: end -->

PorexploreR is a package for exploring raw Nanopore sequencing signals.

## Installation

You can install the released version of PorexploreR from [CRAN](https://CRAN.R-project.org) with:

``` r
if (!require(remotes)) install.packaages("remotes")
remotes::install_github("shians/PorexploreR")
```

## Example

``` r
library(PorexploreR)

# get example file from package
fast5_file <- system.file("data/NA12878_short_read2.fast5", package = "PorexploreR")

# load in the squiggle
squiggle <- Squiggle(fast5_file)

# plot the squiggle
plot_squiggle(squiggle)

# some other information obtainable
raw_signal(squiggle)  # signal as stored in fast5 file
signal(squiggle)      # signal transformed to pA scale
meta(squiggle)        # metadata used to transform signal
```


