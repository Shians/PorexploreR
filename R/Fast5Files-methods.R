#' @include Fast5Files.R
#' @importFrom dplyr sample_n
NULL

setMethod("show", signature = "Fast5Files",
function(object) {
    print(object)
})

setGeneric("sample_files", function(object, n) {
    standardGeneric("sample_files")
})

setMethod("sample_files", signature = c("Fast5Files", "numeric"),
function(object, n) {
    stopifnot(n <= nrow(object))
    Fast5Files(dplyr::sample_n(data.frame(object), n))
})
