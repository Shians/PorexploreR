#' @importFrom fs path_file
#' @importFrom purrr map_chr
NULL

setOldClass("data.frame")
setClass(
    "Fast5Files",
    contains = "data.frame"
)

Fast5Files <- function(x) {
    UseMethod("Fast5Files", x)
}

Fast5Files.character <- function(x) {
    raw_paths <- dir(
        x,
        "*.fast5",
        recursive = TRUE,
        full.names = TRUE
    )

    file_names <- fs::path_file(raw_paths)

    file_versions <- purrr::map_chr(
        raw_paths,
        function(x) as.character(rhdf5::h5readAttributes(x, "/")$file_version)
    )

    file_types <- purrr::map_chr(
        file_versions,
        function(x) ifelse(
            as.numeric(x) >= 2,
            "multi",
            "single"
        )
    )

    new(
        "Fast5Files",
        data.frame(
            name = file_names,
            path = raw_paths,
            version = file_versions,
            type = file_types
        )
    )
}

Fast5Files.data.frame <- function(x) {
    stopifnot(all.equal(colnames(x), c("name", "path", "version", "type")))
    new(
        "Fast5Files",
        x
    )
}

files <- Fast5Files("inst/data")
