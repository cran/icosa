
#' 2d plotting of a facelayer class object
#' This function will invoke the 2d plotting methods of a grid so data stored in a facelayer object can be displayed.
#'
#' The function passes arguments to the plot method of the \code{\link[sp]{SpatialPolygons}} class. In case a heatmap is plotted and the plotting device gets resized,
#' some misalignments can happen. If you want to use a differently sized window, use \code{\link[grDevices]{x11}} to set the height and width before running the function.
#' @param frame (\code{logical}) If \code{TRUE} the grid boundaries will be drawn with black.
#' @param col (\code{character}) Colors passed to a \code{\link[grDevices]{colorRamp}} in case of the \code{\link{facelayer}} contains \code{logical} values, a single value is required (defaults to \code{"red"}).
#' @param border (\code{character}) Specifies the color of the borders of the cells.
#' @param alpha (\code{character}) Two digits for the fill colors, in hexadecimal value between \code{0} and \code{255}.
#' @param breaks (\code{numeric}) The number of breakpoints between the plotted levels. The argument is passed to the \code{\link[base]{cut}} function. 
#' @param legend (\code{logical}): Should the legend be plotted? 
#' @param crs (\code{character} or \code{\link[sf:st_crs]{crs}}) A coordinate system for the transformation of coordinates.
#' @param inclusive (\code{logical}): If there are values beyond the limits of breaks, should these be represented in the plot (\code{TRUE}) or left out completely \code{FALSE}?
#' @param discrete (\code{logical}): Do the heatmaps symbolize a discrete or a continuous variable? This argument only affects the legend of the heatmap. 
#' @rdname plot
#' @exportMethod plot
setMethod(
	"plot",
	signature="facelayer",
	definition=function(x,crs=NULL,col="heat",border=NA, alpha=NULL, frame=FALSE,legend=TRUE, breaks=NULL, inclusive=TRUE, discrete=FALSE,  ...){
		actGrid<-get(x@grid)
		checkLinkedGrid(actGrid, x)
		
		# defend 'breaks'
		if(!is.null(breaks)){
			if(!is.numeric(breaks)) stop("The 'breaks' argument has to be numeric.")
			if(length(breaks)<3) stop("You need to provide at least three values to the 'breaks' argument.")
		}

		# defend alpha
		if(!is.null(alpha)){
			if(length(alpha)>1) stop("Only one 'alpha' value is permitted.")
		#	if(alpha<=1 & alpha>=0) alpha
		}

		#if no @sp found
		if(suppressWarnings(is.na(actGrid@sp))){
			stop(paste("Slot @sp in the linked grid \'",x@grid, "\' is empty.", sep=""))
		}
		
		#transformation is necessary
		if(!is.null(crs)){
			actGrid@sp <- methods::as(sf::st_transform(sf::st_as_sf(actGrid@sp), crs), "Spatial")
		}
		#check whether the  grid is actually updated
		if(sum(x@names%in%rownames(actGrid@faces))!=length(x)) 
		stop("The facenames in the linked grid does not match the facelayer object.")
		
		# if the grid is numerical and it has only one value, make it logical
		if(class(x@values)%in%c("integer","double", "numeric")){
			if(length(unique(x@values[!is.na(x@values)]))==1){
				x@values<-as.logical(x@values)
			}
			
		}
		#when the valuues are logical
		#FALSEs do not plot; NAs do not plot, TRUEs plot
		
		if(is.logical(x@values)){
			#just add NAs where the values are 0
			x@values[x@values==FALSE]<-NA
		}
		
		#if the number of values does not match the grid face no
		boolPresent1<-rep(T,nrow(actGrid@faces))
		if(length(x)!=nrow(actGrid@faces)){
			boolPresent1<-rownames(actGrid@faces)%in%x@names
		}
		actSp<-actGrid@sp[boolPresent1]
		
	
		#get rid of the NAs
		boolPresent<-rep(T,length(x))
		# in case there are NAs, do a subsetting before going on
		# rgl does not understand col=NA as omission of plotting
		if(sum(is.na(x@values))>0){
			# select only the faces that are available
			boolPresent<-!is.na(x@values) 
			#1. the values
			x@values<-x@values[boolPresent]
			#2. the names too
			x@names<- x@names[boolPresent]
			#3. number
			x@length <- sum(boolPresent)
		}
		actSp<-actSp[boolPresent]
		
		#when the values are logical
		if(inherits(x@values,"logical")){
			#set default color value
			if(length(col)==1) if(col=="heat") col <- "#FF0000"
			plot(actSp,col=col,border=border,...)
		}
		
		# when  numerical values are added to the facelayer object, do a heatmap!
		if(class(x@values)%in%c("integer","double", "numeric")){
			
			# calculate the breaking vector
			if(is.null(breaks)){
				minimum <- min(x@values)
				maximum <- max(x@values)
				steps <- length(x)+1
				
				# the vector used to cut the plottted variable
				useBreaks <- seq(minimum, maximum,length.out=steps)
			}else{
				minimum <- min(breaks)
				maximum <- max(breaks)
				useBreaks <- breaks
			}

			# still need to include limitations
			bMax <- FALSE
			bMin <- FALSE
			if(inclusive){
				# values that are beyond the minimum boundary set by breaks
				beyondMax <- which(x@values>maximum)
				if(length(beyondMax)>1){
					x@values[beyondMax] <- maximum
					bMax <- TRUE
				}
				# values that are beyond the minimum boundary set by breaks
				beyondMin <- which(x@values<minimum)
				if(length(beyondMin)>1){
					x@values[beyondMin] <- minimum
					bMin <- TRUE
				}
			}


			#do a heatmap!
			#create a ramp, with a given number of colours
			#the color vector will control the heatmap
			if(length(col)==1){
				# predefined
				if(col=="heat"){
#					col<-c("red","orange","yellow", "white")
					cols <- rev(grDevices::heat.colors(length(useBreaks)-1))
				
					cols<-substring(cols, 1,7)
				}else{
					
					if(length(col)==1){
						stop("You specified only one color.")
					}
				
				}
			} else{
			#do a heatmap!
				ramp<-grDevices::colorRampPalette(col, bias=2, space="Lab")
				# produce as many colours as there are values
				cols <- ramp(length(useBreaks)-1)
			}

			# do the cutting
			alreadyCut <- base::cut(x@values, breaks=useBreaks, include.lowest=TRUE)

			# transfer the factor to indices
			trans2 <- as.numeric(alreadyCut)

			# this is the ui sequence	
			faceColors<-cols[trans2]
			if(is.character(border)){
				if(length(unique(border))==1){
					if(substring(border[1], 1,1)=="#"){
						border=paste(border, alpha,sep="")
					}
				
				}
			}
			faceColors<-paste(faceColors, alpha, sep="")
			
			# set the new margins
			if(legend){
				graphics::par(mar=c(2,2,2,8))
			}
			# plot the sp object with the given argumetns
				# get rid of some of the arguments
				addArgs<-list(...)
				
				# arguments of the heatMapLegend()
				addArgs$tick.text<-NULL
				addArgs$ticks<-NULL
				addArgs$tick.cex<-NULL
				addArgs$barWidth<-NULL
				addArgs$barHeight<-NULL
				addArgs$tickLength<-NULL
				addArgs$xBot<-NULL
	
				
				firstArgs<-list(
					x=actSp,
					col=faceColors,
					border=border
				)
					
				plotArgs<-c(firstArgs, addArgs)
				
				do.call(plot, plotArgs)
			
			#the heatmap legend
			if(legend){
				#in case a heatmap is needed
				oldRef<-graphics::par()
				oldRef$cin<-NULL
				oldRef$cra<-NULL
				oldRef$cxy<-NULL
				oldRef$din<-NULL
				oldRef$page<-NULL
				oldRef$csi<-NULL
				
				graphics::par(usr=c(0,100,0,100))
				graphics::par(xpd=NA)
				graphics::par(mar=c(2,2,2,2))
				
				# additional argumetns to the heatmap, remove something
				addArgs<-list(...)
				addArgs$axes<-NULL
				addArgs$add<-NULL
				
				# what should be passed to the heatmaplegend
				if(!discrete){
					tickLabs <- useBreaks
				}else{
					tickLabs <-  (useBreaks+useBreaks[2:(length(useBreaks)+1)])/2
					tickLabs <- tickLabs[!is.na(tickLabs)]
				}
				

				firstArgs<-list(
					cols=cols,
					vals=tickLabs,
					add=TRUE,
					xLeft=101, 
					bounds=c(bMin, bMax)
				)
				
				# all the argumetns of the heatmap
				heatArgs<-c(firstArgs, addArgs)
				
				suppressWarnings(
					do.call(heatMapLegend, heatArgs)
				
				)
				graphics::par(oldRef)
			}
				
		}
		
		# when the values are text | they are not colors
		if(inherits(x@values,"character") & !sum(x@values%in%grDevices::colors())==x@length){
			# state the labels in 3d on the face (using the centers of the faces)
			colorAll <- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = TRUE)]
			active<-factor(x@values)
			if(length(levels(active))>length(colorAll)){
				cols<-sample(colorAll, length(levels(active)), replace=TRUE)
			}else{
				cols<-sample(colorAll, length(levels(active)), replace=FALSE)
			}
			
			faceColors<-cols[as.numeric(active)]
			if(is.character(border)){
				if(length(unique(border))==1){
					if(substring(border[1], 1,1)=="#"){
						border=paste(border, alpha,sep="")
					}
				
				}
			}
			faceColors<-paste(faceColors, alpha, sep="")
		
		}
		if(inherits(x@values,"character") & sum(x@values%in%grDevices::colors())==x@length){
			faceColors<-paste(x@values, alpha, sep="")
		}
		
		if(inherits(x@values,"character")){
		
			# plot the sp object with the given argumetns
				# get rid of some of the arguments
				addArgs<-list(...)
				
				# arguments of the heatMapLegend()
				addArgs$tick.text<-NULL
				addArgs$ticks<-NULL
				addArgs$tick.cex<-NULL
				addArgs$barWidth<-NULL
				addArgs$barHeight<-NULL
				addArgs$tickLength<-NULL
				addArgs$xBot<-NULL
	
				
				firstArgs<-list(
					x=actSp,
					col=faceColors,
					border=border
				)
					
				plotArgs<-c(firstArgs, addArgs)
				
				do.call(plot, plotArgs)
			
		}

		# when the col argument actually contains colors
		
		if(frame){
			
			plot(actSp, border="black", add=TRUE)
			
		}
	
	}

)


#' Plotting loosly referenced data with grid objects using sf's plotting methods
#' 
#' The function matches data referred to the grid and plots it with sf's plotting methods.
#' 
#' @param y Data or part of the grid to be plotted. If it is an unnamed character vector, then it is expected to be
#' a set of faces, which will be treated as a subscript that indicates the faces to be plotted.
#' If it is a logical vector, then it is expeced to be subscript, indicating a similar operation.
#' If it is a named logical or character vector, table with names, or single-dimensional named array
#' then the names are expected to refer to faces of the grid \code{x}. The default sf-based plotting method
#' will apply to the data type.
#' @param main The main title of the plot
#' @rdname plot
#' @name plot
#' @aliases plot,trigrid,array-method
#' @aliases plot,trigrid,character-method
#' @aliases plot,trigrid,logical-method
#' @aliases plot,trigrid,numeric-method
#' @aliases plot,trigrid,table-method
#' @examples
#' # A simple grid, with sf-representation
#' gr <- hexagrid(4, sf=TRUE)
#' dat <- 1:nrow(gr@faces)
#' names(dat) <- paste0("F", dat)
#' plot(x=gr, y=dat)
#' @exportMethod plot
setMethod(
	"plot",
	signature=c("trigrid", "numeric"),
	definition=function(x, y, crs=NULL, main="",  ...){

		if(!inherits(x@sf, "sf")) stop("The grid has no @sf representation.\nUse newsf() to create a 2d representation")
		if(is.null(names(y))) stop("'y' must have the grid's faces as names.")

		# the sf part 
		thesf <- x@sf
    	thesf$dat <- y[rownames(thesf)]
		if(any(!names(y)%in%faces(x))) stop("'y' must have the grid's faces as names.")

		if(!is.null(crs)){
			thesf <- sf::st_transform(thesf,crs)
		}

		# plot the data
		plot(thesf[, "dat"], main=main, ...)

	
	}
)

#' @name plot
#' @rdname plot
setMethod(
	"plot",
	signature=c("trigrid", "array"),
	definition=function(x, y, crs=NULL, main="",  ...){
		if(length(dim(y))!=1) stop("You can only plot 1-dimensional arrays!")

		# transform the array to a vector
		namedVect <- as.vector(y)
		names(namedVect) <- names(y)

		# execute the vector-based method
		plot(x=x, y=namedVect, crs=crs, main=main, ...)

	
	}
)

#' @name plot
#' @rdname plot
setMethod(
	"plot",
	signature=c("trigrid", "table"),
	definition=function(x, y, crs=NULL, main="",  ...){

		# transform the table to a vector
		namedVect <- as.numeric(y)
		names(namedVect) <- names(y)

		# execute the vector-based method
		plot(x=x, y=namedVect, crs=crs, main=main, ...)

	
	}
)


#' @name plot
#' @rdname plot
setMethod(
	"plot",
	signature=c("trigrid", "character"),
	definition=function(x, y, crs=NULL, main="",  ...){

		if(!inherits(x@sf, "sf")) stop("The grid has no @sf representation.\nUse newsf() to create a 2d representation")

		# the sf part
		thesf <- x@sf

		# only do this if there are no names on the values
		if(is.null(names(y))){
			# make sure that the selected cell names are unique
			y <- unique(y)

			# also omit any missing values
			y <- y[!is.na(y)]

			if(any(!y%in%faces(x))) stop("The character vector must contain only the names of the faces of grid.")

			# subset
			sfcSubgrid <- thesf[y,"geometry"]

			if(!is.null(crs)){
				sfcSubgrid <- sf::st_transform(sfcSubgrid,crs)
			}

			# plot the data
			plot(sfcSubgrid, main=main, ...)
		}else{
			if(is.null(names(y))) stop("'y' must have the grid's faces as names.")

			# the sf part
			thesf <- x@sf
			thesf$dat <- y[rownames(thesf)]
			if(any(!names(y)%in%faces(x))) stop("'y' must have the grid's faces as names.")

			if(!is.null(crs)){
				thesf <- sf::st_transform(thesf,crs)
			}

			# plot the data
			plot(thesf[, "dat"], main=main, ...)

		}


	}
)

#' @name plot
#' @rdname plot
setMethod(
	"plot",
	signature=c("trigrid", "logical"),
	definition=function(x, y, crs=NULL, main="",  ...){

		if(!inherits(x@sf, "sf")) stop("The grid has no @sf representation.\nUse newsf() to create a 2d representation")

		# the sf part
		thesf <- x@sf

		# only do this if the length matches the number of faces
		if(length(y)!=length(faces(x))) stop("The logical vector must have the same number values as there are grid faces.")
		if(any(is.na(y))) stop("'y' must not include missing values!")

		# subset
		sfcSubgrid <- thesf[y,"geometry"]

		if(!is.null(crs)){
			sfcSubgrid <- sf::st_transform(sfcSubgrid,crs)
		}

		# plot the data
		plot(sfcSubgrid, main=main, ...)

	}
)
