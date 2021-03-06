#' Retinal Ganglion Cells (33 THY-1 positive, 33 THY-1 negative)
#'
#' A dataset containing a count matrix, cell-related metadata and gene-
#' related metdata.
#'
#' @format A list consisting of three objects:
#' \describe{
#'   \item{counts}{Count matrix stored in sparseMatrix format}
#'   \item{col_info}{DataFrame containing cell barcode and batch information}
#'   \item{row_info}{DataFrame containing gene names and corresponding ENSEMBL 
#'   gene identifiers}
#'   }
#' @name raw
#' @source \url{https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-6108/}
"raw"

#' Retinal Ganglion Cells (33 THY-1 positive, 33 THY-1 negative)
#'
#' An EMSet containing the data from "raw" loaded into an EMSet.
#'
#' @format A list consisting of three objects:
#' \describe{
#'   \item{counts}{Count matrix stored in sparseMatrix format}
#'   \item{colInfo}{DataFrame containing cell barcode and batch information}
#'   \item{rowInfo}{DataFrame containing gene names and corresponding ENSEMBL 
#'   gene identifiers}
#'   \item{controls}{A list containing mitochondrial-associated transcripts and
#'   ribosomal-associated transcripts}
#'   }
#' @name raw_set
#' @source \url{https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-6108/}
"raw_set"

#' Retinal Ganglion Cells (33 THY-1 positive, 33 THY-1 negative)
#'
#' An EMSet containing the data from "raw" loaded into an EMSet. This data has
#' been filtered and analysed as follows:
#'
#' @examples
#' \dontrun{
#' # Load packages
#' library(ascend)
#' library(matrixStats)
#' library(Matrix)
#' 
#' # Read dataset from disk
#' input_dir <- "~/Downloads/filtered_gene_bc_matrices_mex/GRCh38p7/"
#' matrix <- Matrix::readMM(paste0(input_dir, "matrix.mtx"))
#' genes <- read.csv(paste0(input_dir, "genes.tsv"), sep = "\t", header = FALSE, 
#'  = FALSE)
#' barcodes <- read.csv(paste0(input_dir, "barcodes.tsv"), sep = "\t", 
#' header = FALSE, stringsAsFactors = FALSE)
#' 
#' # Edit data frames
#' colnames(genes) <- c("ensembl_gene_id", "gene_id")
#' colnames(barcodes) <- c("cell_barcode")
#' genes$gene_id <- make.unique(genes$gene_id)
#' genes <- genes[, c("gene_id", "ensembl_gene_id")]
#' 
#' # Add batch information to barcodes data frame
#' barcodes$batch <- sapply(strsplit(barcodes$cell_barcode, "-"), 
#' function(x) x[2])
#' 
#' # Add identifiers to matrix
#' colnames(matrix) <- barcodes$cell_barcode
#' rownames(matrix) <- genes$gene_id
#' 
#' # Subset 33 cells from each batch
#' subset_barcodes1 <- sample(barcodes$cell_barcode[
#' which(barcodes$batch == 1)], 33, replace = FALSE)
#' subset_barcodes2 <- sample(barcodes$cell_barcode[
#' which(barcodes$batch == 2)], 33, replace = FALSE)
#' barcode_list <- c(subset_barcodes1, subset_barcodes2)
#' 
#' # Subset chosen cells from matrix
#' matrix <- matrix[, colnames(matrix) %in% barcode_list]
#' 
#' # Remove nonzero genes
#' cells_per_gene <- Matrix::rowSums(matrix > 0)
#' nonzero_genes <- rownames(matrix)[which(cells_per_gene > 0)]
#' 
#' # Subset chosen genes from matrix
#' matrix <- matrix[nonzero_genes, ]
#' 
#' # Convert matrix to dgCMatrix
#' matrix <- as(matrix, "dgCMatrix")
#' 
#' # Define controls
#' control_list <- list(Mt = grep("^MT-", rownames(matrix), value = TRUE),
#' Rb = grep("^RPS|^RPL", rownames(matrix), value = TRUE))
#' 
#' # Create an EMSet
#' raw_set <- EMSet(matrix, colInfo = barcodes, 
#' rowInfo = genes, controls = control_list)
#' 
#' # Get elements to use in tutorials and example
#' raw_counts <- counts(raw_set)
#' raw_col_info <- colInfo(raw_set)
#' raw_row_info <- rowInfo(raw_set)
#'
#' # Quick ascend workflow for use in tutorials and examples
#' working_set <- normaliseBatches(raw_set)
#' batch_norm_qc <- plotBatchNormQC(raw_object = raw_set, 
#' norm_object = working_set)
#' qc_plots <- plotGeneralQC(working_set)
#' 
#' working_set <- filterByOutliers(working_set, cell.threshold = 3, 
#' gene.threshold = 3, control.threshold = 3)
#' working_set <- filterLowAbundanceGenes(working_set, pct.threshold = 0.1)
#' 
#' col_info <- colInfo(working_set)
#' working_set <- normaliseByRLE(working_set)
#' working_set <- excludeControl(working_set, control = c("Mt", "Rb"))
#' working_set <- runPCA(working_set, scaling = TRUE, ngenes = 1500)
#'
#' working_set <- runCORE(working_set, conservative = FALSE, nres = 30, 
#' dims = 10, remove.outliers = FALSE)
#' working_set <- runTSNE(working_set, PCA = TRUE, dims = 2, 
#' seed = 1, perplexity = 15)
#' working_set <- runUMAP(working_set, PCA = TRUE, method = "naive")
#'
#' }
#' @name analyzed_set
#' @source \url{https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-6108/}
"analyzed_set"


