#
#
#  Adaption of the delphi3d.net OpenGL units to FreePascal
#  Sebastian Guenther (sg@freepascal.org) in 2002
#  These units are free to use
#******************************************************************************
# Converted to Delphi by Tom Nuydens (tom@delphi3d.net)                        
# For the latest updates, visit Delphi3D: http://www.delphi3d.net              
#******************************************************************************

import 
  GL

when defined(windows): 
  {.push, callconv: stdcall.}
else: 
  {.push, callconv: cdecl.}

when defined(windows): 
  const 
    dllname = "glu32.dll"
elif defined(macosx): 
  const 
    dllname = "/System/Library/Frameworks/OpenGL.framework/Libraries/libGLU.dylib"
else: 
  const 
    dllname = "libGLU.so.1"
type 
  TViewPortArray* = Array[0..3, TGLint]
  T16dArray* = Array[0..15, TGLdouble]
  TCallBack* = proc ()
  T3dArray* = Array[0..2, TGLdouble]
  T4pArray* = Array[0..3, Pointer]
  T4fArray* = Array[0..3, TGLfloat]
  PPointer* = ptr Pointer

type 
  GLUnurbs*{.final.} = object 
  PGLUnurbs* = ptr GLUnurbs
  GLUquadric*{.final.} = object 
  PGLUquadric* = ptr GLUquadric
  GLUtesselator*{.final.} = object 
  PGLUtesselator* = ptr GLUtesselator # backwards compatibility:
  GLUnurbsObj* = GLUnurbs
  PGLUnurbsObj* = PGLUnurbs
  GLUquadricObj* = GLUquadric
  PGLUquadricObj* = PGLUquadric
  GLUtesselatorObj* = GLUtesselator
  PGLUtesselatorObj* = PGLUtesselator
  GLUtriangulatorObj* = GLUtesselator
  PGLUtriangulatorObj* = PGLUtesselator
  TGLUnurbs* = GLUnurbs
  TGLUquadric* = GLUquadric
  TGLUtesselator* = GLUtesselator
  TGLUnurbsObj* = GLUnurbsObj
  TGLUquadricObj* = GLUquadricObj
  TGLUtesselatorObj* = GLUtesselatorObj
  TGLUtriangulatorObj* = GLUtriangulatorObj

proc gluErrorString*(errCode: TGLenum): Cstring{.dynlib: dllname, 
    importc: "gluErrorString".}
proc gluErrorUnicodeStringEXT*(errCode: TGLenum): ptr Int16{.dynlib: dllname, 
    importc: "gluErrorUnicodeStringEXT".}
proc gluGetString*(name: TGLenum): Cstring{.dynlib: dllname, 
    importc: "gluGetString".}
proc gluOrtho2D*(left, right, bottom, top: TGLdouble){.dynlib: dllname, 
    importc: "gluOrtho2D".}
proc gluPerspective*(fovy, aspect, zNear, zFar: TGLdouble){.dynlib: dllname, 
    importc: "gluPerspective".}
proc gluPickMatrix*(x, y, width, height: TGLdouble, viewport: var TViewPortArray){.
    dynlib: dllname, importc: "gluPickMatrix".}
proc gluLookAt*(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz: TGLdouble){.
    dynlib: dllname, importc: "gluLookAt".}
proc gluProject*(objx, objy, objz: TGLdouble, 
                 modelMatrix, projMatrix: var T16dArray, 
                 viewport: var TViewPortArray, winx, winy, winz: PGLdouble): Int{.
    dynlib: dllname, importc: "gluProject".}
proc gluUnProject*(winx, winy, winz: TGLdouble, 
                   modelMatrix, projMatrix: var T16dArray, 
                   viewport: var TViewPortArray, objx, objy, objz: PGLdouble): Int{.
    dynlib: dllname, importc: "gluUnProject".}
proc gluScaleImage*(format: TGLenum, widthin, heightin: TGLint, typein: TGLenum, 
                    datain: Pointer, widthout, heightout: TGLint, 
                    typeout: TGLenum, dataout: Pointer): Int{.dynlib: dllname, 
    importc: "gluScaleImage".}
proc gluBuild1DMipmaps*(target: TGLenum, components, width: TGLint, 
                        format, atype: TGLenum, data: Pointer): Int{.
    dynlib: dllname, importc: "gluBuild1DMipmaps".}
proc gluBuild2DMipmaps*(target: TGLenum, components, width, height: TGLint, 
                        format, atype: TGLenum, data: Pointer): Int{.
    dynlib: dllname, importc: "gluBuild2DMipmaps".}
proc gluNewQuadric*(): PGLUquadric{.dynlib: dllname, importc: "gluNewQuadric".}
proc gluDeleteQuadric*(state: PGLUquadric){.dynlib: dllname, 
    importc: "gluDeleteQuadric".}
proc gluQuadricNormals*(quadObject: PGLUquadric, normals: TGLenum){.
    dynlib: dllname, importc: "gluQuadricNormals".}
proc gluQuadricTexture*(quadObject: PGLUquadric, textureCoords: TGLboolean){.
    dynlib: dllname, importc: "gluQuadricTexture".}
proc gluQuadricOrientation*(quadObject: PGLUquadric, orientation: TGLenum){.
    dynlib: dllname, importc: "gluQuadricOrientation".}
proc gluQuadricDrawStyle*(quadObject: PGLUquadric, drawStyle: TGLenum){.
    dynlib: dllname, importc: "gluQuadricDrawStyle".}
proc gluCylinder*(qobj: PGLUquadric, baseRadius, topRadius, height: TGLdouble, 
                  slices, stacks: TGLint){.dynlib: dllname, 
    importc: "gluCylinder".}
proc gluDisk*(qobj: PGLUquadric, innerRadius, outerRadius: TGLdouble, 
              slices, loops: TGLint){.dynlib: dllname, importc: "gluDisk".}
proc gluPartialDisk*(qobj: PGLUquadric, innerRadius, outerRadius: TGLdouble, 
                     slices, loops: TGLint, startAngle, sweepAngle: TGLdouble){.
    dynlib: dllname, importc: "gluPartialDisk".}
proc gluSphere*(qobj: PGLUquadric, radius: TGLdouble, slices, stacks: TGLint){.
    dynlib: dllname, importc: "gluSphere".}
proc gluQuadricCallback*(qobj: PGLUquadric, which: TGLenum, fn: TCallBack){.
    dynlib: dllname, importc: "gluQuadricCallback".}
proc gluNewTess*(): PGLUtesselator{.dynlib: dllname, importc: "gluNewTess".}
proc gluDeleteTess*(tess: PGLUtesselator){.dynlib: dllname, 
    importc: "gluDeleteTess".}
proc gluTessBeginPolygon*(tess: PGLUtesselator, polygon_data: Pointer){.
    dynlib: dllname, importc: "gluTessBeginPolygon".}
proc gluTessBeginContour*(tess: PGLUtesselator){.dynlib: dllname, 
    importc: "gluTessBeginContour".}
proc gluTessVertex*(tess: PGLUtesselator, coords: var T3dArray, data: Pointer){.
    dynlib: dllname, importc: "gluTessVertex".}
proc gluTessEndContour*(tess: PGLUtesselator){.dynlib: dllname, 
    importc: "gluTessEndContour".}
proc gluTessEndPolygon*(tess: PGLUtesselator){.dynlib: dllname, 
    importc: "gluTessEndPolygon".}
proc gluTessProperty*(tess: PGLUtesselator, which: TGLenum, value: TGLdouble){.
    dynlib: dllname, importc: "gluTessProperty".}
proc gluTessNormal*(tess: PGLUtesselator, x, y, z: TGLdouble){.dynlib: dllname, 
    importc: "gluTessNormal".}
proc gluTessCallback*(tess: PGLUtesselator, which: TGLenum, fn: TCallBack){.
    dynlib: dllname, importc: "gluTessCallback".}
proc gluGetTessProperty*(tess: PGLUtesselator, which: TGLenum, value: PGLdouble){.
    dynlib: dllname, importc: "gluGetTessProperty".}
proc gluNewNurbsRenderer*(): PGLUnurbs{.dynlib: dllname, 
                                        importc: "gluNewNurbsRenderer".}
proc gluDeleteNurbsRenderer*(nobj: PGLUnurbs){.dynlib: dllname, 
    importc: "gluDeleteNurbsRenderer".}
proc gluBeginSurface*(nobj: PGLUnurbs){.dynlib: dllname, 
                                        importc: "gluBeginSurface".}
proc gluBeginCurve*(nobj: PGLUnurbs){.dynlib: dllname, importc: "gluBeginCurve".}
proc gluEndCurve*(nobj: PGLUnurbs){.dynlib: dllname, importc: "gluEndCurve".}
proc gluEndSurface*(nobj: PGLUnurbs){.dynlib: dllname, importc: "gluEndSurface".}
proc gluBeginTrim*(nobj: PGLUnurbs){.dynlib: dllname, importc: "gluBeginTrim".}
proc gluEndTrim*(nobj: PGLUnurbs){.dynlib: dllname, importc: "gluEndTrim".}
proc gluPwlCurve*(nobj: PGLUnurbs, count: TGLint, aarray: PGLfloat, 
                  stride: TGLint, atype: TGLenum){.dynlib: dllname, 
    importc: "gluPwlCurve".}
proc gluNurbsCurve*(nobj: PGLUnurbs, nknots: TGLint, knot: PGLfloat, 
                    stride: TGLint, ctlarray: PGLfloat, order: TGLint, 
                    atype: TGLenum){.dynlib: dllname, importc: "gluNurbsCurve".}
proc gluNurbsSurface*(nobj: PGLUnurbs, sknot_count: TGLint, sknot: PGLfloat, 
                      tknot_count: TGLint, tknot: PGLfloat, 
                      s_stride, t_stride: TGLint, ctlarray: PGLfloat, 
                      sorder, torder: TGLint, atype: TGLenum){.dynlib: dllname, 
    importc: "gluNurbsSurface".}
proc gluLoadSamplingMatrices*(nobj: PGLUnurbs, 
                              modelMatrix, projMatrix: var T16dArray, 
                              viewport: var TViewPortArray){.dynlib: dllname, 
    importc: "gluLoadSamplingMatrices".}
proc gluNurbsProperty*(nobj: PGLUnurbs, aproperty: TGLenum, value: TGLfloat){.
    dynlib: dllname, importc: "gluNurbsProperty".}
proc gluGetNurbsProperty*(nobj: PGLUnurbs, aproperty: TGLenum, value: PGLfloat){.
    dynlib: dllname, importc: "gluGetNurbsProperty".}
proc gluNurbsCallback*(nobj: PGLUnurbs, which: TGLenum, fn: TCallBack){.
    dynlib: dllname, importc: "gluNurbsCallback".}
  #*** Callback function prototypes ***
type                          # gluQuadricCallback
  GLUquadricErrorProc* = proc (p: TGLenum) # gluTessCallback
  GLUtessBeginProc* = proc (p: TGLenum)
  GLUtessEdgeFlagProc* = proc (p: TGLboolean)
  GLUtessVertexProc* = proc (p: Pointer)
  GLUtessEndProc* = proc ()
  GLUtessErrorProc* = proc (p: TGLenum)
  GLUtessCombineProc* = proc (p1: var T3dArray, p2: T4pArray, p3: T4fArray, 
                              p4: PPointer)
  GLUtessBeginDataProc* = proc (p1: TGLenum, p2: Pointer)
  GLUtessEdgeFlagDataProc* = proc (p1: TGLboolean, p2: Pointer)
  GLUtessVertexDataProc* = proc (p1, p2: Pointer)
  GLUtessEndDataProc* = proc (p: Pointer)
  GLUtessErrorDataProc* = proc (p1: TGLenum, p2: Pointer)
  GLUtessCombineDataProc* = proc (p1: var T3dArray, p2: var T4pArray, 
                                  p3: var T4fArray, p4: PPointer, p5: Pointer) # 
                                                                               # 
                                                                               # gluNurbsCallback
  GLUnurbsErrorProc* = proc (p: TGLenum) #***           Generic constants               ****/

const                         # Version
  GluVersion11* = 1
  GluVersion12* = 1        # Errors: (return value 0 = no error)
  GluInvalidEnum* = 100900
  GluInvalidValue* = 100901
  GluOutOfMemory* = 100902
  GluIncompatibleGlVersion* = 100903 # StringName
  GluVersion* = 100800
  GluExtensions* = 100801    # Boolean
  GluTrue* = GL_TRUE
  GluFalse* = GL_FALSE #***           Quadric constants               ****/
                        # QuadricNormal
  GluSmooth* = 100000
  GluFlat* = 100001
  GluNone* = 100002          # QuadricDrawStyle
  GluPoint* = 100010
  GluLine* = 100011
  GluFill* = 100012
  GluSilhouette* = 100013    # QuadricOrientation
  GluOutside* = 100020
  GluInside* = 100021        # Callback types:
                              #      GLU_ERROR       = 100103;
                              #***           Tesselation constants           ****/
  GluTessMaxCoord* = 1.00000e+150 # TessProperty
  GluTessWindingRule* = 100140
  GluTessBoundaryOnly* = 100141
  GluTessTolerance* = 100142 # TessWinding
  GluTessWindingOdd* = 100130
  GluTessWindingNonzero* = 100131
  GluTessWindingPositive* = 100132
  GluTessWindingNegative* = 100133
  GluTessWindingAbsGeqTwo* = 100134 # TessCallback
  GluTessBegin* = 100100    # void (CALLBACK*)(TGLenum    type)
  constGLUTESSVERTEX* = 100101 # void (CALLBACK*)(void      *data)
  GluTessEnd* = 100102      # void (CALLBACK*)(void)
  GluTessError* = 100103    # void (CALLBACK*)(TGLenum    errno)
  GluTessEdgeFlag* = 100104 # void (CALLBACK*)(TGLboolean boundaryEdge)
  GluTessCombine* = 100105 # void (CALLBACK*)(TGLdouble  coords[3],
                             #                                                            void      *data[4],
                             #                                                            TGLfloat   weight[4],
                             #                                                            void      **dataOut) 
  GluTessBeginData* = 100106 # void (CALLBACK*)(TGLenum    type,
                                #                                                            void      *polygon_data) 
  GluTessVertexData* = 100107 # void (CALLBACK*)(void      *data,
                                 #                                                            void      *polygon_data) 
  GluTessEndData* = 100108 # void (CALLBACK*)(void      *polygon_data)
  GluTessErrorData* = 100109 # void (CALLBACK*)(TGLenum    errno,
                                #                                                            void      *polygon_data) 
  GluTessEdgeFlagData* = 100110 # void (CALLBACK*)(TGLboolean boundaryEdge,
                                    #                                                            void      *polygon_data) 
  GluTessCombineData* = 100111 # void (CALLBACK*)(TGLdouble  coords[3],
                                  #                                                            void      *data[4],
                                  #                                                            TGLfloat   weight[4],
                                  #                                                            void      **dataOut,
                                  #                                                            void      *polygon_data) 
                                  # TessError
  GluTessError1* = 100151
  GluTessError2* = 100152
  GluTessError3* = 100153
  GluTessError4* = 100154
  GluTessError5* = 100155
  GluTessError6* = 100156
  GluTessError7* = 100157
  GluTessError8* = 100158
  GluTessMissingBeginPolygon* = GLU_TESS_ERROR1
  GluTessMissingBeginContour* = GLU_TESS_ERROR2
  GluTessMissingEndPolygon* = GLU_TESS_ERROR3
  GluTessMissingEndContour* = GLU_TESS_ERROR4
  GluTessCoordTooLarge* = GLU_TESS_ERROR5
  GluTessNeedCombineCallback* = GLU_TESS_ERROR6 #***           NURBS constants                 ****/
                                                    # NurbsProperty
  GluAutoLoadMatrix* = 100200
  GluCulling* = 100201
  GluSamplingTolerance* = 100203
  GluDisplayMode* = 100204
  GluParametricTolerance* = 100202
  GluSamplingMethod* = 100205
  GluUStep* = 100206
  GluVStep* = 100207        # NurbsSampling
  GluPathLength* = 100215
  GluParametricError* = 100216
  GluDomainDistance* = 100217 # NurbsTrim
  GluMap1Trim2* = 100210
  GluMap1Trim3* = 100211   # NurbsDisplay
                              #      GLU_FILL                = 100012;
  GluOutlinePolygon* = 100240
  GluOutlinePatch* = 100241 # NurbsCallback
                              #      GLU_ERROR               = 100103;
                              # NurbsErrors
  GluNurbsError1* = 100251
  GluNurbsError2* = 100252
  GluNurbsError3* = 100253
  GluNurbsError4* = 100254
  GluNurbsError5* = 100255
  GluNurbsError6* = 100256
  GluNurbsError7* = 100257
  GluNurbsError8* = 100258
  GluNurbsError9* = 100259
  GluNurbsError10* = 100260
  GluNurbsError11* = 100261
  GluNurbsError12* = 100262
  GluNurbsError13* = 100263
  GluNurbsError14* = 100264
  GluNurbsError15* = 100265
  GluNurbsError16* = 100266
  GluNurbsError17* = 100267
  GluNurbsError18* = 100268
  GluNurbsError19* = 100269
  GluNurbsError20* = 100270
  GluNurbsError21* = 100271
  GluNurbsError22* = 100272
  GluNurbsError23* = 100273
  GluNurbsError24* = 100274
  GluNurbsError25* = 100275
  GluNurbsError26* = 100276
  GluNurbsError27* = 100277
  GluNurbsError28* = 100278
  GluNurbsError29* = 100279
  GluNurbsError30* = 100280
  GluNurbsError31* = 100281
  GluNurbsError32* = 100282
  GluNurbsError33* = 100283
  GluNurbsError34* = 100284
  GluNurbsError35* = 100285
  GluNurbsError36* = 100286
  GluNurbsError37* = 100287 #***           Backwards compatibility for old tesselator           ****/

proc gluBeginPolygon*(tess: PGLUtesselator){.dynlib: dllname, 
    importc: "gluBeginPolygon".}
proc gluNextContour*(tess: PGLUtesselator, atype: TGLenum){.dynlib: dllname, 
    importc: "gluNextContour".}
proc gluEndPolygon*(tess: PGLUtesselator){.dynlib: dllname, 
    importc: "gluEndPolygon".}
const                         # Contours types -- obsolete!
  GluCw* = 100120
  GluCcw* = 100121
  GluInterior* = 100122
  GluExterior* = 100123
  GluUnknown* = 100124       # Names without "TESS_" prefix
  GluBegin* = GLU_TESS_BEGIN
  GluVertex* = constGLU_TESS_VERTEX
  GluEnd* = GLU_TESS_END
  GluError* = GLU_TESS_ERROR
  GluEdgeFlag* = GLU_TESS_EDGE_FLAG

{.pop.}
# implementation
