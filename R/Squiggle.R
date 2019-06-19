#' @importFrom rhdf5 h5read
NULL

#' Squiggle
#'
#' This class is the representation of a "squiggle" from nanopore sequencing.
#'
#' @param object the Squiggle object
#'
#' @slot raw_signal integer. Represents the raw signal values.
#' @slot signal numeric (optional). Represents the transformed signal values.
#' @slot range numeric. Represents the range of values in signal.
#' @slot digitisation integer. Represents the digitisation range.
#' @slot offset integer. Represents the offset for raw signal.
#' @slot sampling_rate integer. Represents the raw signals captuerd per second.
#' @slot scaling numeric. Represents the scaling factor when transform raw to original signal.
#'
#'
#' @export
setClass(
    "Squiggle",
    slots = c(
        raw_signal = "integer",
        signal = "numeric",
        range = "numeric",
        digitisation = "integer",
        offset = "integer",
        sampling_rate = "integer",
        scaling = "numeric"
    )
)

#' Squiggle constructor
#'
#' Construct a Squiggle object from a path to a fast5 file
#'
#' @param file_path path to a fast5 file
#'
#' @return Squiggle object
#' @export
Squiggle <- function(file_path) {
    stopifnot(fs::file_exists(file_path))

    h5_signals <- rhdf5::h5read(file_path, "Raw/Reads", read.attributes = TRUE)
    signal_meta <- rhdf5::h5read(file_path, "UniqueGlobalKey/channel_id", read.attributes = TRUE)

    range <- attr(signal_meta, "range")
    digitisation <- attr(signal_meta, "digitisation")
    scaling <- range / digitisation
    offset <- attr(signal_meta, "offset")
    sampling_rate <- attr(signal_meta, "sampling_rate")

    new(
        "Squiggle",
        raw_signal = as.integer(h5_signals[[1]]$Signal),
        range = as.numeric(range),
        digitisation = as.integer(digitisation),
        offset = as.integer(offset),
        sampling_rate = as.integer(sampling_rate),
        scaling = as.numeric(scaling)
    )
}
