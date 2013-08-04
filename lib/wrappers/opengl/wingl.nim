import 
  gl, windows

proc wglGetExtensionsStringARB*(hdc: Hdc): Cstring{.dynlib: dllname, 
    importc: "wglGetExtensionsStringARB".}
const 
  WglFrontColorBufferBitArb* = 0x00000001
  WglBackColorBufferBitArb* = 0x00000002
  WglDepthBufferBitArb* = 0x00000004
  WglStencilBufferBitArb* = 0x00000008

proc winChoosePixelFormat*(DC: Hdc, p2: Ppixelformatdescriptor): Int{.
    dynlib: "gdi32", importc: "ChoosePixelFormat".}
proc wglCreateBufferRegionARB*(hDC: Hdc, iLayerPlane: TGLint, uType: TGLuint): THandle{.
    dynlib: dllname, importc: "wglCreateBufferRegionARB".}
proc wglDeleteBufferRegionARB*(hRegion: THandle){.dynlib: dllname, 
    importc: "wglDeleteBufferRegionARB".}
proc wglSaveBufferRegionARB*(hRegion: THandle, x: TGLint, y: TGLint, 
                             width: TGLint, height: TGLint): Bool{.
    dynlib: dllname, importc: "wglSaveBufferRegionARB".}
proc wglRestoreBufferRegionARB*(hRegion: THandle, x: TGLint, y: TGLint, 
                                width: TGLint, height: TGLint, xSrc: TGLint, 
                                ySrc: TGLint): Bool{.dynlib: dllname, 
    importc: "wglRestoreBufferRegionARB".}
proc wglAllocateMemoryNV*(size: TGLsizei, readFrequency: TGLfloat, 
                          writeFrequency: TGLfloat, priority: TGLfloat): PGLvoid{.
    dynlib: dllname, importc: "wglAllocateMemoryNV".}
proc wglFreeMemoryNV*(pointer: PGLvoid){.dynlib: dllname, 
    importc: "wglFreeMemoryNV".}
const 
  WglImageBufferMinAccessI3d* = 0x00000001
  WglImageBufferLockI3d* = 0x00000002

proc wglCreateImageBufferI3D*(hDC: Hdc, dwSize: Dword, uFlags: Uint): PGLvoid{.
    dynlib: dllname, importc: "wglCreateImageBufferI3D".}
proc wglDestroyImageBufferI3D*(hDC: Hdc, pAddress: PGLvoid): Bool{.
    dynlib: dllname, importc: "wglDestroyImageBufferI3D".}
proc wglAssociateImageBufferEventsI3D*(hdc: Hdc, pEvent: Phandle, 
                                       pAddress: PGLvoid, pSize: Pdword, 
                                       count: Uint): Bool{.dynlib: dllname, 
    importc: "wglAssociateImageBufferEventsI3D".}
proc wglReleaseImageBufferEventsI3D*(hdc: Hdc, pAddress: PGLvoid, count: Uint): Bool{.
    dynlib: dllname, importc: "wglReleaseImageBufferEventsI3D".}
proc wglEnableFrameLockI3D*(): Bool{.dynlib: dllname, 
                                     importc: "wglEnableFrameLockI3D".}
proc wglDisableFrameLockI3D*(): Bool{.dynlib: dllname, 
                                      importc: "wglDisableFrameLockI3D".}
proc wglIsEnabledFrameLockI3D*(pFlag: Pbool): Bool{.dynlib: dllname, 
    importc: "wglIsEnabledFrameLockI3D".}
proc wglQueryFrameLockMasterI3D*(pFlag: Pbool): Bool{.dynlib: dllname, 
    importc: "wglQueryFrameLockMasterI3D".}
proc wglGetFrameUsageI3D*(pUsage: PGLfloat): Bool{.dynlib: dllname, 
    importc: "wglGetFrameUsageI3D".}
proc wglBeginFrameTrackingI3D*(): Bool{.dynlib: dllname, 
                                        importc: "wglBeginFrameTrackingI3D".}
proc wglEndFrameTrackingI3D*(): Bool{.dynlib: dllname, 
                                      importc: "wglEndFrameTrackingI3D".}
proc wglQueryFrameTrackingI3D*(pFrameCount: Pdword, pMissedFrames: Pdword, 
                               pLastMissedUsage: PGLfloat): Bool{.
    dynlib: dllname, importc: "wglQueryFrameTrackingI3D".}
const 
  WglNumberPixelFormatsArb* = 0x00002000
  WglDrawToWindowArb* = 0x00002001
  WglDrawToBitmapArb* = 0x00002002
  WglAccelerationArb* = 0x00002003
  WglNeedPaletteArb* = 0x00002004
  WglNeedSystemPaletteArb* = 0x00002005
  WglSwapLayerBuffersArb* = 0x00002006
  WglSwapMethodArb* = 0x00002007
  WglNumberOverlaysArb* = 0x00002008
  WglNumberUnderlaysArb* = 0x00002009
  WglTransparentArb* = 0x0000200A
  WglTransparentRedValueArb* = 0x00002037
  WglTransparentGreenValueArb* = 0x00002038
  WglTransparentBlueValueArb* = 0x00002039
  WglTransparentAlphaValueArb* = 0x0000203A
  WglTransparentIndexValueArb* = 0x0000203B
  WglShareDepthArb* = 0x0000200C
  WglShareStencilArb* = 0x0000200D
  WglShareAccumArb* = 0x0000200E
  WglSupportGdiArb* = 0x0000200F
  WglSupportOpenglArb* = 0x00002010
  WglDoubleBufferArb* = 0x00002011
  WglStereoArb* = 0x00002012
  WglPixelTypeArb* = 0x00002013
  WglColorBitsArb* = 0x00002014
  WglRedBitsArb* = 0x00002015
  WglRedShiftArb* = 0x00002016
  WglGreenBitsArb* = 0x00002017
  WglGreenShiftArb* = 0x00002018
  WglBlueBitsArb* = 0x00002019
  WglBlueShiftArb* = 0x0000201A
  WglAlphaBitsArb* = 0x0000201B
  WglAlphaShiftArb* = 0x0000201C
  WglAccumBitsArb* = 0x0000201D
  WglAccumRedBitsArb* = 0x0000201E
  WglAccumGreenBitsArb* = 0x0000201F
  WglAccumBlueBitsArb* = 0x00002020
  WglAccumAlphaBitsArb* = 0x00002021
  WglDepthBitsArb* = 0x00002022
  WglStencilBitsArb* = 0x00002023
  WglAuxBuffersArb* = 0x00002024
  WglNoAccelerationArb* = 0x00002025
  WglGenericAccelerationArb* = 0x00002026
  WglFullAccelerationArb* = 0x00002027
  WglSwapExchangeArb* = 0x00002028
  WglSwapCopyArb* = 0x00002029
  WglSwapUndefinedArb* = 0x0000202A
  WglTypeRgbaArb* = 0x0000202B
  WglTypeColorindexArb* = 0x0000202C

proc wglGetPixelFormatAttribivARB*(hdc: Hdc, iPixelFormat: TGLint, 
                                   iLayerPlane: TGLint, nAttributes: TGLuint, 
                                   piAttributes: PGLint, piValues: PGLint): Bool{.
    dynlib: dllname, importc: "wglGetPixelFormatAttribivARB".}
proc wglGetPixelFormatAttribfvARB*(hdc: Hdc, iPixelFormat: TGLint, 
                                   iLayerPlane: TGLint, nAttributes: TGLuint, 
                                   piAttributes: PGLint, pfValues: PGLfloat): Bool{.
    dynlib: dllname, importc: "wglGetPixelFormatAttribfvARB".}
proc wglChoosePixelFormatARB*(hdc: Hdc, piAttribIList: PGLint, 
                              pfAttribFList: PGLfloat, nMaxFormats: TGLuint, 
                              piFormats: PGLint, nNumFormats: PGLuint): Bool{.
    dynlib: dllname, importc: "wglChoosePixelFormatARB".}
const 
  WglErrorInvalidPixelTypeArb* = 0x00002043
  WglErrorIncompatibleDeviceContextsArb* = 0x00002054

proc wglMakeContextCurrentARB*(hDrawDC: Hdc, hReadDC: Hdc, hglrc: Hglrc): Bool{.
    dynlib: dllname, importc: "wglMakeContextCurrentARB".}
proc wglGetCurrentReadDCARB*(): Hdc{.dynlib: dllname, 
                                     importc: "wglGetCurrentReadDCARB".}
const 
  WglDrawToPbufferArb* = 0x0000202D # WGL_DRAW_TO_PBUFFER_ARB  { already defined }
  WglMaxPbufferPixelsArb* = 0x0000202E
  WglMaxPbufferWidthArb* = 0x0000202F
  WglMaxPbufferHeightArb* = 0x00002030
  WglPbufferLargestArb* = 0x00002033
  WglPbufferWidthArb* = 0x00002034
  WglPbufferHeightArb* = 0x00002035
  WglPbufferLostArb* = 0x00002036

proc wglCreatePbufferARB*(hDC: Hdc, iPixelFormat: TGLint, iWidth: TGLint, 
                          iHeight: TGLint, piAttribList: PGLint): THandle{.
    dynlib: dllname, importc: "wglCreatePbufferARB".}
proc wglGetPbufferDCARB*(hPbuffer: THandle): Hdc{.dynlib: dllname, 
    importc: "wglGetPbufferDCARB".}
proc wglReleasePbufferDCARB*(hPbuffer: THandle, hDC: Hdc): TGLint{.
    dynlib: dllname, importc: "wglReleasePbufferDCARB".}
proc wglDestroyPbufferARB*(hPbuffer: THandle): Bool{.dynlib: dllname, 
    importc: "wglDestroyPbufferARB".}
proc wglQueryPbufferARB*(hPbuffer: THandle, iAttribute: TGLint, piValue: PGLint): Bool{.
    dynlib: dllname, importc: "wglQueryPbufferARB".}
proc wglSwapIntervalEXT*(interval: TGLint): Bool{.dynlib: dllname, 
    importc: "wglSwapIntervalEXT".}
proc wglGetSwapIntervalEXT*(): TGLint{.dynlib: dllname, 
                                       importc: "wglGetSwapIntervalEXT".}
const 
  WglBindToTextureRgbArb* = 0x00002070
  WglBindToTextureRgbaArb* = 0x00002071
  WglTextureFormatArb* = 0x00002072
  WglTextureTargetArb* = 0x00002073
  WglMipmapTextureArb* = 0x00002074
  WglTextureRgbArb* = 0x00002075
  WglTextureRgbaArb* = 0x00002076
  WglNoTextureArb* = 0x00002077
  WglTextureCubeMapArb* = 0x00002078
  WglTexture1dArb* = 0x00002079
  WglTexture2dArb* = 0x0000207A # WGL_NO_TEXTURE_ARB  { already defined }
  WglMipmapLevelArb* = 0x0000207B
  WglCubeMapFaceArb* = 0x0000207C
  WglTextureCubeMapPositiveXArb* = 0x0000207D
  WglTextureCubeMapNegativeXArb* = 0x0000207E
  WglTextureCubeMapPositiveYArb* = 0x0000207F
  WglTextureCubeMapNegativeYArb* = 0x00002080
  WglTextureCubeMapPositiveZArb* = 0x00002081
  WglTextureCubeMapNegativeZArb* = 0x00002082
  WglFrontLeftArb* = 0x00002083
  WglFrontRightArb* = 0x00002084
  WglBackLeftArb* = 0x00002085
  WglBackRightArb* = 0x00002086
  WglAux0Arb* = 0x00002087
  WglAux1Arb* = 0x00002088
  WglAux2Arb* = 0x00002089
  WglAux3Arb* = 0x0000208A
  WglAux4Arb* = 0x0000208B
  WglAux5Arb* = 0x0000208C
  WglAux6Arb* = 0x0000208D
  WglAux7Arb* = 0x0000208E
  WglAux8Arb* = 0x0000208F
  WglAux9Arb* = 0x00002090

proc wglBindTexImageARB*(hPbuffer: THandle, iBuffer: TGLint): Bool{.
    dynlib: dllname, importc: "wglBindTexImageARB".}
proc wglReleaseTexImageARB*(hPbuffer: THandle, iBuffer: TGLint): Bool{.
    dynlib: dllname, importc: "wglReleaseTexImageARB".}
proc wglSetPbufferAttribARB*(hPbuffer: THandle, piAttribList: PGLint): Bool{.
    dynlib: dllname, importc: "wglSetPbufferAttribARB".}
proc wglGetExtensionsStringEXT*(): Cstring{.dynlib: dllname, 
    importc: "wglGetExtensionsStringEXT".}
proc wglMakeContextCurrentEXT*(hDrawDC: Hdc, hReadDC: Hdc, hglrc: Hglrc): Bool{.
    dynlib: dllname, importc: "wglMakeContextCurrentEXT".}
proc wglGetCurrentReadDCEXT*(): Hdc{.dynlib: dllname, 
                                     importc: "wglGetCurrentReadDCEXT".}
const 
  WglDrawToPbufferExt* = 0x0000202D
  WglMaxPbufferPixelsExt* = 0x0000202E
  WglMaxPbufferWidthExt* = 0x0000202F
  WglMaxPbufferHeightExt* = 0x00002030
  WglOptimalPbufferWidthExt* = 0x00002031
  WglOptimalPbufferHeightExt* = 0x00002032
  WglPbufferLargestExt* = 0x00002033
  WglPbufferWidthExt* = 0x00002034
  WglPbufferHeightExt* = 0x00002035

proc wglCreatePbufferEXT*(hDC: Hdc, iPixelFormat: TGLint, iWidth: TGLint, 
                          iHeight: TGLint, piAttribList: PGLint): THandle{.
    dynlib: dllname, importc: "wglCreatePbufferEXT".}
proc wglGetPbufferDCEXT*(hPbuffer: THandle): Hdc{.dynlib: dllname, 
    importc: "wglGetPbufferDCEXT".}
proc wglReleasePbufferDCEXT*(hPbuffer: THandle, hDC: Hdc): TGLint{.
    dynlib: dllname, importc: "wglReleasePbufferDCEXT".}
proc wglDestroyPbufferEXT*(hPbuffer: THandle): Bool{.dynlib: dllname, 
    importc: "wglDestroyPbufferEXT".}
proc wglQueryPbufferEXT*(hPbuffer: THandle, iAttribute: TGLint, piValue: PGLint): Bool{.
    dynlib: dllname, importc: "wglQueryPbufferEXT".}
const 
  WglNumberPixelFormatsExt* = 0x00002000
  WglDrawToWindowExt* = 0x00002001
  WglDrawToBitmapExt* = 0x00002002
  WglAccelerationExt* = 0x00002003
  WglNeedPaletteExt* = 0x00002004
  WglNeedSystemPaletteExt* = 0x00002005
  WglSwapLayerBuffersExt* = 0x00002006
  WglSwapMethodExt* = 0x00002007
  WglNumberOverlaysExt* = 0x00002008
  WglNumberUnderlaysExt* = 0x00002009
  WglTransparentExt* = 0x0000200A
  WglTransparentValueExt* = 0x0000200B
  WglShareDepthExt* = 0x0000200C
  WglShareStencilExt* = 0x0000200D
  WglShareAccumExt* = 0x0000200E
  WglSupportGdiExt* = 0x0000200F
  WglSupportOpenglExt* = 0x00002010
  WglDoubleBufferExt* = 0x00002011
  WglStereoExt* = 0x00002012
  WglPixelTypeExt* = 0x00002013
  WglColorBitsExt* = 0x00002014
  WglRedBitsExt* = 0x00002015
  WglRedShiftExt* = 0x00002016
  WglGreenBitsExt* = 0x00002017
  WglGreenShiftExt* = 0x00002018
  WglBlueBitsExt* = 0x00002019
  WglBlueShiftExt* = 0x0000201A
  WglAlphaBitsExt* = 0x0000201B
  WglAlphaShiftExt* = 0x0000201C
  WglAccumBitsExt* = 0x0000201D
  WglAccumRedBitsExt* = 0x0000201E
  WglAccumGreenBitsExt* = 0x0000201F
  WglAccumBlueBitsExt* = 0x00002020
  WglAccumAlphaBitsExt* = 0x00002021
  WglDepthBitsExt* = 0x00002022
  WglStencilBitsExt* = 0x00002023
  WglAuxBuffersExt* = 0x00002024
  WglNoAccelerationExt* = 0x00002025
  WglGenericAccelerationExt* = 0x00002026
  WglFullAccelerationExt* = 0x00002027
  WglSwapExchangeExt* = 0x00002028
  WglSwapCopyExt* = 0x00002029
  WglSwapUndefinedExt* = 0x0000202A
  WglTypeRgbaExt* = 0x0000202B
  WglTypeColorindexExt* = 0x0000202C

proc wglGetPixelFormatAttribivEXT*(hdc: Hdc, iPixelFormat: TGLint, 
                                   iLayerPlane: TGLint, nAttributes: TGLuint, 
                                   piAttributes: PGLint, piValues: PGLint): Bool{.
    dynlib: dllname, importc: "wglGetPixelFormatAttribivEXT".}
proc wglGetPixelFormatAttribfvEXT*(hdc: Hdc, iPixelFormat: TGLint, 
                                   iLayerPlane: TGLint, nAttributes: TGLuint, 
                                   piAttributes: PGLint, pfValues: PGLfloat): Bool{.
    dynlib: dllname, importc: "wglGetPixelFormatAttribfvEXT".}
proc wglChoosePixelFormatEXT*(hdc: Hdc, piAttribIList: PGLint, 
                              pfAttribFList: PGLfloat, nMaxFormats: TGLuint, 
                              piFormats: PGLint, nNumFormats: PGLuint): Bool{.
    dynlib: dllname, importc: "wglChoosePixelFormatEXT".}
const 
  WglDigitalVideoCursorAlphaFramebufferI3d* = 0x00002050
  WglDigitalVideoCursorAlphaValueI3d* = 0x00002051
  WglDigitalVideoCursorIncludedI3d* = 0x00002052
  WglDigitalVideoGammaCorrectedI3d* = 0x00002053

proc wglGetDigitalVideoParametersI3D*(hDC: Hdc, iAttribute: TGLint, 
                                      piValue: PGLint): Bool{.dynlib: dllname, 
    importc: "wglGetDigitalVideoParametersI3D".}
proc wglSetDigitalVideoParametersI3D*(hDC: Hdc, iAttribute: TGLint, 
                                      piValue: PGLint): Bool{.dynlib: dllname, 
    importc: "wglSetDigitalVideoParametersI3D".}
const 
  WglGammaTableSizeI3d* = 0x0000204E
  WglGammaExcludeDesktopI3d* = 0x0000204F

proc wglGetGammaTableParametersI3D*(hDC: Hdc, iAttribute: TGLint, 
                                    piValue: PGLint): Bool{.dynlib: dllname, 
    importc: "wglGetGammaTableParametersI3D".}
proc wglSetGammaTableParametersI3D*(hDC: Hdc, iAttribute: TGLint, 
                                    piValue: PGLint): Bool{.dynlib: dllname, 
    importc: "wglSetGammaTableParametersI3D".}
proc wglGetGammaTableI3D*(hDC: Hdc, iEntries: TGLint, puRed: PGLushort, 
                          puGreen: PGLushort, puBlue: PGLushort): Bool{.
    dynlib: dllname, importc: "wglGetGammaTableI3D".}
proc wglSetGammaTableI3D*(hDC: Hdc, iEntries: TGLint, puRed: PGLushort, 
                          puGreen: PGLushort, puBlue: PGLushort): Bool{.
    dynlib: dllname, importc: "wglSetGammaTableI3D".}
const 
  WglGenlockSourceMultiviewI3d* = 0x00002044
  WglGenlockSourceExternalSyncI3d* = 0x00002045
  WglGenlockSourceExternalFieldI3d* = 0x00002046
  WglGenlockSourceExternalTtlI3d* = 0x00002047
  WglGenlockSourceDigitalSyncI3d* = 0x00002048
  WglGenlockSourceDigitalFieldI3d* = 0x00002049
  WglGenlockSourceEdgeFallingI3d* = 0x0000204A
  WglGenlockSourceEdgeRisingI3d* = 0x0000204B
  WglGenlockSourceEdgeBothI3d* = 0x0000204C
  WglFloatComponentsNv* = 0x000020B0
  WglBindToTextureRectangleFloatRNv* = 0x000020B1
  WglBindToTextureRectangleFloatRgNv* = 0x000020B2
  WglBindToTextureRectangleFloatRgbNv* = 0x000020B3
  WglBindToTextureRectangleFloatRgbaNv* = 0x000020B4
  WglTextureFloatRNv* = 0x000020B5
  WglTextureFloatRgNv* = 0x000020B6
  WglTextureFloatRgbNv* = 0x000020B7
  WglTextureFloatRgbaNv* = 0x000020B8

proc wglEnableGenlockI3D*(hDC: Hdc): Bool{.dynlib: dllname, 
    importc: "wglEnableGenlockI3D".}
proc wglDisableGenlockI3D*(hDC: Hdc): Bool{.dynlib: dllname, 
    importc: "wglDisableGenlockI3D".}
proc wglIsEnabledGenlockI3D*(hDC: Hdc, pFlag: Pbool): Bool{.dynlib: dllname, 
    importc: "wglIsEnabledGenlockI3D".}
proc wglGenlockSourceI3D*(hDC: Hdc, uSource: TGLuint): Bool{.dynlib: dllname, 
    importc: "wglGenlockSourceI3D".}
proc wglGetGenlockSourceI3D*(hDC: Hdc, uSource: PGLuint): Bool{.dynlib: dllname, 
    importc: "wglGetGenlockSourceI3D".}
proc wglGenlockSourceEdgeI3D*(hDC: Hdc, uEdge: TGLuint): Bool{.dynlib: dllname, 
    importc: "wglGenlockSourceEdgeI3D".}
proc wglGetGenlockSourceEdgeI3D*(hDC: Hdc, uEdge: PGLuint): Bool{.
    dynlib: dllname, importc: "wglGetGenlockSourceEdgeI3D".}
proc wglGenlockSampleRateI3D*(hDC: Hdc, uRate: TGLuint): Bool{.dynlib: dllname, 
    importc: "wglGenlockSampleRateI3D".}
proc wglGetGenlockSampleRateI3D*(hDC: Hdc, uRate: PGLuint): Bool{.
    dynlib: dllname, importc: "wglGetGenlockSampleRateI3D".}
proc wglGenlockSourceDelayI3D*(hDC: Hdc, uDelay: TGLuint): Bool{.
    dynlib: dllname, importc: "wglGenlockSourceDelayI3D".}
proc wglGetGenlockSourceDelayI3D*(hDC: Hdc, uDelay: PGLuint): Bool{.
    dynlib: dllname, importc: "wglGetGenlockSourceDelayI3D".}
proc wglQueryGenlockMaxSourceDelayI3D*(hDC: Hdc, uMaxLineDelay: PGLuint, 
                                       uMaxPixelDelay: PGLuint): Bool{.
    dynlib: dllname, importc: "wglQueryGenlockMaxSourceDelayI3D".}
const 
  WglBindToTextureRectangleRgbNv* = 0x000020A0
  WglBindToTextureRectangleRgbaNv* = 0x000020A1
  WglTextureRectangleNv* = 0x000020A2

const 
  WglRgbaFloatModeAti* = 0x00008820
  WglColorClearUnclampedValueAti* = 0x00008835
  WglTypeRgbaFloatAti* = 0x000021A0

# implementation
