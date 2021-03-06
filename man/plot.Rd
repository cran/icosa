% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot-2d-grid.R, R/plot-2d-facelayer.R
\docType{data}
\name{plot}
\alias{plot}
\alias{plot,trigrid,ANY-method}
\alias{plot,facelayer,ANY-method}
\title{Plot method for the \code{\link{trigrid}}, \code{\link{hexagrid}} or \code{\link{facelayer}} classes}
\format{
An object of class \code{standardGeneric} of length 1.
}
\usage{
plot

\S4method{plot}{trigrid,ANY}(x, projargs = NULL, ...)

\S4method{plot}{facelayer,ANY}(
  x,
  projargs = NULL,
  col = "heat",
  border = NA,
  alpha = NULL,
  frame = FALSE,
  legend = TRUE,
  breaks = NULL,
  inclusive = TRUE,
  discrete = FALSE,
  ...
)
}
\arguments{
\item{x}{(\code{\link{trigrid}}, \code{\link{hexagrid}} or \code{\link{facelayer}}) The object to be plotted.}

\item{projargs}{(\code{character} or \code{\link[sp:CRS-class]{CRS}}) A projection string for the transformation fo coordinates.}

\item{...}{Arguments passed to the \code{plot} function.}

\item{col}{(\code{character}) Colors passed to a \code{\link[grDevices]{colorRamp}} in case of the \code{\link{facelayer}} contains \code{logical} values, a single value is required (defaults to \code{"red"}).}

\item{border}{(\code{character}) Specifyies the color of the borders of the cells.}

\item{alpha}{(\code{character}) Two digits for the fill colors, in hexadecimal value between \code{0} and \code{255}.}

\item{frame}{(\code{logical}) If \code{TRUE} the grid boundaries will be drawn with black.}

\item{legend}{(\code{logical}): Should the legend be plotted?}

\item{breaks}{(\code{numeric}) The number of breakpoints between the plotted levels. The argument is passed to the \code{\link[base]{cut}} function.}

\item{inclusive}{(\code{logical}): If there are values beyond the limits of breaks, should these be represented in the plot (\code{TRUE}) or left out completely \code{FALSE}?}

\item{discrete}{(\code{logical}): Do the heatmaps symbolize a discrete or a continuous variable? This argument only affects the legend of the heatmap.}
}
\value{
The function has no return value.
}
\description{
This function will invoke the \code{plot} method of the \code{\link[sp]{SpatialPolygons}} class.

The function passes arguments to the plot method of the \code{\link[sp]{SpatialPolygons}} class. In case a heatmap is plotted and the plotting device gets resized,
some misalignments can happen. If you want to use a differently sized window, use \code{\link[grDevices]{x11}} to set the height and width before running the function.
}
\keyword{datasets}
