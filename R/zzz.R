#' Global Triangular and Hexa-Pentagonal Grids Based on Tessellated Icosahedra
#' 
#' The \bold{icosa} package provides tools to aggregate and analyze geographic data
#' using grids based on tessellated icosahedra. The procedures can be set to provide a grid with a
#'    custom resolution. Both the primary triangular and their inverted penta-
#'   hexagonal grids are available for implementation. Additional functions
#'    are provided to position points (latitude-longitude data) on the grids,
#'    to allow 2D and 3D plotting, use raster and vector spatial data.
#' 
#' This is still the Beta version. Notes about found bugs and suggestions are more than welcome!
#'
#' @author Adam T. Kocsis (adam.t.kocsis@gmail.com)
#' @docType package
#' @examples
#' # Create a triangular grid
#' tri <- trigrid(c(2,2))
#' @name icosa
"_PACKAGE"

#' @useDynLib icosa, .registration = TRUE, .fixes="Cpp"

#' @importFrom sf st_crs
#' @importFrom sf st_as_sf
#' @importFrom sf st_transform
#' @importFrom sf st_coordinates
#' @importFrom Rcpp sourceCpp
#' @importFrom sp coordinates
#' @importFrom igraph graph_from_data_frame
#' @importFrom igraph induced_subgraph
#' @importFrom sp sp.lines
#' @importFrom sp Line
#' @importFrom sp Lines
#' @importFrom sp SpatialLines
#' @importFrom sp Polygon
#' @importFrom sp Polygons
#' @importFrom sp SpatialPolygons
#' @importFrom sp plot
#' @importFrom sp CRS
#' @importFrom sp spsample
#' @importFrom grDevices colorRampPalette
#' @importFrom grDevices colors
#' @importFrom grDevices heat.colors
#' @importFrom graphics points
#' @importFrom graphics grid
#' @importFrom graphics par
#' @importFrom graphics rect
#' @importFrom graphics segments
#' @importFrom graphics text
#' @importFrom graphics locator
#' @importFrom methods .hasSlot
#' @importFrom methods as
#' @importFrom methods callGeneric
#' @importFrom methods new
#' @importFrom stats dist
#' @importFrom stats rnorm
#' @importFrom stats runif
#' @importFrom utils combn
#' @importFrom utils flush.console
#' @importFrom utils data
NULL

# package namespace variables
	origin<-c(0,0,0)
#	authRadius<-6371.0071810 # authalic radius (R2) based on Moritz, 1980
# updated! to confomr with ESRI:37008
	authRadius<-6370.997 
#	meanRadius<-6371.0087714 # mean radius (R1) based on Mortiz, 1980
#	volRadius <-6371.0007900 # radius of sphere of same volume

.onUnload <- function (libpath) {
	library.dynam.unload("icosa", libpath)
}

	# placeholders for lazy loading
	hexguide <- NULL
	triguide <- NULL
