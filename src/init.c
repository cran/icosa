#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
Check these declarations against the C/Fortran source code.
*/

/* .C calls */
extern void locateTriangle_(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);

/* .Call calls */
extern SEXP icosa_Aggregate_(SEXP, SEXP, SEXP);
extern SEXP icosa_AllNeighboursTri_(SEXP, SEXP);
extern SEXP icosa_AllShapeTri_(SEXP, SEXP);
extern SEXP icosa_allTriangleCenters_(SEXP, SEXP, SEXP);
extern SEXP icosa_ArcDist_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_ArcDistMany_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_ArcDistMat_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_centroidPoints_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_Collapse_(SEXP);
extern SEXP icosa_CreateHexaSubfaces_(SEXP, SEXP, SEXP);
extern SEXP icosa_DirectNeighboursTri_(SEXP);
extern SEXP icosa_edgeListFromNeighbours_(SEXP);
extern SEXP icosa_edgeMatTri_(SEXP, SEXP);
extern SEXP icosa_edges_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_EdgesFromPoints_(SEXP, SEXP, SEXP);
extern SEXP icosa_EdgesToFaces_(SEXP);
extern SEXP icosa_EvenInterpolation_(SEXP, SEXP, SEXP);
extern SEXP icosa_ExpandBoundariesToCols_(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_expandEdges_(SEXP, SEXP, SEXP);
extern SEXP icosa_ExpandEdgesByFacesTri_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_expandFacesToEdges_(SEXP);
extern SEXP icosa_GetPatch_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_GreatCircle_(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_HexaFaces_(SEXP);
extern SEXP icosa_IcosahedronTesselation_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_InverseWeightByFaceCenter_(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_NeighbourOfOneFace_(SEXP, SEXP);
extern SEXP icosa_OccupiedCellUpSampling_(SEXP, SEXP);
extern SEXP icosa_orderTriGrid_(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_Partition_(SEXP, SEXP, SEXP);
extern SEXP icosa_pointLayerColorOrder_(SEXP);
extern SEXP icosa_projectCloseToPoint_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_Refine2d_(SEXP, SEXP);
extern SEXP icosa_RetrieveIndexMat_(SEXP);
extern SEXP icosa_ShapeTri_(SEXP, SEXP, SEXP);
extern SEXP icosa_SizeEstimate_(SEXP);
extern SEXP icosa_SphericalTriangleCenter_(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_SphericalTriangleSurface_(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_spherTriSurfs(SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_SplitArc_(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_stl_sort(SEXP);
extern SEXP icosa_SymmetricArcDistMat_(SEXP, SEXP, SEXP);
extern SEXP icosa_TriangleTesselation_(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP icosa_triMatTri_(SEXP, SEXP);
extern SEXP icosa_whichMinVector_(SEXP);
extern SEXP icosa_xxxxyyyyzzzz_(SEXP, SEXP);
extern SEXP icosa_xyz1(SEXP);
extern SEXP icosa_xyz1xyz1xyz1xyz1_(SEXP, SEXP);

static const R_CMethodDef CEntries[] = {
  {"locateTriangle_", (DL_FUNC) &locateTriangle_, 11},
  {NULL, NULL, 0}
};

static const R_CallMethodDef CallEntries[] = {
  {"icosa_Aggregate_",                 (DL_FUNC) &icosa_Aggregate_,                 3},
  {"icosa_AllNeighboursTri_",          (DL_FUNC) &icosa_AllNeighboursTri_,          2},
  {"icosa_AllShapeTri_",               (DL_FUNC) &icosa_AllShapeTri_,               2},
  {"icosa_allTriangleCenters_",        (DL_FUNC) &icosa_allTriangleCenters_,        3},
  {"icosa_ArcDist_",                   (DL_FUNC) &icosa_ArcDist_,                   4},
  {"icosa_ArcDistMany_",               (DL_FUNC) &icosa_ArcDistMany_,               4},
  {"icosa_ArcDistMat_",                (DL_FUNC) &icosa_ArcDistMat_,                4},
  {"icosa_centroidPoints_",            (DL_FUNC) &icosa_centroidPoints_,            4},
  {"icosa_Collapse_",                  (DL_FUNC) &icosa_Collapse_,                  1},
  {"icosa_CreateHexaSubfaces_",        (DL_FUNC) &icosa_CreateHexaSubfaces_,        3},
  {"icosa_DirectNeighboursTri_",       (DL_FUNC) &icosa_DirectNeighboursTri_,       1},
  {"icosa_edgeListFromNeighbours_",    (DL_FUNC) &icosa_edgeListFromNeighbours_,    1},
  {"icosa_edgeMatTri_",                (DL_FUNC) &icosa_edgeMatTri_,                2},
  {"icosa_edges_",                     (DL_FUNC) &icosa_edges_,                     4},
  {"icosa_EdgesFromPoints_",           (DL_FUNC) &icosa_EdgesFromPoints_,           3},
  {"icosa_EdgesToFaces_",              (DL_FUNC) &icosa_EdgesToFaces_,              1},
  {"icosa_EvenInterpolation_",         (DL_FUNC) &icosa_EvenInterpolation_,         3},
  {"icosa_ExpandBoundariesToCols_",    (DL_FUNC) &icosa_ExpandBoundariesToCols_,    5},
  {"icosa_expandEdges_",               (DL_FUNC) &icosa_expandEdges_,               3},
  {"icosa_ExpandEdgesByFacesTri_",     (DL_FUNC) &icosa_ExpandEdgesByFacesTri_,     4},
  {"icosa_expandFacesToEdges_",        (DL_FUNC) &icosa_expandFacesToEdges_,        1},
  {"icosa_GetPatch_",                  (DL_FUNC) &icosa_GetPatch_,                  4},
  {"icosa_GreatCircle_",               (DL_FUNC) &icosa_GreatCircle_,               5},
  {"icosa_HexaFaces_",                 (DL_FUNC) &icosa_HexaFaces_,                 1},
  {"icosa_IcosahedronTesselation_",    (DL_FUNC) &icosa_IcosahedronTesselation_,    4},
  {"icosa_InverseWeightByFaceCenter_", (DL_FUNC) &icosa_InverseWeightByFaceCenter_, 7},
  {"icosa_NeighbourOfOneFace_",        (DL_FUNC) &icosa_NeighbourOfOneFace_,        2},
  {"icosa_OccupiedCellUpSampling_",    (DL_FUNC) &icosa_OccupiedCellUpSampling_,    2},
  {"icosa_orderTriGrid_",              (DL_FUNC) &icosa_orderTriGrid_,              6},
  {"icosa_Partition_",                 (DL_FUNC) &icosa_Partition_,                 3},
  {"icosa_pointLayerColorOrder_",      (DL_FUNC) &icosa_pointLayerColorOrder_,      1},
  {"icosa_projectCloseToPoint_",       (DL_FUNC) &icosa_projectCloseToPoint_,       4},
  {"icosa_Refine2d_",                  (DL_FUNC) &icosa_Refine2d_,                  2},
  {"icosa_RetrieveIndexMat_",          (DL_FUNC) &icosa_RetrieveIndexMat_,          1},
  {"icosa_ShapeTri_",                  (DL_FUNC) &icosa_ShapeTri_,                  3},
  {"icosa_SizeEstimate_",              (DL_FUNC) &icosa_SizeEstimate_,              1},
  {"icosa_SphericalTriangleCenter_",   (DL_FUNC) &icosa_SphericalTriangleCenter_,   4},
  {"icosa_SphericalTriangleSurface_",  (DL_FUNC) &icosa_SphericalTriangleSurface_,  5},
  {"icosa_spherTriSurfs",              (DL_FUNC) &icosa_spherTriSurfs,              4},
  {"icosa_SplitArc_",                  (DL_FUNC) &icosa_SplitArc_,                  5},
  {"icosa_stl_sort",                   (DL_FUNC) &icosa_stl_sort,                   1},
  {"icosa_SymmetricArcDistMat_",       (DL_FUNC) &icosa_SymmetricArcDistMat_,       3},
  {"icosa_TriangleTesselation_",       (DL_FUNC) &icosa_TriangleTesselation_,       5},
  {"icosa_triMatTri_",                 (DL_FUNC) &icosa_triMatTri_,                 2},
  {"icosa_whichMinVector_",            (DL_FUNC) &icosa_whichMinVector_,            1},
  {"icosa_xxxxyyyyzzzz_",              (DL_FUNC) &icosa_xxxxyyyyzzzz_,              2},
  {"icosa_xyz1",                       (DL_FUNC) &icosa_xyz1,                       1},
  {"icosa_xyz1xyz1xyz1xyz1_",          (DL_FUNC) &icosa_xyz1xyz1xyz1xyz1_,          2},
  {NULL, NULL, 0}
};

void R_init_icosa(DllInfo *dll)
{
  R_registerRoutines(dll, CEntries, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
