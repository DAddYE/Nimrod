#
#
#  Adaption of the delphi3d.net OpenGL units to FreePascal
#  Sebastian Guenther (sg@freepascal.org) in 2002
#  These units are free to use
#
#******************************************************************************
# Converted to Delphi by Tom Nuydens (tom@delphi3d.net)                        
# For the latest updates, visit Delphi3D: http://www.delphi3d.net              
#******************************************************************************

when defined(windows): 
  {.push, callconv: stdcall.}
else: 
  {.push, callconv: cdecl.}
when defined(windows): 
  const 
    dllname* = "opengl32.dll"
elif defined(macosx): 
  const 
    dllname* = "/System/Library/Frameworks/OpenGL.framework/Libraries/libGL.dylib"
else: 
  const 
    dllname* = "libGL.so.1"
type 
  PGLenum* = ptr TGLenum
  PGLboolean* = ptr TGLboolean
  PGLbitfield* = ptr TGLbitfield
  TGLbyte* = Int8
  PGLbyte* = ptr TGlbyte
  PGLshort* = ptr TGLshort
  PGLint* = ptr TGLint
  PGLsizei* = ptr TGLsizei
  PGLubyte* = ptr TGLubyte
  PGLushort* = ptr TGLushort
  PGLuint* = ptr TGLuint
  PGLfloat* = ptr TGLfloat
  PGLclampf* = ptr TGLclampf
  PGLdouble* = ptr TGLdouble
  PGLclampd* = ptr TGLclampd
  PGLvoid* = Pointer
  PPGLvoid* = ptr PGLvoid
  TGLenum* = Cint
  TGLboolean* = Bool
  TGLbitfield* = Cint
  TGLshort* = Int16
  TGLint* = Cint
  TGLsizei* = Int
  TGLubyte* = Int8
  TGLushort* = Int16
  TGLuint* = Cint
  TGLfloat* = Float32
  TGLclampf* = Float32
  TGLdouble* = Float
  TGLclampd* = Float

const                         # Version
  GlVersion11* = 1         # AccumOp
  constGLACCUM* = 0x00000100
  GlLoad* = 0x00000101
  GlReturn* = 0x00000102
  GlMult* = 0x00000103
  GlAdd* = 0x00000104        # AlphaFunction
  GlNever* = 0x00000200
  GlLess* = 0x00000201
  GlEqual* = 0x00000202
  GlLequal* = 0x00000203
  GlGreater* = 0x00000204
  GlNotequal* = 0x00000205
  GlGequal* = 0x00000206
  GlAlways* = 0x00000207     # AttribMask
  GlCurrentBit* = 0x00000001
  GlPointBit* = 0x00000002
  GlLineBit* = 0x00000004
  GlPolygonBit* = 0x00000008
  GlPolygonStippleBit* = 0x00000010
  GlPixelModeBit* = 0x00000020
  GlLightingBit* = 0x00000040
  GlFogBit* = 0x00000080
  GlDepthBufferBit* = 0x00000100
  GlAccumBufferBit* = 0x00000200
  GlStencilBufferBit* = 0x00000400
  GlViewportBit* = 0x00000800
  GlTransformBit* = 0x00001000
  GlEnableBit* = 0x00002000
  GlColorBufferBit* = 0x00004000
  GlHintBit* = 0x00008000
  GlEvalBit* = 0x00010000
  GlListBit* = 0x00020000
  GlTextureBit* = 0x00040000
  GlScissorBit* = 0x00080000
  GlAllAttribBits* = 0x000FFFFF # BeginMode
  GlPoints* = 0x00000000
  GlLines* = 0x00000001
  GlLineLoop* = 0x00000002
  GlLineStrip* = 0x00000003
  GlTriangles* = 0x00000004
  GlTriangleStrip* = 0x00000005
  GlTriangleFan* = 0x00000006
  GlQuads* = 0x00000007
  GlQuadStrip* = 0x00000008
  GlPolygon* = 0x00000009    # BlendingFactorDest
  GlZero* = 0
  GlOne* = 1
  GlSrcColor* = 0x00000300
  GlOneMinusSrcColor* = 0x00000301
  GlSrcAlpha* = 0x00000302
  GlOneMinusSrcAlpha* = 0x00000303
  GlDstAlpha* = 0x00000304
  GlOneMinusDstAlpha* = 0x00000305 # BlendingFactorSrc
                                       #      GL_ZERO
                                       #      GL_ONE
  GlDstColor* = 0x00000306
  GlOneMinusDstColor* = 0x00000307
  GlSrcAlphaSaturate* = 0x00000308 #      GL_SRC_ALPHA
                                      #      GL_ONE_MINUS_SRC_ALPHA
                                      #      GL_DST_ALPHA
                                      #      GL_ONE_MINUS_DST_ALPHA
                                      # Boolean
  GlTrue* = 1
  GlFalse* = 0               # ClearBufferMask
                              #      GL_COLOR_BUFFER_BIT
                              #      GL_ACCUM_BUFFER_BIT
                              #      GL_STENCIL_BUFFER_BIT
                              #      GL_DEPTH_BUFFER_BIT
                              # ClientArrayType
                              #      GL_VERTEX_ARRAY
                              #      GL_NORMAL_ARRAY
                              #      GL_COLOR_ARRAY
                              #      GL_INDEX_ARRAY
                              #      GL_TEXTURE_COORD_ARRAY
                              #      GL_EDGE_FLAG_ARRAY
                              # ClipPlaneName
  GlClipPlane0* = 0x00003000
  GlClipPlane1* = 0x00003001
  GlClipPlane2* = 0x00003002
  GlClipPlane3* = 0x00003003
  GlClipPlane4* = 0x00003004
  GlClipPlane5* = 0x00003005 # ColorMaterialFace
                               #      GL_FRONT
                               #      GL_BACK
                               #      GL_FRONT_AND_BACK
                               # ColorMaterialParameter
                               #      GL_AMBIENT
                               #      GL_DIFFUSE
                               #      GL_SPECULAR
                               #      GL_EMISSION
                               #      GL_AMBIENT_AND_DIFFUSE
                               # ColorPointerType
                               #      GL_BYTE
                               #      GL_UNSIGNED_BYTE
                               #      GL_SHORT
                               #      GL_UNSIGNED_SHORT
                               #      GL_INT
                               #      GL_UNSIGNED_INT
                               #      GL_FLOAT
                               #      GL_DOUBLE
                               # CullFaceMode
                               #      GL_FRONT
                               #      GL_BACK
                               #      GL_FRONT_AND_BACK
                               # DataType
  GlByte* = 0x00001400
  GlUnsignedByte* = 0x00001401
  GlShort* = 0x00001402
  GlUnsignedShort* = 0x00001403
  GlInt* = 0x00001404
  GlUnsignedInt* = 0x00001405
  GlFloat* = 0x00001406
  Gl2Bytes* = 0x00001407
  Gl3Bytes* = 0x00001408
  Gl4Bytes* = 0x00001409
  GlDouble* = 0x0000140A     # DepthFunction
                              #      GL_NEVER
                              #      GL_LESS
                              #      GL_EQUAL
                              #      GL_LEQUAL
                              #      GL_GREATER
                              #      GL_NOTEQUAL
                              #      GL_GEQUAL
                              #      GL_ALWAYS
                              # DrawBufferMode
  GlNone* = 0
  GlFrontLeft* = 0x00000400
  GlFrontRight* = 0x00000401
  GlBackLeft* = 0x00000402
  GlBackRight* = 0x00000403
  GlFront* = 0x00000404
  GlBack* = 0x00000405
  GlLeft* = 0x00000406
  GlRight* = 0x00000407
  GlFrontAndBack* = 0x00000408
  GlAux0* = 0x00000409
  GlAux1* = 0x0000040A
  GlAux2* = 0x0000040B
  GlAux3* = 0x0000040C       # Enable
                              #      GL_FOG
                              #      GL_LIGHTING
                              #      GL_TEXTURE_1D
                              #      GL_TEXTURE_2D
                              #      GL_LINE_STIPPLE
                              #      GL_POLYGON_STIPPLE
                              #      GL_CULL_FACE
                              #      GL_ALPHA_TEST
                              #      GL_BLEND
                              #      GL_INDEX_LOGIC_OP
                              #      GL_COLOR_LOGIC_OP
                              #      GL_DITHER
                              #      GL_STENCIL_TEST
                              #      GL_DEPTH_TEST
                              #      GL_CLIP_PLANE0
                              #      GL_CLIP_PLANE1
                              #      GL_CLIP_PLANE2
                              #      GL_CLIP_PLANE3
                              #      GL_CLIP_PLANE4
                              #      GL_CLIP_PLANE5
                              #      GL_LIGHT0
                              #      GL_LIGHT1
                              #      GL_LIGHT2
                              #      GL_LIGHT3
                              #      GL_LIGHT4
                              #      GL_LIGHT5
                              #      GL_LIGHT6
                              #      GL_LIGHT7
                              #      GL_TEXTURE_GEN_S
                              #      GL_TEXTURE_GEN_T
                              #      GL_TEXTURE_GEN_R
                              #      GL_TEXTURE_GEN_Q
                              #      GL_MAP1_VERTEX_3
                              #      GL_MAP1_VERTEX_4
                              #      GL_MAP1_COLOR_4
                              #      GL_MAP1_INDEX
                              #      GL_MAP1_NORMAL
                              #      GL_MAP1_TEXTURE_COORD_1
                              #      GL_MAP1_TEXTURE_COORD_2
                              #      GL_MAP1_TEXTURE_COORD_3
                              #      GL_MAP1_TEXTURE_COORD_4
                              #      GL_MAP2_VERTEX_3
                              #      GL_MAP2_VERTEX_4
                              #      GL_MAP2_COLOR_4
                              #      GL_MAP2_INDEX
                              #      GL_MAP2_NORMAL
                              #      GL_MAP2_TEXTURE_COORD_1
                              #      GL_MAP2_TEXTURE_COORD_2
                              #      GL_MAP2_TEXTURE_COORD_3
                              #      GL_MAP2_TEXTURE_COORD_4
                              #      GL_POINT_SMOOTH
                              #      GL_LINE_SMOOTH
                              #      GL_POLYGON_SMOOTH
                              #      GL_SCISSOR_TEST
                              #      GL_COLOR_MATERIAL
                              #      GL_NORMALIZE
                              #      GL_AUTO_NORMAL
                              #      GL_VERTEX_ARRAY
                              #      GL_NORMAL_ARRAY
                              #      GL_COLOR_ARRAY
                              #      GL_INDEX_ARRAY
                              #      GL_TEXTURE_COORD_ARRAY
                              #      GL_EDGE_FLAG_ARRAY
                              #      GL_POLYGON_OFFSET_POINT
                              #      GL_POLYGON_OFFSET_LINE
                              #      GL_POLYGON_OFFSET_FILL
                              # ErrorCode
  GlNoError* = 0
  GlInvalidEnum* = 0x00000500
  GlInvalidValue* = 0x00000501
  GlInvalidOperation* = 0x00000502
  GlStackOverflow* = 0x00000503
  GlStackUnderflow* = 0x00000504
  GlOutOfMemory* = 0x00000505 # FeedBackMode
  Gl2d* = 0x00000600
  Gl3d* = 0x00000601
  Gl3dColor* = 0x00000602
  Gl3dColorTexture* = 0x00000603
  Gl4dColorTexture* = 0x00000604 # FeedBackToken
  GlPassThroughToken* = 0x00000700
  GlPointToken* = 0x00000701
  GlLineToken* = 0x00000702
  GlPolygonToken* = 0x00000703
  GlBitmapToken* = 0x00000704
  GlDrawPixelToken* = 0x00000705
  GlCopyPixelToken* = 0x00000706
  GlLineResetToken* = 0x00000707 # FogMode
                                    #      GL_LINEAR
  GlExp* = 0x00000800
  GlExp2* = 0x00000801       # FogParameter
                              #      GL_FOG_COLOR
                              #      GL_FOG_DENSITY
                              #      GL_FOG_END
                              #      GL_FOG_INDEX
                              #      GL_FOG_MODE
                              #      GL_FOG_START
                              # FrontFaceDirection
  GlCw* = 0x00000900
  GlCcw* = 0x00000901        # GetMapTarget
  GlCoeff* = 0x00000A00
  GlOrder* = 0x00000A01
  GlDomain* = 0x00000A02     # GetPixelMap
                              #      GL_PIXEL_MAP_I_TO_I
                              #      GL_PIXEL_MAP_S_TO_S
                              #      GL_PIXEL_MAP_I_TO_R
                              #      GL_PIXEL_MAP_I_TO_G
                              #      GL_PIXEL_MAP_I_TO_B
                              #      GL_PIXEL_MAP_I_TO_A
                              #      GL_PIXEL_MAP_R_TO_R
                              #      GL_PIXEL_MAP_G_TO_G
                              #      GL_PIXEL_MAP_B_TO_B
                              #      GL_PIXEL_MAP_A_TO_A
                              # GetPointerTarget
                              #      GL_VERTEX_ARRAY_POINTER
                              #      GL_NORMAL_ARRAY_POINTER
                              #      GL_COLOR_ARRAY_POINTER
                              #      GL_INDEX_ARRAY_POINTER
                              #      GL_TEXTURE_COORD_ARRAY_POINTER
                              #      GL_EDGE_FLAG_ARRAY_POINTER
                              # GetTarget
  GlCurrentColor* = 0x00000B00
  GlCurrentIndex* = 0x00000B01
  GlCurrentNormal* = 0x00000B02
  GlCurrentTextureCoords* = 0x00000B03
  GlCurrentRasterColor* = 0x00000B04
  GlCurrentRasterIndex* = 0x00000B05
  GlCurrentRasterTextureCoords* = 0x00000B06
  GlCurrentRasterPosition* = 0x00000B07
  GlCurrentRasterPositionValid* = 0x00000B08
  GlCurrentRasterDistance* = 0x00000B09
  GlPointSmooth* = 0x00000B10
  constGLPOINTSIZE* = 0x00000B11
  GlPointSizeRange* = 0x00000B12
  GlPointSizeGranularity* = 0x00000B13
  GlLineSmooth* = 0x00000B20
  constGLLINEWIDTH* = 0x00000B21
  GlLineWidthRange* = 0x00000B22
  GlLineWidthGranularity* = 0x00000B23
  constGLLINESTIPPLE* = 0x00000B24
  GlLineStipplePattern* = 0x00000B25
  GlLineStippleRepeat* = 0x00000B26
  GlListMode* = 0x00000B30
  GlMaxListNesting* = 0x00000B31
  constGLLISTBASE* = 0x00000B32
  GlListIndex* = 0x00000B33
  constGLPOLYGONMODE* = 0x00000B40
  GlPolygonSmooth* = 0x00000B41
  constGLPOLYGONSTIPPLE* = 0x00000B42
  constGLEDGEFLAG* = 0x00000B43
  constGLCULLFACE* = 0x00000B44
  GlCullFaceMode* = 0x00000B45
  constGLFRONTFACE* = 0x00000B46
  GlLighting* = 0x00000B50
  GlLightModelLocalViewer* = 0x00000B51
  GlLightModelTwoSide* = 0x00000B52
  GlLightModelAmbient* = 0x00000B53
  constGLSHADEMODEL* = 0x00000B54
  GlColorMaterialFace* = 0x00000B55
  GlColorMaterialParameter* = 0x00000B56
  constGLCOLORMATERIAL* = 0x00000B57
  GlFog* = 0x00000B60
  GlFogIndex* = 0x00000B61
  GlFogDensity* = 0x00000B62
  GlFogStart* = 0x00000B63
  GlFogEnd* = 0x00000B64
  GlFogMode* = 0x00000B65
  GlFogColor* = 0x00000B66
  constGLDEPTHRANGE* = 0x00000B70
  GlDepthTest* = 0x00000B71
  GlDepthWritemask* = 0x00000B72
  GlDepthClearValue* = 0x00000B73
  constGLDEPTHFUNC* = 0x00000B74
  GlAccumClearValue* = 0x00000B80
  GlStencilTest* = 0x00000B90
  GlStencilClearValue* = 0x00000B91
  constGLSTENCILFUNC* = 0x00000B92
  GlStencilValueMask* = 0x00000B93
  GlStencilFail* = 0x00000B94
  GlStencilPassDepthFail* = 0x00000B95
  GlStencilPassDepthPass* = 0x00000B96
  GlStencilRef* = 0x00000B97
  GlStencilWritemask* = 0x00000B98
  constGLMATRIXMODE* = 0x00000BA0
  GlNormalize* = 0x00000BA1
  constGLVIEWPORT* = 0x00000BA2
  GlModelviewStackDepth* = 0x00000BA3
  GlProjectionStackDepth* = 0x00000BA4
  GlTextureStackDepth* = 0x00000BA5
  GlModelviewMatrix* = 0x00000BA6
  GlProjectionMatrix* = 0x00000BA7
  GlTextureMatrix* = 0x00000BA8
  GlAttribStackDepth* = 0x00000BB0
  GlClientAttribStackDepth* = 0x00000BB1
  GlAlphaTest* = 0x00000BC0
  GlAlphaTestFunc* = 0x00000BC1
  GlAlphaTestRef* = 0x00000BC2
  GlDither* = 0x00000BD0
  GlBlendDst* = 0x00000BE0
  GlBlendSrc* = 0x00000BE1
  GlBlend* = 0x00000BE2
  GlLogicOpMode* = 0x00000BF0
  GlIndexLogicOp* = 0x00000BF1
  GlColorLogicOp* = 0x00000BF2
  GlAuxBuffers* = 0x00000C00
  constGLDRAWBUFFER* = 0x00000C01
  constGLREADBUFFER* = 0x00000C02
  GlScissorBox* = 0x00000C10
  GlScissorTest* = 0x00000C11
  GlIndexClearValue* = 0x00000C20
  GlIndexWritemask* = 0x00000C21
  GlColorClearValue* = 0x00000C22
  GlColorWritemask* = 0x00000C23
  GlIndexMode* = 0x00000C30
  GlRgbaMode* = 0x00000C31
  GlDoublebuffer* = 0x00000C32
  GlStereo* = 0x00000C33
  constGLRENDERMODE* = 0x00000C40
  GlPerspectiveCorrectionHint* = 0x00000C50
  GlPointSmoothHint* = 0x00000C51
  GlLineSmoothHint* = 0x00000C52
  GlPolygonSmoothHint* = 0x00000C53
  GlFogHint* = 0x00000C54
  GlTextureGenS* = 0x00000C60
  GlTextureGenT* = 0x00000C61
  GlTextureGenR* = 0x00000C62
  GlTextureGenQ* = 0x00000C63
  GlPixelMapIToI* = 0x00000C70
  GlPixelMapSToS* = 0x00000C71
  GlPixelMapIToR* = 0x00000C72
  GlPixelMapIToG* = 0x00000C73
  GlPixelMapIToB* = 0x00000C74
  GlPixelMapIToA* = 0x00000C75
  GlPixelMapRToR* = 0x00000C76
  GlPixelMapGToG* = 0x00000C77
  GlPixelMapBToB* = 0x00000C78
  GlPixelMapAToA* = 0x00000C79
  GlPixelMapIToISize* = 0x00000CB0
  GlPixelMapSToSSize* = 0x00000CB1
  GlPixelMapIToRSize* = 0x00000CB2
  GlPixelMapIToGSize* = 0x00000CB3
  GlPixelMapIToBSize* = 0x00000CB4
  GlPixelMapIToASize* = 0x00000CB5
  GlPixelMapRToRSize* = 0x00000CB6
  GlPixelMapGToGSize* = 0x00000CB7
  GlPixelMapBToBSize* = 0x00000CB8
  GlPixelMapAToASize* = 0x00000CB9
  GlUnpackSwapBytes* = 0x00000CF0
  GlUnpackLsbFirst* = 0x00000CF1
  GlUnpackRowLength* = 0x00000CF2
  GlUnpackSkipRows* = 0x00000CF3
  GlUnpackSkipPixels* = 0x00000CF4
  GlUnpackAlignment* = 0x00000CF5
  GlPackSwapBytes* = 0x00000D00
  GlPackLsbFirst* = 0x00000D01
  GlPackRowLength* = 0x00000D02
  GlPackSkipRows* = 0x00000D03
  GlPackSkipPixels* = 0x00000D04
  GlPackAlignment* = 0x00000D05
  GlMapColor* = 0x00000D10
  GlMapStencil* = 0x00000D11
  GlIndexShift* = 0x00000D12
  GlIndexOffset* = 0x00000D13
  GlRedScale* = 0x00000D14
  GlRedBias* = 0x00000D15
  GlZoomX* = 0x00000D16
  GlZoomY* = 0x00000D17
  GlGreenScale* = 0x00000D18
  GlGreenBias* = 0x00000D19
  GlBlueScale* = 0x00000D1A
  GlBlueBias* = 0x00000D1B
  GlAlphaScale* = 0x00000D1C
  GlAlphaBias* = 0x00000D1D
  GlDepthScale* = 0x00000D1E
  GlDepthBias* = 0x00000D1F
  GlMaxEvalOrder* = 0x00000D30
  GlMaxLights* = 0x00000D31
  GlMaxClipPlanes* = 0x00000D32
  GlMaxTextureSize* = 0x00000D33
  GlMaxPixelMapTable* = 0x00000D34
  GlMaxAttribStackDepth* = 0x00000D35
  GlMaxModelviewStackDepth* = 0x00000D36
  GlMaxNameStackDepth* = 0x00000D37
  GlMaxProjectionStackDepth* = 0x00000D38
  GlMaxTextureStackDepth* = 0x00000D39
  GlMaxViewportDims* = 0x00000D3A
  GlMaxClientAttribStackDepth* = 0x00000D3B
  GlSubpixelBits* = 0x00000D50
  GlIndexBits* = 0x00000D51
  GlRedBits* = 0x00000D52
  GlGreenBits* = 0x00000D53
  GlBlueBits* = 0x00000D54
  GlAlphaBits* = 0x00000D55
  GlDepthBits* = 0x00000D56
  GlStencilBits* = 0x00000D57
  GlAccumRedBits* = 0x00000D58
  GlAccumGreenBits* = 0x00000D59
  GlAccumBlueBits* = 0x00000D5A
  GlAccumAlphaBits* = 0x00000D5B
  GlNameStackDepth* = 0x00000D70
  GlAutoNormal* = 0x00000D80
  GlMap1Color4* = 0x00000D90
  GlMap1Index* = 0x00000D91
  GlMap1Normal* = 0x00000D92
  GlMap1TextureCoord1* = 0x00000D93
  GlMap1TextureCoord2* = 0x00000D94
  GlMap1TextureCoord3* = 0x00000D95
  GlMap1TextureCoord4* = 0x00000D96
  GlMap1Vertex3* = 0x00000D97
  GlMap1Vertex4* = 0x00000D98
  GlMap2Color4* = 0x00000DB0
  GlMap2Index* = 0x00000DB1
  GlMap2Normal* = 0x00000DB2
  GlMap2TextureCoord1* = 0x00000DB3
  GlMap2TextureCoord2* = 0x00000DB4
  GlMap2TextureCoord3* = 0x00000DB5
  GlMap2TextureCoord4* = 0x00000DB6
  GlMap2Vertex3* = 0x00000DB7
  GlMap2Vertex4* = 0x00000DB8
  GlMap1GridDomain* = 0x00000DD0
  GlMap1GridSegments* = 0x00000DD1
  GlMap2GridDomain* = 0x00000DD2
  GlMap2GridSegments* = 0x00000DD3
  GlTexture1d* = 0x00000DE0
  GlTexture2d* = 0x00000DE1
  GlFeedbackBufferPointer* = 0x00000DF0
  GlFeedbackBufferSize* = 0x00000DF1
  GlFeedbackBufferType* = 0x00000DF2
  GlSelectionBufferPointer* = 0x00000DF3
  GlSelectionBufferSize* = 0x00000DF4 #      GL_TEXTURE_BINDING_1D
                                         #      GL_TEXTURE_BINDING_2D
                                         #      GL_VERTEX_ARRAY
                                         #      GL_NORMAL_ARRAY
                                         #      GL_COLOR_ARRAY
                                         #      GL_INDEX_ARRAY
                                         #      GL_TEXTURE_COORD_ARRAY
                                         #      GL_EDGE_FLAG_ARRAY
                                         #      GL_VERTEX_ARRAY_SIZE
                                         #      GL_VERTEX_ARRAY_TYPE
                                         #      GL_VERTEX_ARRAY_STRIDE
                                         #      GL_NORMAL_ARRAY_TYPE
                                         #      GL_NORMAL_ARRAY_STRIDE
                                         #      GL_COLOR_ARRAY_SIZE
                                         #      GL_COLOR_ARRAY_TYPE
                                         #      GL_COLOR_ARRAY_STRIDE
                                         #      GL_INDEX_ARRAY_TYPE
                                         #      GL_INDEX_ARRAY_STRIDE
                                         #      GL_TEXTURE_COORD_ARRAY_SIZE
                                         #      GL_TEXTURE_COORD_ARRAY_TYPE
                                         #      GL_TEXTURE_COORD_ARRAY_STRIDE
                                         #      GL_EDGE_FLAG_ARRAY_STRIDE
                                         #      GL_POLYGON_OFFSET_FACTOR
                                         #      GL_POLYGON_OFFSET_UNITS
                                         # GetTextureParameter
                                         #      GL_TEXTURE_MAG_FILTER
                                         #      GL_TEXTURE_MIN_FILTER
                                         #      GL_TEXTURE_WRAP_S
                                         #      GL_TEXTURE_WRAP_T
  GlTextureWidth* = 0x00001000
  GlTextureHeight* = 0x00001001
  GlTextureInternalFormat* = 0x00001003
  GlTextureBorderColor* = 0x00001004
  GlTextureBorder* = 0x00001005 #      GL_TEXTURE_RED_SIZE
                                  #      GL_TEXTURE_GREEN_SIZE
                                  #      GL_TEXTURE_BLUE_SIZE
                                  #      GL_TEXTURE_ALPHA_SIZE
                                  #      GL_TEXTURE_LUMINANCE_SIZE
                                  #      GL_TEXTURE_INTENSITY_SIZE
                                  #      GL_TEXTURE_PRIORITY
                                  #      GL_TEXTURE_RESIDENT
                                  # HintMode
  GlDontCare* = 0x00001100
  GlFastest* = 0x00001101
  GlNicest* = 0x00001102     # HintTarget
                              #      GL_PERSPECTIVE_CORRECTION_HINT
                              #      GL_POINT_SMOOTH_HINT
                              #      GL_LINE_SMOOTH_HINT
                              #      GL_POLYGON_SMOOTH_HINT
                              #      GL_FOG_HINT
                              # IndexPointerType
                              #      GL_SHORT
                              #      GL_INT
                              #      GL_FLOAT
                              #      GL_DOUBLE
                              # LightModelParameter
                              #      GL_LIGHT_MODEL_AMBIENT
                              #      GL_LIGHT_MODEL_LOCAL_VIEWER
                              #      GL_LIGHT_MODEL_TWO_SIDE
                              # LightName
  GlLight0* = 0x00004000
  GlLight1* = 0x00004001
  GlLight2* = 0x00004002
  GlLight3* = 0x00004003
  GlLight4* = 0x00004004
  GlLight5* = 0x00004005
  GlLight6* = 0x00004006
  GlLight7* = 0x00004007     # LightParameter
  GlAmbient* = 0x00001200
  GlDiffuse* = 0x00001201
  GlSpecular* = 0x00001202
  GlPosition* = 0x00001203
  GlSpotDirection* = 0x00001204
  GlSpotExponent* = 0x00001205
  GlSpotCutoff* = 0x00001206
  GlConstantAttenuation* = 0x00001207
  GlLinearAttenuation* = 0x00001208
  GlQuadraticAttenuation* = 0x00001209 # InterleavedArrays
                                         #      GL_V2F
                                         #      GL_V3F
                                         #      GL_C4UB_V2F
                                         #      GL_C4UB_V3F
                                         #      GL_C3F_V3F
                                         #      GL_N3F_V3F
                                         #      GL_C4F_N3F_V3F
                                         #      GL_T2F_V3F
                                         #      GL_T4F_V4F
                                         #      GL_T2F_C4UB_V3F
                                         #      GL_T2F_C3F_V3F
                                         #      GL_T2F_N3F_V3F
                                         #      GL_T2F_C4F_N3F_V3F
                                         #      GL_T4F_C4F_N3F_V4F
                                         # ListMode
  GlCompile* = 0x00001300
  GlCompileAndExecute* = 0x00001301 # ListNameType
                                       #      GL_BYTE
                                       #      GL_UNSIGNED_BYTE
                                       #      GL_SHORT
                                       #      GL_UNSIGNED_SHORT
                                       #      GL_INT
                                       #      GL_UNSIGNED_INT
                                       #      GL_FLOAT
                                       #      GL_2_BYTES
                                       #      GL_3_BYTES
                                       #      GL_4_BYTES
                                       # LogicOp
  constGLCLEAR* = 0x00001500
  GlAnd* = 0x00001501
  GlAndReverse* = 0x00001502
  GlCopy* = 0x00001503
  GlAndInverted* = 0x00001504
  GlNoop* = 0x00001505
  GlXor* = 0x00001506
  GlOr* = 0x00001507
  GlNor* = 0x00001508
  GlEquiv* = 0x00001509
  GlInvert* = 0x0000150A
  GlOrReverse* = 0x0000150B
  GlCopyInverted* = 0x0000150C
  GlOrInverted* = 0x0000150D
  GlNand* = 0x0000150E
  GlSet* = 0x0000150F        # MapTarget
                              #      GL_MAP1_COLOR_4
                              #      GL_MAP1_INDEX
                              #      GL_MAP1_NORMAL
                              #      GL_MAP1_TEXTURE_COORD_1
                              #      GL_MAP1_TEXTURE_COORD_2
                              #      GL_MAP1_TEXTURE_COORD_3
                              #      GL_MAP1_TEXTURE_COORD_4
                              #      GL_MAP1_VERTEX_3
                              #      GL_MAP1_VERTEX_4
                              #      GL_MAP2_COLOR_4
                              #      GL_MAP2_INDEX
                              #      GL_MAP2_NORMAL
                              #      GL_MAP2_TEXTURE_COORD_1
                              #      GL_MAP2_TEXTURE_COORD_2
                              #      GL_MAP2_TEXTURE_COORD_3
                              #      GL_MAP2_TEXTURE_COORD_4
                              #      GL_MAP2_VERTEX_3
                              #      GL_MAP2_VERTEX_4
                              # MaterialFace
                              #      GL_FRONT
                              #      GL_BACK
                              #      GL_FRONT_AND_BACK
                              # MaterialParameter
  GlEmission* = 0x00001600
  GlShininess* = 0x00001601
  GlAmbientAndDiffuse* = 0x00001602
  GlColorIndexes* = 0x00001603 #      GL_AMBIENT
                                 #      GL_DIFFUSE
                                 #      GL_SPECULAR
                                 # MatrixMode
  GlModelview* = 0x00001700
  GlProjection* = 0x00001701
  GlTexture* = 0x00001702    # MeshMode1
                              #      GL_POINT
                              #      GL_LINE
                              # MeshMode2
                              #      GL_POINT
                              #      GL_LINE
                              #      GL_FILL
                              # NormalPointerType
                              #      GL_BYTE
                              #      GL_SHORT
                              #      GL_INT
                              #      GL_FLOAT
                              #      GL_DOUBLE
                              # PixelCopyType
  GlColor* = 0x00001800
  GlDepth* = 0x00001801
  GlStencil* = 0x00001802    # PixelFormat
  GlColorIndex* = 0x00001900
  GlStencilIndex* = 0x00001901
  GlDepthComponent* = 0x00001902
  GlRed* = 0x00001903
  GlGreen* = 0x00001904
  GlBlue* = 0x00001905
  GlAlpha* = 0x00001906
  GlRgb* = 0x00001907
  GlRgba* = 0x00001908
  GlLuminance* = 0x00001909
  GlLuminanceAlpha* = 0x0000190A # PixelMap
                                   #      GL_PIXEL_MAP_I_TO_I
                                   #      GL_PIXEL_MAP_S_TO_S
                                   #      GL_PIXEL_MAP_I_TO_R
                                   #      GL_PIXEL_MAP_I_TO_G
                                   #      GL_PIXEL_MAP_I_TO_B
                                   #      GL_PIXEL_MAP_I_TO_A
                                   #      GL_PIXEL_MAP_R_TO_R
                                   #      GL_PIXEL_MAP_G_TO_G
                                   #      GL_PIXEL_MAP_B_TO_B
                                   #      GL_PIXEL_MAP_A_TO_A
                                   # PixelStore
                                   #      GL_UNPACK_SWAP_BYTES
                                   #      GL_UNPACK_LSB_FIRST
                                   #      GL_UNPACK_ROW_LENGTH
                                   #      GL_UNPACK_SKIP_ROWS
                                   #      GL_UNPACK_SKIP_PIXELS
                                   #      GL_UNPACK_ALIGNMENT
                                   #      GL_PACK_SWAP_BYTES
                                   #      GL_PACK_LSB_FIRST
                                   #      GL_PACK_ROW_LENGTH
                                   #      GL_PACK_SKIP_ROWS
                                   #      GL_PACK_SKIP_PIXELS
                                   #      GL_PACK_ALIGNMENT
                                   # PixelTransfer
                                   #      GL_MAP_COLOR
                                   #      GL_MAP_STENCIL
                                   #      GL_INDEX_SHIFT
                                   #      GL_INDEX_OFFSET
                                   #      GL_RED_SCALE
                                   #      GL_RED_BIAS
                                   #      GL_GREEN_SCALE
                                   #      GL_GREEN_BIAS
                                   #      GL_BLUE_SCALE
                                   #      GL_BLUE_BIAS
                                   #      GL_ALPHA_SCALE
                                   #      GL_ALPHA_BIAS
                                   #      GL_DEPTH_SCALE
                                   #      GL_DEPTH_BIAS
                                   # PixelType
  constGLBITMAP* = 0x00001A00
  GlPoint* = 0x00001B00
  GlLine* = 0x00001B01
  GlFill* = 0x00001B02       # ReadBufferMode
                              #      GL_FRONT_LEFT
                              #      GL_FRONT_RIGHT
                              #      GL_BACK_LEFT
                              #      GL_BACK_RIGHT
                              #      GL_FRONT
                              #      GL_BACK
                              #      GL_LEFT
                              #      GL_RIGHT
                              #      GL_AUX0
                              #      GL_AUX1
                              #      GL_AUX2
                              #      GL_AUX3
                              # RenderingMode
  GlRender* = 0x00001C00
  GlFeedback* = 0x00001C01
  GlSelect* = 0x00001C02     # ShadingModel
  GlFlat* = 0x00001D00
  GlSmooth* = 0x00001D01     # StencilFunction
                              #      GL_NEVER
                              #      GL_LESS
                              #      GL_EQUAL
                              #      GL_LEQUAL
                              #      GL_GREATER
                              #      GL_NOTEQUAL
                              #      GL_GEQUAL
                              #      GL_ALWAYS
                              # StencilOp
                              #      GL_ZERO
  GlKeep* = 0x00001E00
  GlReplace* = 0x00001E01
  GlIncr* = 0x00001E02
  GlDecr* = 0x00001E03       #      GL_INVERT
                              # StringName
  GlVendor* = 0x00001F00
  GlRenderer* = 0x00001F01
  GlVersion* = 0x00001F02
  GlExtensions* = 0x00001F03 # TextureCoordName
  GlS* = 0x00002000
  GlT* = 0x00002001
  GlR* = 0x00002002
  GlQ* = 0x00002003          # TexCoordPointerType
                              #      GL_SHORT
                              #      GL_INT
                              #      GL_FLOAT
                              #      GL_DOUBLE
                              # TextureEnvMode
  GlModulate* = 0x00002100
  GlDecal* = 0x00002101      #      GL_BLEND
                              #      GL_REPLACE
                              # TextureEnvParameter
  GlTextureEnvMode* = 0x00002200
  GlTextureEnvColor* = 0x00002201 # TextureEnvTarget
  GlTextureEnv* = 0x00002300 # TextureGenMode
  GlEyeLinear* = 0x00002400
  GlObjectLinear* = 0x00002401
  GlSphereMap* = 0x00002402 # TextureGenParameter
  GlTextureGenMode* = 0x00002500
  GlObjectPlane* = 0x00002501
  GlEyePlane* = 0x00002502  # TextureMagFilter
  GlNearest* = 0x00002600
  GlLinear* = 0x00002601     # TextureMinFilter
                              #      GL_NEAREST
                              #      GL_LINEAR
  GlNearestMipmapNearest* = 0x00002700
  GlLinearMipmapNearest* = 0x00002701
  GlNearestMipmapLinear* = 0x00002702
  GlLinearMipmapLinear* = 0x00002703 # TextureParameterName
  GlTextureMagFilter* = 0x00002800
  GlTextureMinFilter* = 0x00002801
  GlTextureWrapS* = 0x00002802
  GlTextureWrapT* = 0x00002803 #      GL_TEXTURE_BORDER_COLOR
                                  #      GL_TEXTURE_PRIORITY
                                  # TextureTarget
                                  #      GL_TEXTURE_1D
                                  #      GL_TEXTURE_2D
                                  #      GL_PROXY_TEXTURE_1D
                                  #      GL_PROXY_TEXTURE_2D
                                  # TextureWrapMode
  GlClamp* = 0x00002900
  GlRepeat* = 0x00002901     # VertexPointerType
                              #      GL_SHORT
                              #      GL_INT
                              #      GL_FLOAT
                              #      GL_DOUBLE
                              # ClientAttribMask
  GlClientPixelStoreBit* = 0x00000001
  GlClientVertexArrayBit* = 0x00000002
  GlClientAllAttribBits* = 0xFFFFFFFF # polygon_offset
  GlPolygonOffsetFactor* = 0x00008038
  GlPolygonOffsetUnits* = 0x00002A00
  GlPolygonOffsetPoint* = 0x00002A01
  GlPolygonOffsetLine* = 0x00002A02
  GlPolygonOffsetFill* = 0x00008037 # texture
  GlAlpha4* = 0x0000803B
  GlAlpha8* = 0x0000803C
  GlAlpha12* = 0x0000803D
  GlAlpha16* = 0x0000803E
  GlLuminance4* = 0x0000803F
  GlLuminance8* = 0x00008040
  GlLuminance12* = 0x00008041
  GlLuminance16* = 0x00008042
  GlLuminance4Alpha4* = 0x00008043
  GlLuminance6Alpha2* = 0x00008044
  GlLuminance8Alpha8* = 0x00008045
  GlLuminance12Alpha4* = 0x00008046
  GlLuminance12Alpha12* = 0x00008047
  GlLuminance16Alpha16* = 0x00008048
  GlIntensity* = 0x00008049
  GlIntensity4* = 0x0000804A
  GlIntensity8* = 0x0000804B
  GlIntensity12* = 0x0000804C
  GlIntensity16* = 0x0000804D
  GlR3G3B2* = 0x00002A10
  GlRgb4* = 0x0000804F
  GlRgb5* = 0x00008050
  GlRgb8* = 0x00008051
  GlRgb10* = 0x00008052
  GlRgb12* = 0x00008053
  GlRgb16* = 0x00008054
  GlRgba2* = 0x00008055
  GlRgba4* = 0x00008056
  GlRgb5A1* = 0x00008057
  GlRgba8* = 0x00008058
  GlRgb10A2* = 0x00008059
  GlRgba12* = 0x0000805A
  GlRgba16* = 0x0000805B
  GlTextureRedSize* = 0x0000805C
  GlTextureGreenSize* = 0x0000805D
  GlTextureBlueSize* = 0x0000805E
  GlTextureAlphaSize* = 0x0000805F
  GlTextureLuminanceSize* = 0x00008060
  GlTextureIntensitySize* = 0x00008061
  GlProxyTexture1d* = 0x00008063
  GlProxyTexture2d* = 0x00008064 # texture_object
  GlTexturePriority* = 0x00008066
  GlTextureResident* = 0x00008067
  GlTextureBinding1d* = 0x00008068
  GlTextureBinding2d* = 0x00008069 # vertex_array
  GlVertexArray* = 0x00008074
  GlNormalArray* = 0x00008075
  GlColorArray* = 0x00008076
  GlIndexArray* = 0x00008077
  GlTextureCoordArray* = 0x00008078
  GlEdgeFlagArray* = 0x00008079
  GlVertexArraySize* = 0x0000807A
  GlVertexArrayType* = 0x0000807B
  GlVertexArrayStride* = 0x0000807C
  GlNormalArrayType* = 0x0000807E
  GlNormalArrayStride* = 0x0000807F
  GlColorArraySize* = 0x00008081
  GlColorArrayType* = 0x00008082
  GlColorArrayStride* = 0x00008083
  GlIndexArrayType* = 0x00008085
  GlIndexArrayStride* = 0x00008086
  GlTextureCoordArraySize* = 0x00008088
  GlTextureCoordArrayType* = 0x00008089
  GlTextureCoordArrayStride* = 0x0000808A
  GlEdgeFlagArrayStride* = 0x0000808C
  GlVertexArrayPointer* = 0x0000808E
  GlNormalArrayPointer* = 0x0000808F
  GlColorArrayPointer* = 0x00008090
  GlIndexArrayPointer* = 0x00008091
  GlTextureCoordArrayPointer* = 0x00008092
  GlEdgeFlagArrayPointer* = 0x00008093
  GlV2f* = 0x00002A20
  GlV3f* = 0x00002A21
  GlC4ubV2f* = 0x00002A22
  GlC4ubV3f* = 0x00002A23
  GlC3fV3f* = 0x00002A24
  GlN3fV3f* = 0x00002A25
  GlC4fN3fV3f* = 0x00002A26
  GlT2fV3f* = 0x00002A27
  GlT4fV4f* = 0x00002A28
  GlT2fC4ubV3f* = 0x00002A29
  GlT2fC3fV3f* = 0x00002A2A
  GlT2fN3fV3f* = 0x00002A2B
  GlT2fC4fN3fV3f* = 0x00002A2C
  GlT4fC4fN3fV4f* = 0x00002A2D # Extensions
  GLEXTVertexArray* = 1
  GLWINSwapHint* = 1
  GLEXTBgra* = 1
  GLEXTPalettedTexture* = 1 # EXT_vertex_array
  GlVertexArrayExt* = 0x00008074
  GlNormalArrayExt* = 0x00008075
  GlColorArrayExt* = 0x00008076
  GlIndexArrayExt* = 0x00008077
  GlTextureCoordArrayExt* = 0x00008078
  GlEdgeFlagArrayExt* = 0x00008079
  GlVertexArraySizeExt* = 0x0000807A
  GlVertexArrayTypeExt* = 0x0000807B
  GlVertexArrayStrideExt* = 0x0000807C
  GlVertexArrayCountExt* = 0x0000807D
  GlNormalArrayTypeExt* = 0x0000807E
  GlNormalArrayStrideExt* = 0x0000807F
  GlNormalArrayCountExt* = 0x00008080
  GlColorArraySizeExt* = 0x00008081
  GlColorArrayTypeExt* = 0x00008082
  GlColorArrayStrideExt* = 0x00008083
  GlColorArrayCountExt* = 0x00008084
  GlIndexArrayTypeExt* = 0x00008085
  GlIndexArrayStrideExt* = 0x00008086
  GlIndexArrayCountExt* = 0x00008087
  GlTextureCoordArraySizeExt* = 0x00008088
  GlTextureCoordArrayTypeExt* = 0x00008089
  GlTextureCoordArrayStrideExt* = 0x0000808A
  GlTextureCoordArrayCountExt* = 0x0000808B
  GlEdgeFlagArrayStrideExt* = 0x0000808C
  GlEdgeFlagArrayCountExt* = 0x0000808D
  GlVertexArrayPointerExt* = 0x0000808E
  GlNormalArrayPointerExt* = 0x0000808F
  GlColorArrayPointerExt* = 0x00008090
  GlIndexArrayPointerExt* = 0x00008091
  GlTextureCoordArrayPointerExt* = 0x00008092
  GlEdgeFlagArrayPointerExt* = 0x00008093
  GlDoubleExt* = GL_DOUBLE  # EXT_bgra
  GlBgrExt* = 0x000080E0
  GlBgraExt* = 0x000080E1   # EXT_paletted_texture
                              # These must match the GL_COLOR_TABLE_*_SGI enumerants
  GlColorTableFormatExt* = 0x000080D8
  GlColorTableWidthExt* = 0x000080D9
  GlColorTableRedSizeExt* = 0x000080DA
  GlColorTableGreenSizeExt* = 0x000080DB
  GlColorTableBlueSizeExt* = 0x000080DC
  GlColorTableAlphaSizeExt* = 0x000080DD
  GlColorTableLuminanceSizeExt* = 0x000080DE
  GlColorTableIntensitySizeExt* = 0x000080DF
  GlColorIndex1Ext* = 0x000080E2
  GlColorIndex2Ext* = 0x000080E3
  GlColorIndex4Ext* = 0x000080E4
  GlColorIndex8Ext* = 0x000080E5
  GlColorIndex12Ext* = 0x000080E6
  GlColorIndex16Ext* = 0x000080E7 # For compatibility with OpenGL v1.0
  constGLLOGICOP* = GL_INDEX_LOGIC_OP
  GlTextureComponents* = GL_TEXTURE_INTERNAL_FORMAT

proc glAccum*(op: TGLenum, value: TGLfloat){.dynlib: dllname, importc: "glAccum".}
proc glAlphaFunc*(func: TGLenum, theref: TGLclampf){.dynlib: dllname, 
    importc: "glAlphaFunc".}
proc glAreTexturesResident*(n: TGLsizei, textures: PGLuint, 
                            residences: PGLboolean): TGLboolean{.
    dynlib: dllname, importc: "glAreTexturesResident".}
proc glArrayElement*(i: TGLint){.dynlib: dllname, importc: "glArrayElement".}
proc glBegin*(mode: TGLenum){.dynlib: dllname, importc: "glBegin".}
proc glBindTexture*(target: TGLenum, texture: TGLuint){.dynlib: dllname, 
    importc: "glBindTexture".}
proc glBitmap*(width, height: TGLsizei, xorig, yorig: TGLfloat, 
               xmove, ymove: TGLfloat, bitmap: PGLubyte){.dynlib: dllname, 
    importc: "glBitmap".}
proc glBlendFunc*(sfactor, dfactor: TGLenum){.dynlib: dllname, 
    importc: "glBlendFunc".}
proc glCallList*(list: TGLuint){.dynlib: dllname, importc: "glCallList".}
proc glCallLists*(n: TGLsizei, atype: TGLenum, lists: Pointer){.dynlib: dllname, 
    importc: "glCallLists".}
proc glClear*(mask: TGLbitfield){.dynlib: dllname, importc: "glClear".}
proc glClearAccum*(red, green, blue, alpha: TGLfloat){.dynlib: dllname, 
    importc: "glClearAccum".}
proc glClearColor*(red, green, blue, alpha: TGLclampf){.dynlib: dllname, 
    importc: "glClearColor".}
proc glClearDepth*(depth: TGLclampd){.dynlib: dllname, importc: "glClearDepth".}
proc glClearIndex*(c: TGLfloat){.dynlib: dllname, importc: "glClearIndex".}
proc glClearStencil*(s: TGLint){.dynlib: dllname, importc: "glClearStencil".}
proc glClipPlane*(plane: TGLenum, equation: PGLdouble){.dynlib: dllname, 
    importc: "glClipPlane".}
proc glColor3b*(red, green, blue: TGlbyte){.dynlib: dllname, 
    importc: "glColor3b".}
proc glColor3bv*(v: PGLbyte){.dynlib: dllname, importc: "glColor3bv".}
proc glColor3d*(red, green, blue: TGLdouble){.dynlib: dllname, 
    importc: "glColor3d".}
proc glColor3dv*(v: PGLdouble){.dynlib: dllname, importc: "glColor3dv".}
proc glColor3f*(red, green, blue: TGLfloat){.dynlib: dllname, 
    importc: "glColor3f".}
proc glColor3fv*(v: PGLfloat){.dynlib: dllname, importc: "glColor3fv".}
proc glColor3i*(red, green, blue: TGLint){.dynlib: dllname, importc: "glColor3i".}
proc glColor3iv*(v: PGLint){.dynlib: dllname, importc: "glColor3iv".}
proc glColor3s*(red, green, blue: TGLshort){.dynlib: dllname, 
    importc: "glColor3s".}
proc glColor3sv*(v: PGLshort){.dynlib: dllname, importc: "glColor3sv".}
proc glColor3ub*(red, green, blue: TGLubyte){.dynlib: dllname, 
    importc: "glColor3ub".}
proc glColor3ubv*(v: PGLubyte){.dynlib: dllname, importc: "glColor3ubv".}
proc glColor3ui*(red, green, blue: TGLuint){.dynlib: dllname, 
    importc: "glColor3ui".}
proc glColor3uiv*(v: PGLuint){.dynlib: dllname, importc: "glColor3uiv".}
proc glColor3us*(red, green, blue: TGLushort){.dynlib: dllname, 
    importc: "glColor3us".}
proc glColor3usv*(v: PGLushort){.dynlib: dllname, importc: "glColor3usv".}
proc glColor4b*(red, green, blue, alpha: TGlbyte){.dynlib: dllname, 
    importc: "glColor4b".}
proc glColor4bv*(v: PGLbyte){.dynlib: dllname, importc: "glColor4bv".}
proc glColor4d*(red, green, blue, alpha: TGLdouble){.dynlib: dllname, 
    importc: "glColor4d".}
proc glColor4dv*(v: PGLdouble){.dynlib: dllname, importc: "glColor4dv".}
proc glColor4f*(red, green, blue, alpha: TGLfloat){.dynlib: dllname, 
    importc: "glColor4f".}
proc glColor4fv*(v: PGLfloat){.dynlib: dllname, importc: "glColor4fv".}
proc glColor4i*(red, green, blue, alpha: TGLint){.dynlib: dllname, 
    importc: "glColor4i".}
proc glColor4iv*(v: PGLint){.dynlib: dllname, importc: "glColor4iv".}
proc glColor4s*(red, green, blue, alpha: TGLshort){.dynlib: dllname, 
    importc: "glColor4s".}
proc glColor4sv*(v: PGLshort){.dynlib: dllname, importc: "glColor4sv".}
proc glColor4ub*(red, green, blue, alpha: TGLubyte){.dynlib: dllname, 
    importc: "glColor4ub".}
proc glColor4ubv*(v: PGLubyte){.dynlib: dllname, importc: "glColor4ubv".}
proc glColor4ui*(red, green, blue, alpha: TGLuint){.dynlib: dllname, 
    importc: "glColor4ui".}
proc glColor4uiv*(v: PGLuint){.dynlib: dllname, importc: "glColor4uiv".}
proc glColor4us*(red, green, blue, alpha: TGLushort){.dynlib: dllname, 
    importc: "glColor4us".}
proc glColor4usv*(v: PGLushort){.dynlib: dllname, importc: "glColor4usv".}
proc glColorMask*(red, green, blue, alpha: TGLboolean){.dynlib: dllname, 
    importc: "glColorMask".}
proc glColorMaterial*(face, mode: TGLenum){.dynlib: dllname, 
    importc: "glColorMaterial".}
proc glColorPointer*(size: TGLint, atype: TGLenum, stride: TGLsizei, 
                     pointer: Pointer){.dynlib: dllname, 
                                        importc: "glColorPointer".}
proc glCopyPixels*(x, y: TGLint, width, height: TGLsizei, atype: TGLenum){.
    dynlib: dllname, importc: "glCopyPixels".}
proc glCopyTexImage1D*(target: TGLenum, level: TGLint, internalFormat: TGLenum, 
                       x, y: TGLint, width: TGLsizei, border: TGLint){.
    dynlib: dllname, importc: "glCopyTexImage1D".}
proc glCopyTexImage2D*(target: TGLenum, level: TGLint, internalFormat: TGLenum, 
                       x, y: TGLint, width, height: TGLsizei, border: TGLint){.
    dynlib: dllname, importc: "glCopyTexImage2D".}
proc glCopyTexSubImage1D*(target: TGLenum, level, xoffset, x, y: TGLint, 
                          width: TGLsizei){.dynlib: dllname, 
    importc: "glCopyTexSubImage1D".}
proc glCopyTexSubImage2D*(target: TGLenum, 
                          level, xoffset, yoffset, x, y: TGLint, 
                          width, height: TGLsizei){.dynlib: dllname, 
    importc: "glCopyTexSubImage2D".}
proc glCullFace*(mode: TGLenum){.dynlib: dllname, importc: "glCullFace".}
proc glDeleteLists*(list: TGLuint, range: TGLsizei){.dynlib: dllname, 
    importc: "glDeleteLists".}
proc glDeleteTextures*(n: TGLsizei, textures: PGLuint){.dynlib: dllname, 
    importc: "glDeleteTextures".}
proc glDepthFunc*(func: TGLenum){.dynlib: dllname, importc: "glDepthFunc".}
proc glDepthMask*(flag: TGLboolean){.dynlib: dllname, importc: "glDepthMask".}
proc glDepthRange*(zNear, zFar: TGLclampd){.dynlib: dllname, 
    importc: "glDepthRange".}
proc glDisable*(cap: TGLenum){.dynlib: dllname, importc: "glDisable".}
proc glDisableClientState*(aarray: TGLenum){.dynlib: dllname, 
    importc: "glDisableClientState".}
proc glDrawArrays*(mode: TGLenum, first: TGLint, count: TGLsizei){.
    dynlib: dllname, importc: "glDrawArrays".}
proc glDrawBuffer*(mode: TGLenum){.dynlib: dllname, importc: "glDrawBuffer".}
proc glDrawElements*(mode: TGLenum, count: TGLsizei, atype: TGLenum, 
                     indices: Pointer){.dynlib: dllname, 
                                        importc: "glDrawElements".}
proc glDrawPixels*(width, height: TGLsizei, format, atype: TGLenum, 
                   pixels: Pointer){.dynlib: dllname, importc: "glDrawPixels".}
proc glEdgeFlag*(flag: TGLboolean){.dynlib: dllname, importc: "glEdgeFlag".}
proc glEdgeFlagPointer*(stride: TGLsizei, pointer: Pointer){.dynlib: dllname, 
    importc: "glEdgeFlagPointer".}
proc glEdgeFlagv*(flag: PGLboolean){.dynlib: dllname, importc: "glEdgeFlagv".}
proc glEnable*(cap: TGLenum){.dynlib: dllname, importc: "glEnable".}
proc glEnableClientState*(aarray: TGLenum){.dynlib: dllname, 
    importc: "glEnableClientState".}
proc glEnd*(){.dynlib: dllname, importc: "glEnd".}
proc glEndList*(){.dynlib: dllname, importc: "glEndList".}
proc glEvalCoord1d*(u: TGLdouble){.dynlib: dllname, importc: "glEvalCoord1d".}
proc glEvalCoord1dv*(u: PGLdouble){.dynlib: dllname, importc: "glEvalCoord1dv".}
proc glEvalCoord1f*(u: TGLfloat){.dynlib: dllname, importc: "glEvalCoord1f".}
proc glEvalCoord1fv*(u: PGLfloat){.dynlib: dllname, importc: "glEvalCoord1fv".}
proc glEvalCoord2d*(u, v: TGLdouble){.dynlib: dllname, importc: "glEvalCoord2d".}
proc glEvalCoord2dv*(u: PGLdouble){.dynlib: dllname, importc: "glEvalCoord2dv".}
proc glEvalCoord2f*(u, v: TGLfloat){.dynlib: dllname, importc: "glEvalCoord2f".}
proc glEvalCoord2fv*(u: PGLfloat){.dynlib: dllname, importc: "glEvalCoord2fv".}
proc glEvalMesh1*(mode: TGLenum, i1, i2: TGLint){.dynlib: dllname, 
    importc: "glEvalMesh1".}
proc glEvalMesh2*(mode: TGLenum, i1, i2, j1, j2: TGLint){.dynlib: dllname, 
    importc: "glEvalMesh2".}
proc glEvalPoint1*(i: TGLint){.dynlib: dllname, importc: "glEvalPoint1".}
proc glEvalPoint2*(i, j: TGLint){.dynlib: dllname, importc: "glEvalPoint2".}
proc glFeedbackBuffer*(size: TGLsizei, atype: TGLenum, buffer: PGLfloat){.
    dynlib: dllname, importc: "glFeedbackBuffer".}
proc glFinish*(){.dynlib: dllname, importc: "glFinish".}
proc glFlush*(){.dynlib: dllname, importc: "glFlush".}
proc glFogf*(pname: TGLenum, param: TGLfloat){.dynlib: dllname, 
    importc: "glFogf".}
proc glFogfv*(pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glFogfv".}
proc glFogi*(pname: TGLenum, param: TGLint){.dynlib: dllname, importc: "glFogi".}
proc glFogiv*(pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glFogiv".}
proc glFrontFace*(mode: TGLenum){.dynlib: dllname, importc: "glFrontFace".}
proc glFrustum*(left, right, bottom, top, zNear, zFar: TGLdouble){.
    dynlib: dllname, importc: "glFrustum".}
proc glGenLists*(range: TGLsizei): TGLuint{.dynlib: dllname, 
    importc: "glGenLists".}
proc glGenTextures*(n: TGLsizei, textures: PGLuint){.dynlib: dllname, 
    importc: "glGenTextures".}
proc glGetBooleanv*(pname: TGLenum, params: PGLboolean){.dynlib: dllname, 
    importc: "glGetBooleanv".}
proc glGetClipPlane*(plane: TGLenum, equation: PGLdouble){.dynlib: dllname, 
    importc: "glGetClipPlane".}
proc glGetDoublev*(pname: TGLenum, params: PGLdouble){.dynlib: dllname, 
    importc: "glGetDoublev".}
proc glGetError*(): TGLenum{.dynlib: dllname, importc: "glGetError".}
proc glGetFloatv*(pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glGetFloatv".}
proc glGetIntegerv*(pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glGetIntegerv".}
proc glGetLightfv*(light, pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glGetLightfv".}
proc glGetLightiv*(light, pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glGetLightiv".}
proc glGetMapdv*(target, query: TGLenum, v: PGLdouble){.dynlib: dllname, 
    importc: "glGetMapdv".}
proc glGetMapfv*(target, query: TGLenum, v: PGLfloat){.dynlib: dllname, 
    importc: "glGetMapfv".}
proc glGetMapiv*(target, query: TGLenum, v: PGLint){.dynlib: dllname, 
    importc: "glGetMapiv".}
proc glGetMaterialfv*(face, pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glGetMaterialfv".}
proc glGetMaterialiv*(face, pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glGetMaterialiv".}
proc glGetPixelMapfv*(map: TGLenum, values: PGLfloat){.dynlib: dllname, 
    importc: "glGetPixelMapfv".}
proc glGetPixelMapuiv*(map: TGLenum, values: PGLuint){.dynlib: dllname, 
    importc: "glGetPixelMapuiv".}
proc glGetPixelMapusv*(map: TGLenum, values: PGLushort){.dynlib: dllname, 
    importc: "glGetPixelMapusv".}
proc glGetPointerv*(pname: TGLenum, params: Pointer){.dynlib: dllname, 
    importc: "glGetPointerv".}
proc glGetPolygonStipple*(mask: PGLubyte){.dynlib: dllname, 
    importc: "glGetPolygonStipple".}
proc glGetString*(name: TGLenum): Cstring{.dynlib: dllname, 
    importc: "glGetString".}
proc glGetTexEnvfv*(target, pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glGetTexEnvfv".}
proc glGetTexEnviv*(target, pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glGetTexEnviv".}
proc glGetTexGendv*(coord, pname: TGLenum, params: PGLdouble){.dynlib: dllname, 
    importc: "glGetTexGendv".}
proc glGetTexGenfv*(coord, pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glGetTexGenfv".}
proc glGetTexGeniv*(coord, pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glGetTexGeniv".}
proc glGetTexImage*(target: TGLenum, level: TGLint, format: TGLenum, 
                    atype: TGLenum, pixels: Pointer){.dynlib: dllname, 
    importc: "glGetTexImage".}
proc glGetTexLevelParameterfv*(target: TGLenum, level: TGLint, pname: TGLenum, 
                               params: Pointer){.dynlib: dllname, 
    importc: "glGetTexLevelParameterfv".}
proc glGetTexLevelParameteriv*(target: TGLenum, level: TGLint, pname: TGLenum, 
                               params: PGLint){.dynlib: dllname, 
    importc: "glGetTexLevelParameteriv".}
proc glGetTexParameterfv*(target, pname: TGLenum, params: PGLfloat){.
    dynlib: dllname, importc: "glGetTexParameterfv".}
proc glGetTexParameteriv*(target, pname: TGLenum, params: PGLint){.
    dynlib: dllname, importc: "glGetTexParameteriv".}
proc glHint*(target, mode: TGLenum){.dynlib: dllname, importc: "glHint".}
proc glIndexMask*(mask: TGLuint){.dynlib: dllname, importc: "glIndexMask".}
proc glIndexPointer*(atype: TGLenum, stride: TGLsizei, pointer: Pointer){.
    dynlib: dllname, importc: "glIndexPointer".}
proc glIndexd*(c: TGLdouble){.dynlib: dllname, importc: "glIndexd".}
proc glIndexdv*(c: PGLdouble){.dynlib: dllname, importc: "glIndexdv".}
proc glIndexf*(c: TGLfloat){.dynlib: dllname, importc: "glIndexf".}
proc glIndexfv*(c: PGLfloat){.dynlib: dllname, importc: "glIndexfv".}
proc glIndexi*(c: TGLint){.dynlib: dllname, importc: "glIndexi".}
proc glIndexiv*(c: PGLint){.dynlib: dllname, importc: "glIndexiv".}
proc glIndexs*(c: TGLshort){.dynlib: dllname, importc: "glIndexs".}
proc glIndexsv*(c: PGLshort){.dynlib: dllname, importc: "glIndexsv".}
proc glIndexub*(c: TGLubyte){.dynlib: dllname, importc: "glIndexub".}
proc glIndexubv*(c: PGLubyte){.dynlib: dllname, importc: "glIndexubv".}
proc glInitNames*(){.dynlib: dllname, importc: "glInitNames".}
proc glInterleavedArrays*(format: TGLenum, stride: TGLsizei, pointer: Pointer){.
    dynlib: dllname, importc: "glInterleavedArrays".}
proc glIsEnabled*(cap: TGLenum): TGLboolean{.dynlib: dllname, 
    importc: "glIsEnabled".}
proc glIsList*(list: TGLuint): TGLboolean{.dynlib: dllname, importc: "glIsList".}
proc glIsTexture*(texture: TGLuint): TGLboolean{.dynlib: dllname, 
    importc: "glIsTexture".}
proc glLightModelf*(pname: TGLenum, param: TGLfloat){.dynlib: dllname, 
    importc: "glLightModelf".}
proc glLightModelfv*(pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glLightModelfv".}
proc glLightModeli*(pname: TGLenum, param: TGLint){.dynlib: dllname, 
    importc: "glLightModeli".}
proc glLightModeliv*(pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glLightModeliv".}
proc glLightf*(light, pname: TGLenum, param: TGLfloat){.dynlib: dllname, 
    importc: "glLightf".}
proc glLightfv*(light, pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glLightfv".}
proc glLighti*(light, pname: TGLenum, param: TGLint){.dynlib: dllname, 
    importc: "glLighti".}
proc glLightiv*(light, pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glLightiv".}
proc glLineStipple*(factor: TGLint, pattern: TGLushort){.dynlib: dllname, 
    importc: "glLineStipple".}
proc glLineWidth*(width: TGLfloat){.dynlib: dllname, importc: "glLineWidth".}
proc glListBase*(base: TGLuint){.dynlib: dllname, importc: "glListBase".}
proc glLoadIdentity*(){.dynlib: dllname, importc: "glLoadIdentity".}
proc glLoadMatrixd*(m: PGLdouble){.dynlib: dllname, importc: "glLoadMatrixd".}
proc glLoadMatrixf*(m: PGLfloat){.dynlib: dllname, importc: "glLoadMatrixf".}
proc glLoadName*(name: TGLuint){.dynlib: dllname, importc: "glLoadName".}
proc glLogicOp*(opcode: TGLenum){.dynlib: dllname, importc: "glLogicOp".}
proc glMap1d*(target: TGLenum, u1, u2: TGLdouble, stride, order: TGLint, 
              points: PGLdouble){.dynlib: dllname, importc: "glMap1d".}
proc glMap1f*(target: TGLenum, u1, u2: TGLfloat, stride, order: TGLint, 
              points: PGLfloat){.dynlib: dllname, importc: "glMap1f".}
proc glMap2d*(target: TGLenum, u1, u2: TGLdouble, ustride, uorder: TGLint, 
              v1, v2: TGLdouble, vstride, vorder: TGLint, points: PGLdouble){.
    dynlib: dllname, importc: "glMap2d".}
proc glMap2f*(target: TGLenum, u1, u2: TGLfloat, ustride, uorder: TGLint, 
              v1, v2: TGLfloat, vstride, vorder: TGLint, points: PGLfloat){.
    dynlib: dllname, importc: "glMap2f".}
proc glMapGrid1d*(un: TGLint, u1, u2: TGLdouble){.dynlib: dllname, 
    importc: "glMapGrid1d".}
proc glMapGrid1f*(un: TGLint, u1, u2: TGLfloat){.dynlib: dllname, 
    importc: "glMapGrid1f".}
proc glMapGrid2d*(un: TGLint, u1, u2: TGLdouble, vn: TGLint, v1, v2: TGLdouble){.
    dynlib: dllname, importc: "glMapGrid2d".}
proc glMapGrid2f*(un: TGLint, u1, u2: TGLfloat, vn: TGLint, v1, v2: TGLfloat){.
    dynlib: dllname, importc: "glMapGrid2f".}
proc glMaterialf*(face, pname: TGLenum, param: TGLfloat){.dynlib: dllname, 
    importc: "glMaterialf".}
proc glMaterialfv*(face, pname: TGLenum, params: PGLfloat){.dynlib: dllname, 
    importc: "glMaterialfv".}
proc glMateriali*(face, pname: TGLenum, param: TGLint){.dynlib: dllname, 
    importc: "glMateriali".}
proc glMaterialiv*(face, pname: TGLenum, params: PGLint){.dynlib: dllname, 
    importc: "glMaterialiv".}
proc glMatrixMode*(mode: TGLenum){.dynlib: dllname, importc: "glMatrixMode".}
proc glMultMatrixd*(m: PGLdouble){.dynlib: dllname, importc: "glMultMatrixd".}
proc glMultMatrixf*(m: PGLfloat){.dynlib: dllname, importc: "glMultMatrixf".}
proc glNewList*(list: TGLuint, mode: TGLenum){.dynlib: dllname, 
    importc: "glNewList".}
proc glNormal3b*(nx, ny, nz: TGlbyte){.dynlib: dllname, importc: "glNormal3b".}
proc glNormal3bv*(v: PGLbyte){.dynlib: dllname, importc: "glNormal3bv".}
proc glNormal3d*(nx, ny, nz: TGLdouble){.dynlib: dllname, importc: "glNormal3d".}
proc glNormal3dv*(v: PGLdouble){.dynlib: dllname, importc: "glNormal3dv".}
proc glNormal3f*(nx, ny, nz: TGLfloat){.dynlib: dllname, importc: "glNormal3f".}
proc glNormal3fv*(v: PGLfloat){.dynlib: dllname, importc: "glNormal3fv".}
proc glNormal3i*(nx, ny, nz: TGLint){.dynlib: dllname, importc: "glNormal3i".}
proc glNormal3iv*(v: PGLint){.dynlib: dllname, importc: "glNormal3iv".}
proc glNormal3s*(nx, ny, nz: TGLshort){.dynlib: dllname, importc: "glNormal3s".}
proc glNormal3sv*(v: PGLshort){.dynlib: dllname, importc: "glNormal3sv".}
proc glNormalPointer*(atype: TGLenum, stride: TGLsizei, pointer: Pointer){.
    dynlib: dllname, importc: "glNormalPointer".}
proc glOrtho*(left, right, bottom, top, zNear, zFar: TGLdouble){.
    dynlib: dllname, importc: "glOrtho".}
proc glPassThrough*(token: TGLfloat){.dynlib: dllname, importc: "glPassThrough".}
proc glPixelMapfv*(map: TGLenum, mapsize: TGLsizei, values: PGLfloat){.
    dynlib: dllname, importc: "glPixelMapfv".}
proc glPixelMapuiv*(map: TGLenum, mapsize: TGLsizei, values: PGLuint){.
    dynlib: dllname, importc: "glPixelMapuiv".}
proc glPixelMapusv*(map: TGLenum, mapsize: TGLsizei, values: PGLushort){.
    dynlib: dllname, importc: "glPixelMapusv".}
proc glPixelStoref*(pname: TGLenum, param: TGLfloat){.dynlib: dllname, 
    importc: "glPixelStoref".}
proc glPixelStorei*(pname: TGLenum, param: TGLint){.dynlib: dllname, 
    importc: "glPixelStorei".}
proc glPixelTransferf*(pname: TGLenum, param: TGLfloat){.dynlib: dllname, 
    importc: "glPixelTransferf".}
proc glPixelTransferi*(pname: TGLenum, param: TGLint){.dynlib: dllname, 
    importc: "glPixelTransferi".}
proc glPixelZoom*(xfactor, yfactor: TGLfloat){.dynlib: dllname, 
    importc: "glPixelZoom".}
proc glPointSize*(size: TGLfloat){.dynlib: dllname, importc: "glPointSize".}
proc glPolygonMode*(face, mode: TGLenum){.dynlib: dllname, 
    importc: "glPolygonMode".}
proc glPolygonOffset*(factor, units: TGLfloat){.dynlib: dllname, 
    importc: "glPolygonOffset".}
proc glPolygonStipple*(mask: PGLubyte){.dynlib: dllname, 
                                        importc: "glPolygonStipple".}
proc glPopAttrib*(){.dynlib: dllname, importc: "glPopAttrib".}
proc glPopClientAttrib*(){.dynlib: dllname, importc: "glPopClientAttrib".}
proc glPopMatrix*(){.dynlib: dllname, importc: "glPopMatrix".}
proc glPopName*(){.dynlib: dllname, importc: "glPopName".}
proc glPrioritizeTextures*(n: TGLsizei, textures: PGLuint, priorities: PGLclampf){.
    dynlib: dllname, importc: "glPrioritizeTextures".}
proc glPushAttrib*(mask: TGLbitfield){.dynlib: dllname, importc: "glPushAttrib".}
proc glPushClientAttrib*(mask: TGLbitfield){.dynlib: dllname, 
    importc: "glPushClientAttrib".}
proc glPushMatrix*(){.dynlib: dllname, importc: "glPushMatrix".}
proc glPushName*(name: TGLuint){.dynlib: dllname, importc: "glPushName".}
proc glRasterPos2d*(x, y: TGLdouble){.dynlib: dllname, importc: "glRasterPos2d".}
proc glRasterPos2dv*(v: PGLdouble){.dynlib: dllname, importc: "glRasterPos2dv".}
proc glRasterPos2f*(x, y: TGLfloat){.dynlib: dllname, importc: "glRasterPos2f".}
proc glRasterPos2fv*(v: PGLfloat){.dynlib: dllname, importc: "glRasterPos2fv".}
proc glRasterPos2i*(x, y: TGLint){.dynlib: dllname, importc: "glRasterPos2i".}
proc glRasterPos2iv*(v: PGLint){.dynlib: dllname, importc: "glRasterPos2iv".}
proc glRasterPos2s*(x, y: TGLshort){.dynlib: dllname, importc: "glRasterPos2s".}
proc glRasterPos2sv*(v: PGLshort){.dynlib: dllname, importc: "glRasterPos2sv".}
proc glRasterPos3d*(x, y, z: TGLdouble){.dynlib: dllname, 
    importc: "glRasterPos3d".}
proc glRasterPos3dv*(v: PGLdouble){.dynlib: dllname, importc: "glRasterPos3dv".}
proc glRasterPos3f*(x, y, z: TGLfloat){.dynlib: dllname, 
                                        importc: "glRasterPos3f".}
proc glRasterPos3fv*(v: PGLfloat){.dynlib: dllname, importc: "glRasterPos3fv".}
proc glRasterPos3i*(x, y, z: TGLint){.dynlib: dllname, importc: "glRasterPos3i".}
proc glRasterPos3iv*(v: PGLint){.dynlib: dllname, importc: "glRasterPos3iv".}
proc glRasterPos3s*(x, y, z: TGLshort){.dynlib: dllname, 
                                        importc: "glRasterPos3s".}
proc glRasterPos3sv*(v: PGLshort){.dynlib: dllname, importc: "glRasterPos3sv".}
proc glRasterPos4d*(x, y, z, w: TGLdouble){.dynlib: dllname, 
    importc: "glRasterPos4d".}
proc glRasterPos4dv*(v: PGLdouble){.dynlib: dllname, importc: "glRasterPos4dv".}
proc glRasterPos4f*(x, y, z, w: TGLfloat){.dynlib: dllname, 
    importc: "glRasterPos4f".}
proc glRasterPos4fv*(v: PGLfloat){.dynlib: dllname, importc: "glRasterPos4fv".}
proc glRasterPos4i*(x, y, z, w: TGLint){.dynlib: dllname, 
    importc: "glRasterPos4i".}
proc glRasterPos4iv*(v: PGLint){.dynlib: dllname, importc: "glRasterPos4iv".}
proc glRasterPos4s*(x, y, z, w: TGLshort){.dynlib: dllname, 
    importc: "glRasterPos4s".}
proc glRasterPos4sv*(v: PGLshort){.dynlib: dllname, importc: "glRasterPos4sv".}
proc glReadBuffer*(mode: TGLenum){.dynlib: dllname, importc: "glReadBuffer".}
proc glReadPixels*(x, y: TGLint, width, height: TGLsizei, 
                   format, atype: TGLenum, pixels: Pointer){.dynlib: dllname, 
    importc: "glReadPixels".}
proc glRectd*(x1, y1, x2, y2: TGLdouble){.dynlib: dllname, importc: "glRectd".}
proc glRectdv*(v1: PGLdouble, v2: PGLdouble){.dynlib: dllname, 
    importc: "glRectdv".}
proc glRectf*(x1, y1, x2, y2: TGLfloat){.dynlib: dllname, importc: "glRectf".}
proc glRectfv*(v1: PGLfloat, v2: PGLfloat){.dynlib: dllname, importc: "glRectfv".}
proc glRecti*(x1, y1, x2, y2: TGLint){.dynlib: dllname, importc: "glRecti".}
proc glRectiv*(v1: PGLint, v2: PGLint){.dynlib: dllname, importc: "glRectiv".}
proc glRects*(x1, y1, x2, y2: TGLshort){.dynlib: dllname, importc: "glRects".}
proc glRectsv*(v1: PGLshort, v2: PGLshort){.dynlib: dllname, importc: "glRectsv".}
proc glRenderMode*(mode: TGLint): TGLint{.dynlib: dllname, 
    importc: "glRenderMode".}
proc glRotated*(angle, x, y, z: TGLdouble){.dynlib: dllname, 
    importc: "glRotated".}
proc glRotatef*(angle, x, y, z: TGLfloat){.dynlib: dllname, importc: "glRotatef".}
proc glScaled*(x, y, z: TGLdouble){.dynlib: dllname, importc: "glScaled".}
proc glScalef*(x, y, z: TGLfloat){.dynlib: dllname, importc: "glScalef".}
proc glScissor*(x, y: TGLint, width, height: TGLsizei){.dynlib: dllname, 
    importc: "glScissor".}
proc glSelectBuffer*(size: TGLsizei, buffer: PGLuint){.dynlib: dllname, 
    importc: "glSelectBuffer".}
proc glShadeModel*(mode: TGLenum){.dynlib: dllname, importc: "glShadeModel".}
proc glStencilFunc*(func: TGLenum, theref: TGLint, mask: TGLuint){.
    dynlib: dllname, importc: "glStencilFunc".}
proc glStencilMask*(mask: TGLuint){.dynlib: dllname, importc: "glStencilMask".}
proc glStencilOp*(fail, zfail, zpass: TGLenum){.dynlib: dllname, 
    importc: "glStencilOp".}
proc glTexCoord1d*(s: TGLdouble){.dynlib: dllname, importc: "glTexCoord1d".}
proc glTexCoord1dv*(v: PGLdouble){.dynlib: dllname, importc: "glTexCoord1dv".}
proc glTexCoord1f*(s: TGLfloat){.dynlib: dllname, importc: "glTexCoord1f".}
proc glTexCoord1fv*(v: PGLfloat){.dynlib: dllname, importc: "glTexCoord1fv".}
proc glTexCoord1i*(s: TGLint){.dynlib: dllname, importc: "glTexCoord1i".}
proc glTexCoord1iv*(v: PGLint){.dynlib: dllname, importc: "glTexCoord1iv".}
proc glTexCoord1s*(s: TGLshort){.dynlib: dllname, importc: "glTexCoord1s".}
proc glTexCoord1sv*(v: PGLshort){.dynlib: dllname, importc: "glTexCoord1sv".}
proc glTexCoord2d*(s, t: TGLdouble){.dynlib: dllname, importc: "glTexCoord2d".}
proc glTexCoord2dv*(v: PGLdouble){.dynlib: dllname, importc: "glTexCoord2dv".}
proc glTexCoord2f*(s, t: TGLfloat){.dynlib: dllname, importc: "glTexCoord2f".}
proc glTexCoord2fv*(v: PGLfloat){.dynlib: dllname, importc: "glTexCoord2fv".}
proc glTexCoord2i*(s, t: TGLint){.dynlib: dllname, importc: "glTexCoord2i".}
proc glTexCoord2iv*(v: PGLint){.dynlib: dllname, importc: "glTexCoord2iv".}
proc glTexCoord2s*(s, t: TGLshort){.dynlib: dllname, importc: "glTexCoord2s".}
proc glTexCoord2sv*(v: PGLshort){.dynlib: dllname, importc: "glTexCoord2sv".}
proc glTexCoord3d*(s, t, r: TGLdouble){.dynlib: dllname, importc: "glTexCoord3d".}
proc glTexCoord3dv*(v: PGLdouble){.dynlib: dllname, importc: "glTexCoord3dv".}
proc glTexCoord3f*(s, t, r: TGLfloat){.dynlib: dllname, importc: "glTexCoord3f".}
proc glTexCoord3fv*(v: PGLfloat){.dynlib: dllname, importc: "glTexCoord3fv".}
proc glTexCoord3i*(s, t, r: TGLint){.dynlib: dllname, importc: "glTexCoord3i".}
proc glTexCoord3iv*(v: PGLint){.dynlib: dllname, importc: "glTexCoord3iv".}
proc glTexCoord3s*(s, t, r: TGLshort){.dynlib: dllname, importc: "glTexCoord3s".}
proc glTexCoord3sv*(v: PGLshort){.dynlib: dllname, importc: "glTexCoord3sv".}
proc glTexCoord4d*(s, t, r, q: TGLdouble){.dynlib: dllname, 
    importc: "glTexCoord4d".}
proc glTexCoord4dv*(v: PGLdouble){.dynlib: dllname, importc: "glTexCoord4dv".}
proc glTexCoord4f*(s, t, r, q: TGLfloat){.dynlib: dllname, 
    importc: "glTexCoord4f".}
proc glTexCoord4fv*(v: PGLfloat){.dynlib: dllname, importc: "glTexCoord4fv".}
proc glTexCoord4i*(s, t, r, q: TGLint){.dynlib: dllname, importc: "glTexCoord4i".}
proc glTexCoord4iv*(v: PGLint){.dynlib: dllname, importc: "glTexCoord4iv".}
proc glTexCoord4s*(s, t, r, q: TGLshort){.dynlib: dllname, 
    importc: "glTexCoord4s".}
proc glTexCoord4sv*(v: PGLshort){.dynlib: dllname, importc: "glTexCoord4sv".}
proc glTexCoordPointer*(size: TGLint, atype: TGLenum, stride: TGLsizei, 
                        pointer: Pointer){.dynlib: dllname, 
    importc: "glTexCoordPointer".}
proc glTexEnvf*(target: TGLenum, pname: TGLenum, param: TGLfloat){.
    dynlib: dllname, importc: "glTexEnvf".}
proc glTexEnvfv*(target: TGLenum, pname: TGLenum, params: PGLfloat){.
    dynlib: dllname, importc: "glTexEnvfv".}
proc glTexEnvi*(target: TGLenum, pname: TGLenum, param: TGLint){.
    dynlib: dllname, importc: "glTexEnvi".}
proc glTexEnviv*(target: TGLenum, pname: TGLenum, params: PGLint){.
    dynlib: dllname, importc: "glTexEnviv".}
proc glTexGend*(coord: TGLenum, pname: TGLenum, param: TGLdouble){.
    dynlib: dllname, importc: "glTexGend".}
proc glTexGendv*(coord: TGLenum, pname: TGLenum, params: PGLdouble){.
    dynlib: dllname, importc: "glTexGendv".}
proc glTexGenf*(coord: TGLenum, pname: TGLenum, param: TGLfloat){.
    dynlib: dllname, importc: "glTexGenf".}
proc glTexGenfv*(coord: TGLenum, pname: TGLenum, params: PGLfloat){.
    dynlib: dllname, importc: "glTexGenfv".}
proc glTexGeni*(coord: TGLenum, pname: TGLenum, param: TGLint){.dynlib: dllname, 
    importc: "glTexGeni".}
proc glTexGeniv*(coord: TGLenum, pname: TGLenum, params: PGLint){.
    dynlib: dllname, importc: "glTexGeniv".}
proc glTexImage1D*(target: TGLenum, level, internalformat: TGLint, 
                   width: TGLsizei, border: TGLint, format, atype: TGLenum, 
                   pixels: Pointer){.dynlib: dllname, importc: "glTexImage1D".}
proc glTexImage2D*(target: TGLenum, level, internalformat: TGLint, 
                   width, height: TGLsizei, border: TGLint, 
                   format, atype: TGLenum, pixels: Pointer){.dynlib: dllname, 
    importc: "glTexImage2D".}
proc glTexParameterf*(target: TGLenum, pname: TGLenum, param: TGLfloat){.
    dynlib: dllname, importc: "glTexParameterf".}
proc glTexParameterfv*(target: TGLenum, pname: TGLenum, params: PGLfloat){.
    dynlib: dllname, importc: "glTexParameterfv".}
proc glTexParameteri*(target: TGLenum, pname: TGLenum, param: TGLint){.
    dynlib: dllname, importc: "glTexParameteri".}
proc glTexParameteriv*(target: TGLenum, pname: TGLenum, params: PGLint){.
    dynlib: dllname, importc: "glTexParameteriv".}
proc glTexSubImage1D*(target: TGLenum, level, xoffset: TGLint, width: TGLsizei, 
                      format, atype: TGLenum, pixels: Pointer){.dynlib: dllname, 
    importc: "glTexSubImage1D".}
proc glTexSubImage2D*(target: TGLenum, level, xoffset, yoffset: TGLint, 
                      width, height: TGLsizei, format, atype: TGLenum, 
                      pixels: Pointer){.dynlib: dllname, 
                                        importc: "glTexSubImage2D".}
proc glTranslated*(x, y, z: TGLdouble){.dynlib: dllname, importc: "glTranslated".}
proc glTranslatef*(x, y, z: TGLfloat){.dynlib: dllname, importc: "glTranslatef".}
proc glVertex2d*(x, y: TGLdouble){.dynlib: dllname, importc: "glVertex2d".}
proc glVertex2dv*(v: PGLdouble){.dynlib: dllname, importc: "glVertex2dv".}
proc glVertex2f*(x, y: TGLfloat){.dynlib: dllname, importc: "glVertex2f".}
proc glVertex2fv*(v: PGLfloat){.dynlib: dllname, importc: "glVertex2fv".}
proc glVertex2i*(x, y: TGLint){.dynlib: dllname, importc: "glVertex2i".}
proc glVertex2iv*(v: PGLint){.dynlib: dllname, importc: "glVertex2iv".}
proc glVertex2s*(x, y: TGLshort){.dynlib: dllname, importc: "glVertex2s".}
proc glVertex2sv*(v: PGLshort){.dynlib: dllname, importc: "glVertex2sv".}
proc glVertex3d*(x, y, z: TGLdouble){.dynlib: dllname, importc: "glVertex3d".}
proc glVertex3dv*(v: PGLdouble){.dynlib: dllname, importc: "glVertex3dv".}
proc glVertex3f*(x, y, z: TGLfloat){.dynlib: dllname, importc: "glVertex3f".}
proc glVertex3fv*(v: PGLfloat){.dynlib: dllname, importc: "glVertex3fv".}
proc glVertex3i*(x, y, z: TGLint){.dynlib: dllname, importc: "glVertex3i".}
proc glVertex3iv*(v: PGLint){.dynlib: dllname, importc: "glVertex3iv".}
proc glVertex3s*(x, y, z: TGLshort){.dynlib: dllname, importc: "glVertex3s".}
proc glVertex3sv*(v: PGLshort){.dynlib: dllname, importc: "glVertex3sv".}
proc glVertex4d*(x, y, z, w: TGLdouble){.dynlib: dllname, importc: "glVertex4d".}
proc glVertex4dv*(v: PGLdouble){.dynlib: dllname, importc: "glVertex4dv".}
proc glVertex4f*(x, y, z, w: TGLfloat){.dynlib: dllname, importc: "glVertex4f".}
proc glVertex4fv*(v: PGLfloat){.dynlib: dllname, importc: "glVertex4fv".}
proc glVertex4i*(x, y, z, w: TGLint){.dynlib: dllname, importc: "glVertex4i".}
proc glVertex4iv*(v: PGLint){.dynlib: dllname, importc: "glVertex4iv".}
proc glVertex4s*(x, y, z, w: TGLshort){.dynlib: dllname, importc: "glVertex4s".}
proc glVertex4sv*(v: PGLshort){.dynlib: dllname, importc: "glVertex4sv".}
proc glVertexPointer*(size: TGLint, atype: TGLenum, stride: TGLsizei, 
                      pointer: Pointer){.dynlib: dllname, 
    importc: "glVertexPointer".}
proc glViewport*(x, y: TGLint, width, height: TGLsizei){.dynlib: dllname, 
    importc: "glViewport".}
type 
  PfnGlarrayElementExtproc* = proc (i: TGLint)
  PfnGldrawArraysExtproc* = proc (mode: TGLenum, first: TGLint, 
                                     count: TGLsizei)
  PfnGlvertexPointerExtproc* = proc (size: TGLint, atype: TGLenum, 
                                        stride, count: TGLsizei, 
                                        pointer: Pointer)
  PfnGlnormalPointerExtproc* = proc (atype: TGLenum, stride, count: TGLsizei, 
                                        pointer: Pointer)
  PfnGlcolorPointerExtproc* = proc (size: TGLint, atype: TGLenum, 
                                       stride, count: TGLsizei, pointer: Pointer)
  PfnGlindexPointerExtproc* = proc (atype: TGLenum, stride, count: TGLsizei, 
                                       pointer: Pointer)
  PfnGltexcoordPointerExtproc* = proc (size: TGLint, atype: TGLenum, 
      stride, count: TGLsizei, pointer: Pointer)
  PfnGledgeflagPointerExtproc* = proc (stride, count: TGLsizei, 
      pointer: PGLboolean)
  PfnGlgetPointerVextProc* = proc (pname: TGLenum, params: Pointer)
  PfnGlarrayElementArrayExtproc* = proc (mode: TGLenum, count: TGLsizei, 
      pi: Pointer)            # WIN_swap_hint
  PfnGladdswaphintRectWinproc* = proc (x, y: TGLint, width, height: TGLsizei)
  PfnGlcolorTableExtproc* = proc (target, internalFormat: TGLenum, 
                                     width: TGLsizei, format, atype: TGLenum, 
                                     data: Pointer)
  PfnGlcolorSubtableExtproc* = proc (target: TGLenum, start, count: TGLsizei, 
                                        format, atype: TGLenum, data: Pointer)
  PfnGlgetcolorTableExtproc* = proc (target, format, atype: TGLenum, 
                                        data: Pointer)
  PfnGlgetcolorTableParameterIvextproc* = proc (target, pname: TGLenum, 
      params: PGLint)
  PfnGlgetcolorTableParameterFvextproc* = proc (target, pname: TGLenum, 
      params: PGLfloat)

{.pop.}
# implementation
