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

fast5_file <- system.file("data/NA12878_short_read1.fast5", package = "PorexploreR")

squiggle <- Squiggle(fast5_file)
plot_squiggle(squiggle)
```


