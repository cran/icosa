# Change log

## [0.9.80] - 2017-04-17
### Added
- the locate() function was updated to version 6.0, now incorporating the 'randomborders' argument
- the occupied() function was rebuilt on the locate() function
- the centers() shorthand was added to the quick extraction of the facecenters
- major work on the help files
- the value replacement method of the gridlayer was extended to host lat/long indicators
- added logical subsetting to the facelayer
- bugfix for the x86 application of SpPolygons()
 
## [0.8.61] - 2017-04-09
### Added
- igraph is added as related content 
- the function gridgraph() is implmented for 'trigrid' and for 'facelayer' classes
- fixed bug in OccupiedFaces() for SpatialPolygons
- the @graph slot has been added to the 'trigrid' class to host 'igraph' class graph representations
- package namespace is cleaned up to include only importing namespaces, only the rgl package is a dependency
- the newgraph() function is added to the package
- added an Rcpp function to interpolate 3d lines
- the gridgraph() function is added for the 'hexagrid' class, and the class constructor is upgraded to include it
- the vicinity() function replaced the neighbours() function
- the class of the values is now printed to the console, when the show method of the facelayer is called
- the tesselation and class of the source grid is now added to the gridlayer class, along with a function that checks the linked grid's compatibility to
the facelayer
- the translate() function is added to the package for fast reposition of translated grids to the origin
- the chullsphere() and surfacecentroid() functions were added to the packages
- resampling methods were added for the 'hexagrid'
- igraph representation was added to the vignette


## [0.8.16] - 2017-02-17
### Added
- the shapes() function is added to the package. It will calculate a value that is proportional to the irregularities of the triangular faces or subfaces.
- character values in facelayers will be plotted with random colors
- rgdal dependecy of spTransorm() was properly resolved
- the missing belts slot of the hexagrid class was filled 
- fixed missing invalid input message for PolToCar() function.
- grid resolution is now displayed with the show() method.
- the group generics Ops, Math, and Summary were implemented for the facelayer.
- basic functions of the 'stats' packages were implemented
- latitude and longitude-wise selection was implemented to the facelayer subsetting method
- resampling of 'facelayer' objects to based on 'trigrid' classes was applied in the program: downscaling
- added 2d plotting scheme for 'facelayers', where the values of the facelayer are exclusively colours

### Deleted
- the depriciated argument "border" is no longer available for the user interface of locate()

## [0.8.0] - 2016-11-25
### Added
- Most griding features are functional and should be usable, I consider the package to be ready for alpha testing.

### Notes
This is the alpha version. I know a lot of additional issues are present, but I need some rest from this project. 