#' @include Squiggle.R

#' @rdname Squiggle-class
#' @export
setGeneric("raw_signal", function(object) {
    standardGeneric("raw_signal")
})

#' @export
setMethod("raw_signal", signature(object = "Squiggle"), function(object) {
    object@raw_signal
})


#' @rdname Squiggle-class
#' @export
setGeneric("signal", function(object) {
    standardGeneric("signal")
})

#' @export
setMethod("signal", signature(object = "Squiggle"), function(object) {
    if (length(object@signal) != 0) {
        as.numeric(object@signal)
    } else {
        as.numeric(object@scaling * (object@raw_signal + object@offset))
    }
})


#' @rdname Squiggle-class
#' @export
setGeneric("meta", function(object) {
    standardGeneric("meta")
})

#' @export
setMethod("meta", signature(object = "Squiggle"), function(object) {
    list(
        range = object@range,
        digitisation = object@digitisation,
        offset = object@offset,
        sampling_rate = object@sampling_rate,
        scaling = object@scaling
    )
})


#' @export
setGeneric("plot_squiggle", function(object, time_span = c(0, 0.5)) {
    standardGeneric("plot_squiggle")
})

.plot_squiggle <- function(object, time_span) {
    signal <- signal(object)
    meta <- meta(object)

    plot_data <- tibble::tibble(
        time = seq_along(signal) / meta$sampling_rate,
        signal = signal
    ) %>%
        dplyr::filter(time > time_span[1] & time < time_span[2])

    ylim_offset <- 0.05 * (max(plot_data$signal) - min(plot_data$signal))
    ylim_expanded <- c(
        min(plot_data$signal) - ylim_offset,
        max(plot_data$signal) + ylim_offset
    )

    plot_data %>%
        ggplot2::ggplot(ggplot2::aes(x = time, y = signal)) +
        ggplot2::geom_step() +
        ggplot2::coord_cartesian(
            ylim = ylim_expanded,
            expand = FALSE
        ) +
        ggplot2::theme_classic() +
        ggplot2::theme(panel.background = ggplot2::element_rect(colour = "black", size = 1.5)) +
        ggplot2::xlab("time (s)") +
        ggplot2::ylab("current (pA)")
}

#' @export
setMethod("plot_squiggle", c(object = "Squiggle", time_span = "numeric"),
    .plot_squiggle
)

#' @export
setMethod("plot_squiggle", c(object = "Squiggle", time_span = "missing"),
    .plot_squiggle
)
