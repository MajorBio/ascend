---
title: "'ascend': Installation and environment setup"
author: "Anne Senabouth"
date: "2019-06-18"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{'ascend': Installation and environment setup}
  %\VignetteEngine{knitr::knitr}
  %\VignetteEncoding{UTF-8}
---



## Before you begin
### System requirements
Datasets produced by single cell RNA sequencing (scRNA-seq) experiments are 
very large and can range from a few hundred to a million cells. The number of 
cells affect the amount of computational resources required to process the 
dataset – therefore, you need to determine if you have enough computational 
power and time to complete the analysis. `ascend` can comfortably analyse 
datasets of up to 10,000 cells on a single machine with 8GB of RAM and a 
quad-core CPU. Larger datasets should be run on a High Performance Cluster 
(HPC).

We have tested this package on datasets ranging from 100 to 70,000 cells. 
Generally, increasing the number of CPUs will decrease the processing time of 
functions, while larger datasets require more RAM.

### Dependancy installation
`ascend` relies on packages found on CRAN and Bioconductor. Please install
these packages before installing `ascend`.

#### 1.3.1 Packages from CRAN
You can use the install.packages() to install the packages described in this 
section. The pcakages you require from this repository are as follows:

1. [devtools](https://cran.r-project.org/web/packages/devtools/index.html): This 
package will be used to load the development version of `ascend`.
2. [tidyverse](https://www.tidyverse.org/): This is a series of R packages 
for data science and visualisation. This will install packages such as dplyr,
ggplot2 and tidyr.
3. [data.table](https://github.com/Rdatatable/data.table/wiki/Installation):
Please follow the instructions on this page for your operating system.

#### Packages from Bioconductor
Bioconductor is a repository for R packages  related to the analysis and 
comprehension of high-throughput genomic data. It uses a separate set of 
commands for the installation of packages.

##### Setting up Bioconductor
Use the `BiocManager` package to load the Bioconductor installer.


```r
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install()
```

You can then install the Bioconductor packages using `install`.


```r
bioconductor_packages <- c("Biobase", "BiocGenerics", "BiocParallel",
                           "SingleCellExperiment", "GenomeInfoDb", 
                           "GenomeInfoDbData")
BiocManager::install(bioconductor_packages)
```

##### scater/scran package installation
[scater](https://bioconductor.org/packages/devel/bioc/html/scater.html) and 
[scran](https://bioconductor.org/packages/devel/bioc/html/scran.html) are 
scRNA-seq analysis toolboxes that provide more in-depth methods for QC and 
filtering. You may choose to install these packages if you wish to take 
advantage of the wrappers provided for these packages.

##### Differential expression packages
`ascend` provides wrappers for [DESeq](https://bioconductor.org/packages/release/bioc/html/DESeq.html) 
and [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html), 
so you may choose to add them to your installation.

##### Possible issues with the 'stringi' package
There may be issues for some users related to the R package "stringi". This 
package is a dependancy for some of the packages from Bioconductor. Try 
installing this package from [this website](https://cran.r-project.org/web/packages/stringi/index.html])

## Installing 'ascend' via devtools
As `ascend` is still under development, we will use devtools to install the
package.


```r
# Load devtools package
library(devtools)

# Use devtools to install the package
install_github("powellgenomicslab/ascend", build_vignettes = TRUE)
```

The package can then be loaded as normal.

```r
# Load the package in R
library(ascend)
```

## Configuring BiocParallel
This package makes extensive use of [BiocParallel](http://bioconductor.org/packages/release/bioc/html/BiocParallel.html), enabling `ascend` to make the most of your computer's hardware. As each system is different, BiocParallel needs to be configured by the user. Here are some example configurations.

### Unix/Linux/MacOS (Single Machine)

```r
library(BiocParallel)
ncores <- parallel::detectCores() - 1
register(MulticoreParam(workers = ncores, progressbar=TRUE), default = TRUE)
```

### Windows (Single Machine - Quad-core system)
The following commands allows Windows to parallelise functions via BiocParallel.
Unlike multicore processing in *nix systems, Snow creates additional R sessions 
to export tasks to. This requires additional computational resources to run and 
manage the tasks.

We recomend you bypass this step if your machine has lower specs.


```r
library(BiocParallel)
workers <- 3 # Number of cores on your machine - 1
register(SnowParam(workers = workers, 
                   type = "SOCK", 
                   progressbar = TRUE), default = TRUE)
```


