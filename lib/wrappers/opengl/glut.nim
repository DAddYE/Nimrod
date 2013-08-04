#
#
#  Adaption of the delphi3d.net OpenGL units to FreePascal
#  Sebastian Guenther (sg@freepascal.org) in 2002
#  These units are free to use
#

# Copyright (c) Mark J. Kilgard, 1994, 1995, 1996.
# This program is freely distributable without licensing fees  and is
#   provided without guarantee or warrantee expressed or  implied. This
#   program is -not- in the public domain.
#******************************************************************************
# Converted to Delphi by Tom Nuydens (tom@delphi3d.net)
#   Contributions by Igor Karpov (glygrik@hotbox.ru)
#   For the latest updates, visit Delphi3D: http://www.delphi3d.net
#******************************************************************************

import 
  GL

when defined(windows): 
  const 
    dllname = "glut32.dll"
elif defined(macosx): 
  const 
    dllname = "/System/Library/Frameworks/GLUT.framework/GLUT"
else: 
  const 
    dllname = "libglut.so.3"
type
  TGlutVoidCallback* = proc (){.cdecl.}
  TGlut1IntCallback* = proc (value: Cint){.cdecl.}
  TGlut2IntCallback* = proc (v1, v2: Cint){.cdecl.}
  TGlut3IntCallback* = proc (v1, v2, v3: Cint){.cdecl.}
  TGlut4IntCallback* = proc (v1, v2, v3, v4: Cint){.cdecl.}
  TGlut1Char2IntCallback* = proc (c: Int8, v1, v2: Cint){.cdecl.}
  TGlut1UInt3IntCallback* = proc (u, v1, v2, v3: Cint){.cdecl.}

const 
  GlutApiVersion* = 3
  GlutXlibImplementation* = 12 # Display mode bit masks.
  GlutRgb* = 0
  GlutRgba* = GLUT_RGB
  GlutIndex* = 1
  GlutSingle* = 0
  GlutDouble* = 2
  GlutAccum* = 4
  GlutAlpha* = 8
  GlutDepth* = 16
  GlutStencil* = 32
  GlutMultisample* = 128
  GlutStereo* = 256
  GlutLuminance* = 512       # Mouse buttons.
  GlutLeftButton* = 0
  GlutMiddleButton* = 1
  GlutRightButton* = 2      # Mouse button state.
  GlutDown* = 0
  GlutUp* = 1                # function keys
  GlutKeyF1* = 1
  GlutKeyF2* = 2
  GlutKeyF3* = 3
  GlutKeyF4* = 4
  GlutKeyF5* = 5
  GlutKeyF6* = 6
  GlutKeyF7* = 7
  GlutKeyF8* = 8
  GlutKeyF9* = 9
  GlutKeyF10* = 10
  GlutKeyF11* = 11
  GlutKeyF12* = 12          # directional keys
  GlutKeyLeft* = 100
  GlutKeyUp* = 101
  GlutKeyRight* = 102
  GlutKeyDown* = 103
  GlutKeyPageUp* = 104
  GlutKeyPageDown* = 105
  GlutKeyHome* = 106
  GlutKeyEnd* = 107
  GlutKeyInsert* = 108      # Entry/exit  state.
  GlutLeft* = 0
  GlutEntered* = 1           # Menu usage state.
  GlutMenuNotInUse* = 0
  GlutMenuInUse* = 1       # Visibility  state.
  GlutNotVisible* = 0
  GlutVisible* = 1           # Window status  state.
  GlutHidden* = 0
  GlutFullyRetained* = 1
  GlutPartiallyRetained* = 2
  GlutFullyCovered* = 3     # Color index component selection values.
  GlutRed* = 0
  GlutGreen* = 1
  GlutBlue* = 2              # Layers for use.
  GlutNormal* = 0
  GlutOverlay* = 1

when defined(Windows): 
  const                       # Stroke font constants (use these in GLUT program).
    GLUT_STROKE_ROMAN* = cast[Pointer](0)
    GLUT_STROKE_MONO_ROMAN* = cast[Pointer](1) # Bitmap font constants (use these in GLUT program).
    GLUT_BITMAP_9_BY_15* = cast[Pointer](2)
    GLUT_BITMAP_8_BY_13* = cast[Pointer](3)
    GLUT_BITMAP_TIMES_ROMAN_10* = cast[Pointer](4)
    GLUT_BITMAP_TIMES_ROMAN_24* = cast[Pointer](5)
    GLUT_BITMAP_HELVETICA_10* = cast[Pointer](6)
    GLUT_BITMAP_HELVETICA_12* = cast[Pointer](7)
    GLUT_BITMAP_HELVETICA_18* = cast[Pointer](8)
else: 
  var                         # Stroke font constants (use these in GLUT program).
    glutStrokeRoman*: Pointer
    glutStrokeMonoRoman*: Pointer # Bitmap font constants (use these in GLUT program).
    glutBitmap9By15*: Pointer
    glutBitmap8By13*: Pointer
    glutBitmapTimesRoman10*: Pointer
    glutBitmapTimesRoman24*: Pointer
    glutBitmapHelvetica10*: Pointer
    glutBitmapHelvetica12*: Pointer
    glutBitmapHelvetica18*: Pointer
const                         # glutGet parameters.
  GlutWindowX* = 100
  GlutWindowY* = 101
  GlutWindowWidth* = 102
  GlutWindowHeight* = 103
  GlutWindowBufferSize* = 104
  GlutWindowStencilSize* = 105
  GlutWindowDepthSize* = 106
  GlutWindowRedSize* = 107
  GlutWindowGreenSize* = 108
  GlutWindowBlueSize* = 109
  GlutWindowAlphaSize* = 110
  GlutWindowAccumRedSize* = 111
  GlutWindowAccumGreenSize* = 112
  GlutWindowAccumBlueSize* = 113
  GlutWindowAccumAlphaSize* = 114
  GlutWindowDoublebuffer* = 115
  GlutWindowRgba* = 116
  GlutWindowParent* = 117
  GlutWindowNumChildren* = 118
  GlutWindowColormapSize* = 119
  GlutWindowNumSamples* = 120
  GlutWindowStereo* = 121
  GlutWindowCursor* = 122
  GlutScreenWidth* = 200
  GlutScreenHeight* = 201
  GlutScreenWidthMm* = 202
  GlutScreenHeightMm* = 203
  GlutMenuNumItems* = 300
  GlutDisplayModePossible* = 400
  GlutInitWindowX* = 500
  GlutInitWindowY* = 501
  GlutInitWindowWidth* = 502
  GlutInitWindowHeight* = 503
  constGLUTINITDISPLAYMODE* = 504
  GlutElapsedTime* = 700
  GlutWindowFormatId* = 123 # glutDeviceGet parameters.
  GlutHasKeyboard* = 600
  GlutHasMouse* = 601
  GlutHasSpaceball* = 602
  GlutHasDialAndButtonBox* = 603
  GlutHasTablet* = 604
  GlutNumMouseButtons* = 605
  GlutNumSpaceballButtons* = 606
  GlutNumButtonBoxButtons* = 607
  GlutNumDials* = 608
  GlutNumTabletButtons* = 609
  GlutDeviceIgnoreKeyRepeat* = 610
  GlutDeviceKeyRepeat* = 611
  GlutHasJoystick* = 612
  GlutOwnsJoystick* = 613
  GlutJoystickButtons* = 614
  GlutJoystickAxes* = 615
  GlutJoystickPollRate* = 616 # glutLayerGet parameters.
  GlutOverlayPossible* = 800
  GlutLayerInUse* = 801
  GlutHasOverlay* = 802
  GlutTransparentIndex* = 803
  GlutNormalDamaged* = 804
  GlutOverlayDamaged* = 805 # glutVideoResizeGet parameters.
  GlutVideoResizePossible* = 900
  GlutVideoResizeInUse* = 901
  GlutVideoResizeXDelta* = 902
  GlutVideoResizeYDelta* = 903
  GlutVideoResizeWidthDelta* = 904
  GlutVideoResizeHeightDelta* = 905
  GlutVideoResizeX* = 906
  GlutVideoResizeY* = 907
  GlutVideoResizeWidth* = 908
  GlutVideoResizeHeight* = 909 # glutGetModifiers return mask.
  GlutActiveShift* = 1
  GlutActiveCtrl* = 2
  GlutActiveAlt* = 4        # glutSetCursor parameters.
                              # Basic arrows.
  GlutCursorRightArrow* = 0
  GlutCursorLeftArrow* = 1 # Symbolic cursor shapes.
  GlutCursorInfo* = 2
  GlutCursorDestroy* = 3
  GlutCursorHelp* = 4
  GlutCursorCycle* = 5
  GlutCursorSpray* = 6
  GlutCursorWait* = 7
  GlutCursorText* = 8
  GlutCursorCrosshair* = 9  # Directional cursors.
  GlutCursorUpDown* = 10
  GlutCursorLeftRight* = 11 # Sizing cursors.
  GlutCursorTopSide* = 12
  GlutCursorBottomSide* = 13
  GlutCursorLeftSide* = 14
  GlutCursorRightSide* = 15
  GlutCursorTopLeftCorner* = 16
  GlutCursorTopRightCorner* = 17
  GlutCursorBottomRightCorner* = 18
  GlutCursorBottomLeftCorner* = 19 # Inherit from parent window.
  GlutCursorInherit* = 100  # Blank cursor.
  GlutCursorNone* = 101     # Fullscreen crosshair (if available).
  GlutCursorFullCrosshair* = 102 # GLUT device control sub-API.
                                    # glutSetKeyRepeat modes.
  GlutKeyRepeatOff* = 0
  GlutKeyRepeatOn* = 1
  GlutKeyRepeatDefault* = 2 # Joystick button masks.
  GlutJoystickButtonA* = 1
  GlutJoystickButtonB* = 2
  GlutJoystickButtonC* = 4
  GlutJoystickButtonD* = 8 # GLUT game mode sub-API.
                              # glutGameModeGet.
  GlutGameModeActive* = 0
  GlutGameModePossible* = 1
  GlutGameModeWidth* = 2
  GlutGameModeHeight* = 3
  GlutGameModePixelDepth* = 4
  GlutGameModeRefreshRate* = 5
  GlutGameModeDisplayChanged* = 6 # GLUT initialization sub-API.

proc glutInit*(argcp: ptr Cint, argv: Pointer){.dynlib: dllname, 
    importc: "glutInit".}

proc glutInit*() =
  ## version that passes `argc` and `argc` implicitely.
  var
    cmdLine {.importc: "cmdLine".}: Array[0..255, Cstring]
    cmdCount {.importc: "cmdCount".}: Cint
  glutInit(addr(cmdCount), addr(cmdLine))

proc glutInitDisplayMode*(mode: Int16){.dynlib: dllname, 
                                        importc: "glutInitDisplayMode".}
proc glutInitDisplayString*(str: Cstring){.dynlib: dllname, 
    importc: "glutInitDisplayString".}
proc glutInitWindowPosition*(x, y: Int){.dynlib: dllname, 
    importc: "glutInitWindowPosition".}
proc glutInitWindowSize*(width, height: Int){.dynlib: dllname, 
    importc: "glutInitWindowSize".}
proc glutMainLoop*(){.dynlib: dllname, importc: "glutMainLoop".}
  # GLUT window sub-API.
proc glutCreateWindow*(title: Cstring): Int{.dynlib: dllname, 
    importc: "glutCreateWindow".}
proc glutCreateSubWindow*(win, x, y, width, height: Int): Int{.dynlib: dllname, 
    importc: "glutCreateSubWindow".}
proc glutDestroyWindow*(win: Int){.dynlib: dllname, importc: "glutDestroyWindow".}
proc glutPostRedisplay*(){.dynlib: dllname, importc: "glutPostRedisplay".}
proc glutPostWindowRedisplay*(win: Int){.dynlib: dllname, 
    importc: "glutPostWindowRedisplay".}
proc glutSwapBuffers*(){.dynlib: dllname, importc: "glutSwapBuffers".}
proc glutGetWindow*(): Int{.dynlib: dllname, importc: "glutGetWindow".}
proc glutSetWindow*(win: Int){.dynlib: dllname, importc: "glutSetWindow".}
proc glutSetWindowTitle*(title: Cstring){.dynlib: dllname, 
    importc: "glutSetWindowTitle".}
proc glutSetIconTitle*(title: Cstring){.dynlib: dllname, 
                                        importc: "glutSetIconTitle".}
proc glutPositionWindow*(x, y: Int){.dynlib: dllname, 
                                     importc: "glutPositionWindow".}
proc glutReshapeWindow*(width, height: Int){.dynlib: dllname, 
    importc: "glutReshapeWindow".}
proc glutPopWindow*(){.dynlib: dllname, importc: "glutPopWindow".}
proc glutPushWindow*(){.dynlib: dllname, importc: "glutPushWindow".}
proc glutIconifyWindow*(){.dynlib: dllname, importc: "glutIconifyWindow".}
proc glutShowWindow*(){.dynlib: dllname, importc: "glutShowWindow".}
proc glutHideWindow*(){.dynlib: dllname, importc: "glutHideWindow".}
proc glutFullScreen*(){.dynlib: dllname, importc: "glutFullScreen".}
proc glutSetCursor*(cursor: Int){.dynlib: dllname, importc: "glutSetCursor".}
proc glutWarpPointer*(x, y: Int){.dynlib: dllname, importc: "glutWarpPointer".}
  # GLUT overlay sub-API.
proc glutEstablishOverlay*(){.dynlib: dllname, importc: "glutEstablishOverlay".}
proc glutRemoveOverlay*(){.dynlib: dllname, importc: "glutRemoveOverlay".}
proc glutUseLayer*(layer: TGLenum){.dynlib: dllname, importc: "glutUseLayer".}
proc glutPostOverlayRedisplay*(){.dynlib: dllname, 
                                  importc: "glutPostOverlayRedisplay".}
proc glutPostWindowOverlayRedisplay*(win: Int){.dynlib: dllname, 
    importc: "glutPostWindowOverlayRedisplay".}
proc glutShowOverlay*(){.dynlib: dllname, importc: "glutShowOverlay".}
proc glutHideOverlay*(){.dynlib: dllname, importc: "glutHideOverlay".}
  # GLUT menu sub-API.
proc glutCreateMenu*(callback: TGlut1IntCallback): Int{.dynlib: dllname, 
    importc: "glutCreateMenu".}
proc glutDestroyMenu*(menu: Int){.dynlib: dllname, importc: "glutDestroyMenu".}
proc glutGetMenu*(): Int{.dynlib: dllname, importc: "glutGetMenu".}
proc glutSetMenu*(menu: Int){.dynlib: dllname, importc: "glutSetMenu".}
proc glutAddMenuEntry*(caption: Cstring, value: Int){.dynlib: dllname, 
    importc: "glutAddMenuEntry".}
proc glutAddSubMenu*(caption: Cstring, submenu: Int){.dynlib: dllname, 
    importc: "glutAddSubMenu".}
proc glutChangeToMenuEntry*(item: Int, caption: Cstring, value: Int){.
    dynlib: dllname, importc: "glutChangeToMenuEntry".}
proc glutChangeToSubMenu*(item: Int, caption: Cstring, submenu: Int){.
    dynlib: dllname, importc: "glutChangeToSubMenu".}
proc glutRemoveMenuItem*(item: Int){.dynlib: dllname, 
                                     importc: "glutRemoveMenuItem".}
proc glutAttachMenu*(button: Int){.dynlib: dllname, importc: "glutAttachMenu".}
proc glutDetachMenu*(button: Int){.dynlib: dllname, importc: "glutDetachMenu".}
  # GLUT window callback sub-API.
proc glutDisplayFunc*(f: TGlutVoidCallback){.dynlib: dllname, 
    importc: "glutDisplayFunc".}
proc glutReshapeFunc*(f: TGlut2IntCallback){.dynlib: dllname, 
    importc: "glutReshapeFunc".}
proc glutKeyboardFunc*(f: TGlut1Char2IntCallback){.dynlib: dllname, 
    importc: "glutKeyboardFunc".}
proc glutMouseFunc*(f: TGlut4IntCallback){.dynlib: dllname, 
    importc: "glutMouseFunc".}
proc glutMotionFunc*(f: TGlut2IntCallback){.dynlib: dllname, 
    importc: "glutMotionFunc".}
proc glutPassiveMotionFunc*(f: TGlut2IntCallback){.dynlib: dllname, 
    importc: "glutPassiveMotionFunc".}
proc glutEntryFunc*(f: TGlut1IntCallback){.dynlib: dllname, 
    importc: "glutEntryFunc".}
proc glutVisibilityFunc*(f: TGlut1IntCallback){.dynlib: dllname, 
    importc: "glutVisibilityFunc".}
proc glutIdleFunc*(f: TGlutVoidCallback){.dynlib: dllname, 
    importc: "glutIdleFunc".}
proc glutTimerFunc*(millis: Int16, f: TGlut1IntCallback, value: Int){.
    dynlib: dllname, importc: "glutTimerFunc".}
proc glutMenuStateFunc*(f: TGlut1IntCallback){.dynlib: dllname, 
    importc: "glutMenuStateFunc".}
proc glutSpecialFunc*(f: TGlut3IntCallback){.dynlib: dllname, 
    importc: "glutSpecialFunc".}
proc glutSpaceballMotionFunc*(f: TGlut3IntCallback){.dynlib: dllname, 
    importc: "glutSpaceballMotionFunc".}
proc glutSpaceballRotateFunc*(f: TGlut3IntCallback){.dynlib: dllname, 
    importc: "glutSpaceballRotateFunc".}
proc glutSpaceballButtonFunc*(f: TGlut2IntCallback){.dynlib: dllname, 
    importc: "glutSpaceballButtonFunc".}
proc glutButtonBoxFunc*(f: TGlut2IntCallback){.dynlib: dllname, 
    importc: "glutButtonBoxFunc".}
proc glutDialsFunc*(f: TGlut2IntCallback){.dynlib: dllname, 
    importc: "glutDialsFunc".}
proc glutTabletMotionFunc*(f: TGlut2IntCallback){.dynlib: dllname, 
    importc: "glutTabletMotionFunc".}
proc glutTabletButtonFunc*(f: TGlut4IntCallback){.dynlib: dllname, 
    importc: "glutTabletButtonFunc".}
proc glutMenuStatusFunc*(f: TGlut3IntCallback){.dynlib: dllname, 
    importc: "glutMenuStatusFunc".}
proc glutOverlayDisplayFunc*(f: TGlutVoidCallback){.dynlib: dllname, 
    importc: "glutOverlayDisplayFunc".}
proc glutWindowStatusFunc*(f: TGlut1IntCallback){.dynlib: dllname, 
    importc: "glutWindowStatusFunc".}
proc glutKeyboardUpFunc*(f: TGlut1Char2IntCallback){.dynlib: dllname, 
    importc: "glutKeyboardUpFunc".}
proc glutSpecialUpFunc*(f: TGlut3IntCallback){.dynlib: dllname, 
    importc: "glutSpecialUpFunc".}
proc glutJoystickFunc*(f: TGlut1UInt3IntCallback, pollInterval: Int){.
    dynlib: dllname, importc: "glutJoystickFunc".}
  # GLUT color index sub-API.
proc glutSetColor*(cell: Int, red, green, blue: TGLfloat){.dynlib: dllname, 
    importc: "glutSetColor".}
proc glutGetColor*(ndx, component: Int): TGLfloat{.dynlib: dllname, 
    importc: "glutGetColor".}
proc glutCopyColormap*(win: Int){.dynlib: dllname, importc: "glutCopyColormap".}
  # GLUT state retrieval sub-API.
proc glutGet*(t: TGLenum): Int{.dynlib: dllname, importc: "glutGet".}
proc glutDeviceGet*(t: TGLenum): Int{.dynlib: dllname, importc: "glutDeviceGet".}
  # GLUT extension support sub-API
proc glutExtensionSupported*(name: Cstring): Int{.dynlib: dllname, 
    importc: "glutExtensionSupported".}
proc glutGetModifiers*(): Int{.dynlib: dllname, importc: "glutGetModifiers".}
proc glutLayerGet*(t: TGLenum): Int{.dynlib: dllname, importc: "glutLayerGet".}
  # GLUT font sub-API
proc glutBitmapCharacter*(font: Pointer, character: Int){.dynlib: dllname, 
    importc: "glutBitmapCharacter".}
proc glutBitmapWidth*(font: Pointer, character: Int): Int{.dynlib: dllname, 
    importc: "glutBitmapWidth".}
proc glutStrokeCharacter*(font: Pointer, character: Int){.dynlib: dllname, 
    importc: "glutStrokeCharacter".}
proc glutStrokeWidth*(font: Pointer, character: Int): Int{.dynlib: dllname, 
    importc: "glutStrokeWidth".}
proc glutBitmapLength*(font: Pointer, str: Cstring): Int{.dynlib: dllname, 
    importc: "glutBitmapLength".}
proc glutStrokeLength*(font: Pointer, str: Cstring): Int{.dynlib: dllname, 
    importc: "glutStrokeLength".}
  # GLUT pre-built models sub-API
proc glutWireSphere*(radius: TGLdouble, slices, stacks: TGLint){.
    dynlib: dllname, importc: "glutWireSphere".}
proc glutSolidSphere*(radius: TGLdouble, slices, stacks: TGLint){.
    dynlib: dllname, importc: "glutSolidSphere".}
proc glutWireCone*(base, height: TGLdouble, slices, stacks: TGLint){.
    dynlib: dllname, importc: "glutWireCone".}
proc glutSolidCone*(base, height: TGLdouble, slices, stacks: TGLint){.
    dynlib: dllname, importc: "glutSolidCone".}
proc glutWireCube*(size: TGLdouble){.dynlib: dllname, importc: "glutWireCube".}
proc glutSolidCube*(size: TGLdouble){.dynlib: dllname, importc: "glutSolidCube".}
proc glutWireTorus*(innerRadius, outerRadius: TGLdouble, sides, rings: TGLint){.
    dynlib: dllname, importc: "glutWireTorus".}
proc glutSolidTorus*(innerRadius, outerRadius: TGLdouble, sides, rings: TGLint){.
    dynlib: dllname, importc: "glutSolidTorus".}
proc glutWireDodecahedron*(){.dynlib: dllname, importc: "glutWireDodecahedron".}
proc glutSolidDodecahedron*(){.dynlib: dllname, importc: "glutSolidDodecahedron".}
proc glutWireTeapot*(size: TGLdouble){.dynlib: dllname, 
                                       importc: "glutWireTeapot".}
proc glutSolidTeapot*(size: TGLdouble){.dynlib: dllname, 
                                        importc: "glutSolidTeapot".}
proc glutWireOctahedron*(){.dynlib: dllname, importc: "glutWireOctahedron".}
proc glutSolidOctahedron*(){.dynlib: dllname, importc: "glutSolidOctahedron".}
proc glutWireTetrahedron*(){.dynlib: dllname, importc: "glutWireTetrahedron".}
proc glutSolidTetrahedron*(){.dynlib: dllname, importc: "glutSolidTetrahedron".}
proc glutWireIcosahedron*(){.dynlib: dllname, importc: "glutWireIcosahedron".}
proc glutSolidIcosahedron*(){.dynlib: dllname, importc: "glutSolidIcosahedron".}
  # GLUT video resize sub-API.
proc glutVideoResizeGet*(param: TGLenum): Int{.dynlib: dllname, 
    importc: "glutVideoResizeGet".}
proc glutSetupVideoResizing*(){.dynlib: dllname, 
                                importc: "glutSetupVideoResizing".}
proc glutStopVideoResizing*(){.dynlib: dllname, importc: "glutStopVideoResizing".}
proc glutVideoResize*(x, y, width, height: Int){.dynlib: dllname, 
    importc: "glutVideoResize".}
proc glutVideoPan*(x, y, width, height: Int){.dynlib: dllname, 
    importc: "glutVideoPan".}
  # GLUT debugging sub-API.
proc glutReportErrors*(){.dynlib: dllname, importc: "glutReportErrors".}
  # GLUT device control sub-API.
proc glutIgnoreKeyRepeat*(ignore: Int){.dynlib: dllname, 
                                        importc: "glutIgnoreKeyRepeat".}
proc glutSetKeyRepeat*(repeatMode: Int){.dynlib: dllname, 
    importc: "glutSetKeyRepeat".}
proc glutForceJoystickFunc*(){.dynlib: dllname, importc: "glutForceJoystickFunc".}
  # GLUT game mode sub-API.
  #example glutGameModeString('1280x1024:32@75');
proc glutGameModeString*(AString: Cstring){.dynlib: dllname, 
    importc: "glutGameModeString".}
proc glutEnterGameMode*(): Int{.dynlib: dllname, importc: "glutEnterGameMode".}
proc glutLeaveGameMode*(){.dynlib: dllname, importc: "glutLeaveGameMode".}
proc glutGameModeGet*(mode: TGLenum): Int{.dynlib: dllname, 
    importc: "glutGameModeGet".}
# implementation
