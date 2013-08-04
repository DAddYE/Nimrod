#
#Converted from X11/keysym.h and X11/keysymdef.h
#
#Capital letter consts renamed from XK_... to XKc_...
# (since Pascal isn't case-sensitive)
#
#i.e.
#C      Pascal
#XK_a   XK_a
#XK_A   XKc_A
#

#* default keysyms *

const 
  XKVoidSymbol* = 0x00FFFFFF # void symbol 

when defined(XK_MISCELLANY) or true: 
  const
    #*
    # * TTY Functions, cleverly chosen to map to ascii, for convenience of
    # * programming, but could have been arbitrary (at the cost of lookup
    # * tables in client code.
    # *
    XKBackSpace* = 0x0000FF08  # back space, back char 
    XKTab* = 0x0000FF09
    XKLinefeed* = 0x0000FF0A   # Linefeed, LF 
    XKClear* = 0x0000FF0B
    XKReturn* = 0x0000FF0D     # Return, enter 
    XKPause* = 0x0000FF13      # Pause, hold 
    XKScrollLock* = 0x0000FF14
    XKSysReq* = 0x0000FF15
    XKEscape* = 0x0000FF1B
    XKDelete* = 0x0000FFFF     # Delete, rubout 
                                # International & multi-key character composition 
    XKMultiKey* = 0x0000FF20  # Multi-key character compose 
    XKCodeinput* = 0x0000FF37
    XKSingleCandidate* = 0x0000FF3C
    XKMultipleCandidate* = 0x0000FF3D
    XKPreviousCandidate* = 0x0000FF3E # Japanese keyboard support 
    XKKanji* = 0x0000FF21      # Kanji, Kanji convert 
    XKMuhenkan* = 0x0000FF22   # Cancel Conversion 
    XKHenkanMode* = 0x0000FF23 # Start/Stop Conversion 
    XKHenkan* = 0x0000FF23     # Alias for Henkan_Mode 
    XKRomaji* = 0x0000FF24     # to Romaji 
    XKHiragana* = 0x0000FF25   # to Hiragana 
    XKKatakana* = 0x0000FF26   # to Katakana 
    XKHiraganaKatakana* = 0x0000FF27 # Hiragana/Katakana toggle 
    XKZenkaku* = 0x0000FF28    # to Zenkaku 
    XKHankaku* = 0x0000FF29    # to Hankaku 
    XKZenkakuHankaku* = 0x0000FF2A # Zenkaku/Hankaku toggle 
    XKTouroku* = 0x0000FF2B    # Add to Dictionary 
    XKMassyo* = 0x0000FF2C     # Delete from Dictionary 
    XKKanaLock* = 0x0000FF2D  # Kana Lock 
    XKKanaShift* = 0x0000FF2E # Kana Shift 
    XKEisuShift* = 0x0000FF2F # Alphanumeric Shift 
    XKEisuToggle* = 0x0000FF30 # Alphanumeric toggle 
    XKKanjiBangou* = 0x0000FF37 # Codeinput 
    XKZenKoho* = 0x0000FF3D   # Multiple/All Candidate(s) 
    XKMaeKoho* = 0x0000FF3E   # Previous Candidate 
                                # = $FF31 thru = $FF3F are under XK_KOREAN 
                                # Cursor control & motion 
    XKHome* = 0x0000FF50
    XKLeft* = 0x0000FF51       # Move left, left arrow 
    XKUp* = 0x0000FF52         # Move up, up arrow 
    XKRight* = 0x0000FF53      # Move right, right arrow 
    XKDown* = 0x0000FF54       # Move down, down arrow 
    XKPrior* = 0x0000FF55      # Prior, previous 
    XKPageUp* = 0x0000FF55
    XKNext* = 0x0000FF56       # Next 
    XKPageDown* = 0x0000FF56
    XKEnd* = 0x0000FF57        # EOL 
    XKBegin* = 0x0000FF58      # BOL 
                                # Misc Functions 
    XKSelect* = 0x0000FF60     # Select, mark 
    XKPrint* = 0x0000FF61
    XKExecute* = 0x0000FF62    # Execute, run, do 
    XKInsert* = 0x0000FF63     # Insert, insert here 
    XKUndo* = 0x0000FF65       # Undo, oops 
    XKRedo* = 0x0000FF66       # redo, again 
    XKMenu* = 0x0000FF67
    XKFind* = 0x0000FF68       # Find, search 
    XKCancel* = 0x0000FF69     # Cancel, stop, abort, exit 
    XKHelp* = 0x0000FF6A       # Help 
    XKBreak* = 0x0000FF6B
    XKModeSwitch* = 0x0000FF7E # Character set switch 
    XKScriptSwitch* = 0x0000FF7E # Alias for mode_switch 
    XKNumLock* = 0x0000FF7F   # Keypad Functions, keypad numbers cleverly chosen to map to ascii 
    XKKPSpace* = 0x0000FF80   # space 
    XKKPTab* = 0x0000FF89
    XKKPEnter* = 0x0000FF8D   # enter 
    XkKpF1* = 0x0000FF91      # PF1, KP_A, ... 
    XkKpF2* = 0x0000FF92
    XkKpF3* = 0x0000FF93
    XkKpF4* = 0x0000FF94
    XKKPHome* = 0x0000FF95
    XKKPLeft* = 0x0000FF96
    XKKPUp* = 0x0000FF97
    XKKPRight* = 0x0000FF98
    XKKPDown* = 0x0000FF99
    XKKPPrior* = 0x0000FF9A
    XKKPPageUp* = 0x0000FF9A
    XKKPNext* = 0x0000FF9B
    XKKPPageDown* = 0x0000FF9B
    XKKPEnd* = 0x0000FF9C
    XKKPBegin* = 0x0000FF9D
    XKKPInsert* = 0x0000FF9E
    XKKPDelete* = 0x0000FF9F
    XKKPEqual* = 0x0000FFBD   # equals 
    XKKPMultiply* = 0x0000FFAA
    XKKPAdd* = 0x0000FFAB
    XKKPSeparator* = 0x0000FFAC # separator, often comma 
    XKKPSubtract* = 0x0000FFAD
    XKKPDecimal* = 0x0000FFAE
    XKKPDivide* = 0x0000FFAF
    XkKp0* = 0x0000FFB0
    XkKp1* = 0x0000FFB1
    XkKp2* = 0x0000FFB2
    XkKp3* = 0x0000FFB3
    XkKp4* = 0x0000FFB4
    XkKp5* = 0x0000FFB5
    XkKp6* = 0x0000FFB6
    XkKp7* = 0x0000FFB7
    XkKp8* = 0x0000FFB8
    XkKp9* = 0x0000FFB9 #*
                          # * Auxilliary Functions; note the duplicate definitions for left and right
                          # * function keys;  Sun keyboards and a few other manufactures have such
                          # * function key groups on the left and/or right sides of the keyboard.
                          # * We've not found a keyboard with more than 35 function keys total.
                          # *
    XkF1* = 0x0000FFBE
    XkF2* = 0x0000FFBF
    XkF3* = 0x0000FFC0
    XkF4* = 0x0000FFC1
    XkF5* = 0x0000FFC2
    XkF6* = 0x0000FFC3
    XkF7* = 0x0000FFC4
    XkF8* = 0x0000FFC5
    XkF9* = 0x0000FFC6
    XkF10* = 0x0000FFC7
    XkF11* = 0x0000FFC8
    XkL1* = 0x0000FFC8
    XkF12* = 0x0000FFC9
    XkL2* = 0x0000FFC9
    XkF13* = 0x0000FFCA
    XkL3* = 0x0000FFCA
    XkF14* = 0x0000FFCB
    XkL4* = 0x0000FFCB
    XkF15* = 0x0000FFCC
    XkL5* = 0x0000FFCC
    XkF16* = 0x0000FFCD
    XkL6* = 0x0000FFCD
    XkF17* = 0x0000FFCE
    XkL7* = 0x0000FFCE
    XkF18* = 0x0000FFCF
    XkL8* = 0x0000FFCF
    XkF19* = 0x0000FFD0
    XkL9* = 0x0000FFD0
    XkF20* = 0x0000FFD1
    XkL10* = 0x0000FFD1
    XkF21* = 0x0000FFD2
    XkR1* = 0x0000FFD2
    XkF22* = 0x0000FFD3
    XkR2* = 0x0000FFD3
    XkF23* = 0x0000FFD4
    XkR3* = 0x0000FFD4
    XkF24* = 0x0000FFD5
    XkR4* = 0x0000FFD5
    XkF25* = 0x0000FFD6
    XkR5* = 0x0000FFD6
    XkF26* = 0x0000FFD7
    XkR6* = 0x0000FFD7
    XkF27* = 0x0000FFD8
    XkR7* = 0x0000FFD8
    XkF28* = 0x0000FFD9
    XkR8* = 0x0000FFD9
    XkF29* = 0x0000FFDA
    XkR9* = 0x0000FFDA
    XkF30* = 0x0000FFDB
    XkR10* = 0x0000FFDB
    XkF31* = 0x0000FFDC
    XkR11* = 0x0000FFDC
    XkF32* = 0x0000FFDD
    XkR12* = 0x0000FFDD
    XkF33* = 0x0000FFDE
    XkR13* = 0x0000FFDE
    XkF34* = 0x0000FFDF
    XkR14* = 0x0000FFDF
    XkF35* = 0x0000FFE0
    XkR15* = 0x0000FFE0        # Modifiers 
    XKShiftL* = 0x0000FFE1    # Left shift 
    XKShiftR* = 0x0000FFE2    # Right shift 
    XKControlL* = 0x0000FFE3  # Left control 
    XKControlR* = 0x0000FFE4  # Right control 
    XKCapsLock* = 0x0000FFE5  # Caps lock 
    XKShiftLock* = 0x0000FFE6 # Shift lock 
    XKMetaL* = 0x0000FFE7     # Left meta 
    XKMetaR* = 0x0000FFE8     # Right meta 
    XKAltL* = 0x0000FFE9      # Left alt 
    XKAltR* = 0x0000FFEA      # Right alt 
    XKSuperL* = 0x0000FFEB    # Left super 
    XKSuperR* = 0x0000FFEC    # Right super 
    XKHyperL* = 0x0000FFED    # Left hyper 
    XKHyperR* = 0x0000FFEE    # Right hyper 
# XK_MISCELLANY 
#*
# * ISO 9995 Function and Modifier Keys
# * Byte 3 = = $FE
# *

when defined(XK_XKB_KEYS) or true: 
  const
    XKISOLock* = 0x0000FE01
    XKISOLevel2Latch* = 0x0000FE02
    XKISOLevel3Shift* = 0x0000FE03
    XKISOLevel3Latch* = 0x0000FE04
    XKISOLevel3Lock* = 0x0000FE05
    XKISOGroupShift* = 0x0000FF7E # Alias for mode_switch 
    XKISOGroupLatch* = 0x0000FE06
    XKISOGroupLock* = 0x0000FE07
    XKISONextGroup* = 0x0000FE08
    XKISONextGroupLock* = 0x0000FE09
    XKISOPrevGroup* = 0x0000FE0A
    XKISOPrevGroupLock* = 0x0000FE0B
    XKISOFirstGroup* = 0x0000FE0C
    XKISOFirstGroupLock* = 0x0000FE0D
    XKISOLastGroup* = 0x0000FE0E
    XKISOLastGroupLock* = 0x0000FE0F
    XKISOLeftTab* = 0x0000FE20
    XKISOMoveLineUp* = 0x0000FE21
    XKISOMoveLineDown* = 0x0000FE22
    XKISOPartialLineUp* = 0x0000FE23
    XKISOPartialLineDown* = 0x0000FE24
    XKISOPartialSpaceLeft* = 0x0000FE25
    XKISOPartialSpaceRight* = 0x0000FE26
    XKISOSetMarginLeft* = 0x0000FE27
    XKISOSetMarginRight* = 0x0000FE28
    XKISOReleaseMarginLeft* = 0x0000FE29
    XKISOReleaseMarginRight* = 0x0000FE2A
    XKISOReleaseBothMargins* = 0x0000FE2B
    XKISOFastCursorLeft* = 0x0000FE2C
    XKISOFastCursorRight* = 0x0000FE2D
    XKISOFastCursorUp* = 0x0000FE2E
    XKISOFastCursorDown* = 0x0000FE2F
    XKISOContinuousUnderline* = 0x0000FE30
    XKISODiscontinuousUnderline* = 0x0000FE31
    XKISOEmphasize* = 0x0000FE32
    XKISOCenterObject* = 0x0000FE33
    XKISOEnter* = 0x0000FE34
    XKDeadGrave* = 0x0000FE50
    XKDeadAcute* = 0x0000FE51
    XKDeadCircumflex* = 0x0000FE52
    XKDeadTilde* = 0x0000FE53
    XKDeadMacron* = 0x0000FE54
    XKDeadBreve* = 0x0000FE55
    XKDeadAbovedot* = 0x0000FE56
    XKDeadDiaeresis* = 0x0000FE57
    XKDeadAbovering* = 0x0000FE58
    XKDeadDoubleacute* = 0x0000FE59
    XKDeadCaron* = 0x0000FE5A
    XKDeadCedilla* = 0x0000FE5B
    XKDeadOgonek* = 0x0000FE5C
    XKDeadIota* = 0x0000FE5D
    XKDeadVoicedSound* = 0x0000FE5E
    XKDeadSemivoicedSound* = 0x0000FE5F
    XKDeadBelowdot* = 0x0000FE60
    XKDeadHook* = 0x0000FE61
    XKDeadHorn* = 0x0000FE62
    XKFirstVirtualScreen* = 0x0000FED0
    XKPrevVirtualScreen* = 0x0000FED1
    XKNextVirtualScreen* = 0x0000FED2
    XKLastVirtualScreen* = 0x0000FED4
    XKTerminateServer* = 0x0000FED5
    XKAccessXEnable* = 0x0000FE70
    XKAccessXFeedbackEnable* = 0x0000FE71
    XKRepeatKeysEnable* = 0x0000FE72
    XKSlowKeysEnable* = 0x0000FE73
    XKBounceKeysEnable* = 0x0000FE74
    XKStickyKeysEnable* = 0x0000FE75
    XKMouseKeysEnable* = 0x0000FE76
    XKMouseKeysAccelEnable* = 0x0000FE77
    XKOverlay1Enable* = 0x0000FE78
    XKOverlay2Enable* = 0x0000FE79
    XKAudibleBellEnable* = 0x0000FE7A
    XKPointerLeft* = 0x0000FEE0
    XKPointerRight* = 0x0000FEE1
    XKPointerUp* = 0x0000FEE2
    XKPointerDown* = 0x0000FEE3
    XKPointerUpLeft* = 0x0000FEE4
    XKPointerUpRight* = 0x0000FEE5
    XKPointerDownLeft* = 0x0000FEE6
    XKPointerDownRight* = 0x0000FEE7
    XKPointerButtonDflt* = 0x0000FEE8
    XKPointerButton1* = 0x0000FEE9
    XKPointerButton2* = 0x0000FEEA
    XKPointerButton3* = 0x0000FEEB
    XKPointerButton4* = 0x0000FEEC
    XKPointerButton5* = 0x0000FEED
    XKPointerDblClickDflt* = 0x0000FEEE
    XKPointerDblClick1* = 0x0000FEEF
    XKPointerDblClick2* = 0x0000FEF0
    XKPointerDblClick3* = 0x0000FEF1
    XKPointerDblClick4* = 0x0000FEF2
    XKPointerDblClick5* = 0x0000FEF3
    XKPointerDragDflt* = 0x0000FEF4
    XKPointerDrag1* = 0x0000FEF5
    XKPointerDrag2* = 0x0000FEF6
    XKPointerDrag3* = 0x0000FEF7
    XKPointerDrag4* = 0x0000FEF8
    XKPointerDrag5* = 0x0000FEFD
    XKPointerEnableKeys* = 0x0000FEF9
    XKPointerAccelerate* = 0x0000FEFA
    XKPointerDfltBtnNext* = 0x0000FEFB
    XKPointerDfltBtnPrev* = 0x0000FEFC
  #*
  # * 3270 Terminal Keys
  # * Byte 3 = = $FD
  # *

when defined(XK_3270) or true: 
  const
    XK3270Duplicate* = 0x0000FD01
    XK3270FieldMark* = 0x0000FD02
    XK3270Right2* = 0x0000FD03
    XK3270Left2* = 0x0000FD04
    XK3270BackTab* = 0x0000FD05
    XK3270EraseEOF* = 0x0000FD06
    XK3270EraseInput* = 0x0000FD07
    XK3270Reset* = 0x0000FD08
    XK3270Quit* = 0x0000FD09
    Xk3270Pa1* = 0x0000FD0A
    Xk3270Pa2* = 0x0000FD0B
    Xk3270Pa3* = 0x0000FD0C
    XK3270Test* = 0x0000FD0D
    XK3270Attn* = 0x0000FD0E
    XK3270CursorBlink* = 0x0000FD0F
    XK3270AltCursor* = 0x0000FD10
    XK3270KeyClick* = 0x0000FD11
    XK3270Jump* = 0x0000FD12
    XK3270Ident* = 0x0000FD13
    XK3270Rule* = 0x0000FD14
    XK3270Copy* = 0x0000FD15
    XK3270Play* = 0x0000FD16
    XK3270Setup* = 0x0000FD17
    XK3270Record* = 0x0000FD18
    XK3270ChangeScreen* = 0x0000FD19
    XK3270DeleteWord* = 0x0000FD1A
    XK3270ExSelect* = 0x0000FD1B
    XK3270CursorSelect* = 0x0000FD1C
    XK3270PrintScreen* = 0x0000FD1D
    XK3270Enter* = 0x0000FD1E
#*
# *  Latin 1
# *  Byte 3 = 0
# *

when defined(XK_LATIN1) or true: 
  const
    XKSpace* = 0x00000020
    XKExclam* = 0x00000021
    XKQuotedbl* = 0x00000022
    XKNumbersign* = 0x00000023
    XKDollar* = 0x00000024
    XKPercent* = 0x00000025
    XKAmpersand* = 0x00000026
    XKApostrophe* = 0x00000027
    XKQuoteright* = 0x00000027 # deprecated 
    XKParenleft* = 0x00000028
    XKParenright* = 0x00000029
    XKAsterisk* = 0x0000002A
    XKPlus* = 0x0000002B
    XKComma* = 0x0000002C
    XKMinus* = 0x0000002D
    XKPeriod* = 0x0000002E
    XKSlash* = 0x0000002F
    Xk0* = 0x00000030
    Xk1* = 0x00000031
    Xk2* = 0x00000032
    Xk3* = 0x00000033
    Xk4* = 0x00000034
    Xk5* = 0x00000035
    Xk6* = 0x00000036
    Xk7* = 0x00000037
    Xk8* = 0x00000038
    Xk9* = 0x00000039
    XKColon* = 0x0000003A
    XKSemicolon* = 0x0000003B
    XKLess* = 0x0000003C
    XKEqual* = 0x0000003D
    XKGreater* = 0x0000003E
    XKQuestion* = 0x0000003F
    XKAt* = 0x00000040
    XKcA* = 0x00000041
    XKcB* = 0x00000042
    XKcC* = 0x00000043
    XKcD* = 0x00000044
    XKcE* = 0x00000045
    XKcF* = 0x00000046
    XKcG* = 0x00000047
    XKcH* = 0x00000048
    XKcI* = 0x00000049
    XKcJ* = 0x0000004A
    XKcK* = 0x0000004B
    XKcL* = 0x0000004C
    XKcM* = 0x0000004D
    XKcN* = 0x0000004E
    XKcO* = 0x0000004F
    XKcP* = 0x00000050
    XKcQ* = 0x00000051
    XKcR* = 0x00000052
    XKcS* = 0x00000053
    XKcT* = 0x00000054
    XKcU* = 0x00000055
    XKcV* = 0x00000056
    XKcW* = 0x00000057
    XKcX* = 0x00000058
    XKcY* = 0x00000059
    XKcZ* = 0x0000005A
    XKBracketleft* = 0x0000005B
    XKBackslash* = 0x0000005C
    XKBracketright* = 0x0000005D
    XKAsciicircum* = 0x0000005E
    XKUnderscore* = 0x0000005F
    XKGrave* = 0x00000060
    XKQuoteleft* = 0x00000060  # deprecated 
    XKA* = 0x00000061
    XKB* = 0x00000062
    XKC* = 0x00000063
    XKD* = 0x00000064
    XKE* = 0x00000065
    XKF* = 0x00000066
    XKG* = 0x00000067
    XKH* = 0x00000068
    XKI* = 0x00000069
    XKJ* = 0x0000006A
    XKK* = 0x0000006B
    XKL* = 0x0000006C
    XKM* = 0x0000006D
    XKN* = 0x0000006E
    XKO* = 0x0000006F
    XKP* = 0x00000070
    XKQ* = 0x00000071
    XKR* = 0x00000072
    XKS* = 0x00000073
    XKT* = 0x00000074
    XKU* = 0x00000075
    XKV* = 0x00000076
    XKW* = 0x00000077
    XKX* = 0x00000078
    XKY* = 0x00000079
    XKZ* = 0x0000007A
    XKBraceleft* = 0x0000007B
    XKBar* = 0x0000007C
    XKBraceright* = 0x0000007D
    XKAsciitilde* = 0x0000007E
    XKNobreakspace* = 0x000000A0
    XKExclamdown* = 0x000000A1
    XKCent* = 0x000000A2
    XKSterling* = 0x000000A3
    XKCurrency* = 0x000000A4
    XKYen* = 0x000000A5
    XKBrokenbar* = 0x000000A6
    XKSection* = 0x000000A7
    XKDiaeresis* = 0x000000A8
    XKCopyright* = 0x000000A9
    XKOrdfeminine* = 0x000000AA
    XKGuillemotleft* = 0x000000AB # left angle quotation mark 
    XKNotsign* = 0x000000AC
    XKHyphen* = 0x000000AD
    XKRegistered* = 0x000000AE
    XKMacron* = 0x000000AF
    XKDegree* = 0x000000B0
    XKPlusminus* = 0x000000B1
    XKTwosuperior* = 0x000000B2
    XKThreesuperior* = 0x000000B3
    XKAcute* = 0x000000B4
    XKMu* = 0x000000B5
    XKParagraph* = 0x000000B6
    XKPeriodcentered* = 0x000000B7
    XKCedilla* = 0x000000B8
    XKOnesuperior* = 0x000000B9
    XKMasculine* = 0x000000BA
    XKGuillemotright* = 0x000000BB # right angle quotation mark 
    XKOnequarter* = 0x000000BC
    XKOnehalf* = 0x000000BD
    XKThreequarters* = 0x000000BE
    XKQuestiondown* = 0x000000BF
    XKcAgrave* = 0x000000C0
    XKcAacute* = 0x000000C1
    XKcAcircumflex* = 0x000000C2
    XKcAtilde* = 0x000000C3
    XKcAdiaeresis* = 0x000000C4
    XKcAring* = 0x000000C5
    XKcAE* = 0x000000C6
    XKcCcedilla* = 0x000000C7
    XKcEgrave* = 0x000000C8
    XKcEacute* = 0x000000C9
    XKcEcircumflex* = 0x000000CA
    XKcEdiaeresis* = 0x000000CB
    XKcIgrave* = 0x000000CC
    XKcIacute* = 0x000000CD
    XKcIcircumflex* = 0x000000CE
    XKcIdiaeresis* = 0x000000CF
    XKcETH* = 0x000000D0
    XKcNtilde* = 0x000000D1
    XKcOgrave* = 0x000000D2
    XKcOacute* = 0x000000D3
    XKcOcircumflex* = 0x000000D4
    XKcOtilde* = 0x000000D5
    XKcOdiaeresis* = 0x000000D6
    XKMultiply* = 0x000000D7
    XKcOoblique* = 0x000000D8
    XKcOslash* = XKc_Ooblique
    XKcUgrave* = 0x000000D9
    XKcUacute* = 0x000000DA
    XKcUcircumflex* = 0x000000DB
    XKcUdiaeresis* = 0x000000DC
    XKcYacute* = 0x000000DD
    XKcTHORN* = 0x000000DE
    XKSsharp* = 0x000000DF
    XKAgrave* = 0x000000E0
    XKAacute* = 0x000000E1
    XKAcircumflex* = 0x000000E2
    XKAtilde* = 0x000000E3
    XKAdiaeresis* = 0x000000E4
    XKAring* = 0x000000E5
    XKAe* = 0x000000E6
    XKCcedilla* = 0x000000E7
    XKEgrave* = 0x000000E8
    XKEacute* = 0x000000E9
    XKEcircumflex* = 0x000000EA
    XKEdiaeresis* = 0x000000EB
    XKIgrave* = 0x000000EC
    XKIacute* = 0x000000ED
    XKIcircumflex* = 0x000000EE
    XKIdiaeresis* = 0x000000EF
    XKEth* = 0x000000F0
    XKNtilde* = 0x000000F1
    XKOgrave* = 0x000000F2
    XKOacute* = 0x000000F3
    XKOcircumflex* = 0x000000F4
    XKOtilde* = 0x000000F5
    XKOdiaeresis* = 0x000000F6
    XKDivision* = 0x000000F7
    XKOslash* = 0x000000F8
    XKOoblique* = XK_oslash
    XKUgrave* = 0x000000F9
    XKUacute* = 0x000000FA
    XKUcircumflex* = 0x000000FB
    XKUdiaeresis* = 0x000000FC
    XKYacute* = 0x000000FD
    XKThorn* = 0x000000FE
    XKYdiaeresis* = 0x000000FF
# XK_LATIN1 
#*
# *   Latin 2
# *   Byte 3 = 1
# *

when defined(XK_LATIN2) or true: 
  const
    XKcAogonek* = 0x000001A1
    XKBreve* = 0x000001A2
    XKcLstroke* = 0x000001A3
    XKcLcaron* = 0x000001A5
    XKcSacute* = 0x000001A6
    XKcScaron* = 0x000001A9
    XKcScedilla* = 0x000001AA
    XKcTcaron* = 0x000001AB
    XKcZacute* = 0x000001AC
    XKcZcaron* = 0x000001AE
    XKcZabovedot* = 0x000001AF
    XKAogonek* = 0x000001B1
    XKOgonek* = 0x000001B2
    XKLstroke* = 0x000001B3
    XKLcaron* = 0x000001B5
    XKSacute* = 0x000001B6
    XKCaron* = 0x000001B7
    XKScaron* = 0x000001B9
    XKScedilla* = 0x000001BA
    XKTcaron* = 0x000001BB
    XKZacute* = 0x000001BC
    XKDoubleacute* = 0x000001BD
    XKZcaron* = 0x000001BE
    XKZabovedot* = 0x000001BF
    XKcRacute* = 0x000001C0
    XKcAbreve* = 0x000001C3
    XKcLacute* = 0x000001C5
    XKcCacute* = 0x000001C6
    XKcCcaron* = 0x000001C8
    XKcEogonek* = 0x000001CA
    XKcEcaron* = 0x000001CC
    XKcDcaron* = 0x000001CF
    XKcDstroke* = 0x000001D0
    XKcNacute* = 0x000001D1
    XKcNcaron* = 0x000001D2
    XKcOdoubleacute* = 0x000001D5
    XKcRcaron* = 0x000001D8
    XKcUring* = 0x000001D9
    XKcUdoubleacute* = 0x000001DB
    XKcTcedilla* = 0x000001DE
    XKRacute* = 0x000001E0
    XKAbreve* = 0x000001E3
    XKLacute* = 0x000001E5
    XKCacute* = 0x000001E6
    XKCcaron* = 0x000001E8
    XKEogonek* = 0x000001EA
    XKEcaron* = 0x000001EC
    XKDcaron* = 0x000001EF
    XKDstroke* = 0x000001F0
    XKNacute* = 0x000001F1
    XKNcaron* = 0x000001F2
    XKOdoubleacute* = 0x000001F5
    XKUdoubleacute* = 0x000001FB
    XKRcaron* = 0x000001F8
    XKUring* = 0x000001F9
    XKTcedilla* = 0x000001FE
    XKAbovedot* = 0x000001FF
# XK_LATIN2 
#*
# *   Latin 3
# *   Byte 3 = 2
# *

when defined(XK_LATIN3) or true: 
  const
    XKcHstroke* = 0x000002A1
    XKcHcircumflex* = 0x000002A6
    XKcIabovedot* = 0x000002A9
    XKcGbreve* = 0x000002AB
    XKcJcircumflex* = 0x000002AC
    XKHstroke* = 0x000002B1
    XKHcircumflex* = 0x000002B6
    XKIdotless* = 0x000002B9
    XKGbreve* = 0x000002BB
    XKJcircumflex* = 0x000002BC
    XKcCabovedot* = 0x000002C5
    XKcCcircumflex* = 0x000002C6
    XKcGabovedot* = 0x000002D5
    XKcGcircumflex* = 0x000002D8
    XKcUbreve* = 0x000002DD
    XKcScircumflex* = 0x000002DE
    XKCabovedot* = 0x000002E5
    XKCcircumflex* = 0x000002E6
    XKGabovedot* = 0x000002F5
    XKGcircumflex* = 0x000002F8
    XKUbreve* = 0x000002FD
    XKScircumflex* = 0x000002FE
# XK_LATIN3 
#*
# *   Latin 4
# *   Byte 3 = 3
# *

when defined(XK_LATIN4) or true: 
  const
    XKKra* = 0x000003A2
    XKKappa* = 0x000003A2      # deprecated 
    XKcRcedilla* = 0x000003A3
    XKcItilde* = 0x000003A5
    XKcLcedilla* = 0x000003A6
    XKcEmacron* = 0x000003AA
    XKcGcedilla* = 0x000003AB
    XKcTslash* = 0x000003AC
    XKRcedilla* = 0x000003B3
    XKItilde* = 0x000003B5
    XKLcedilla* = 0x000003B6
    XKEmacron* = 0x000003BA
    XKGcedilla* = 0x000003BB
    XKTslash* = 0x000003BC
    XKcENG* = 0x000003BD
    XKEng* = 0x000003BF
    XKcAmacron* = 0x000003C0
    XKcIogonek* = 0x000003C7
    XKcEabovedot* = 0x000003CC
    XKcImacron* = 0x000003CF
    XKcNcedilla* = 0x000003D1
    XKcOmacron* = 0x000003D2
    XKcKcedilla* = 0x000003D3
    XKcUogonek* = 0x000003D9
    XKcUtilde* = 0x000003DD
    XKcUmacron* = 0x000003DE
    XKAmacron* = 0x000003E0
    XKIogonek* = 0x000003E7
    XKEabovedot* = 0x000003EC
    XKImacron* = 0x000003EF
    XKNcedilla* = 0x000003F1
    XKOmacron* = 0x000003F2
    XKKcedilla* = 0x000003F3
    XKUogonek* = 0x000003F9
    XKUtilde* = 0x000003FD
    XKUmacron* = 0x000003FE
# XK_LATIN4 
#*
# * Latin-8
# * Byte 3 = 18
# *

when defined(XK_LATIN8) or true: 
  const
    XKcBabovedot* = 0x000012A1
    XKBabovedot* = 0x000012A2
    XKcDabovedot* = 0x000012A6
    XKcWgrave* = 0x000012A8
    XKcWacute* = 0x000012AA
    XKDabovedot* = 0x000012AB
    XKcYgrave* = 0x000012AC
    XKcFabovedot* = 0x000012B0
    XKFabovedot* = 0x000012B1
    XKcMabovedot* = 0x000012B4
    XKMabovedot* = 0x000012B5
    XKcPabovedot* = 0x000012B7
    XKWgrave* = 0x000012B8
    XKPabovedot* = 0x000012B9
    XKWacute* = 0x000012BA
    XKcSabovedot* = 0x000012BB
    XKYgrave* = 0x000012BC
    XKcWdiaeresis* = 0x000012BD
    XKWdiaeresis* = 0x000012BE
    XKSabovedot* = 0x000012BF
    XKcWcircumflex* = 0x000012D0
    XKcTabovedot* = 0x000012D7
    XKcYcircumflex* = 0x000012DE
    XKWcircumflex* = 0x000012F0
    XKTabovedot* = 0x000012F7
    XKYcircumflex* = 0x000012FE
# XK_LATIN8 
#*
# * Latin-9 (a.k.a. Latin-0)
# * Byte 3 = 19
# *

when defined(XK_LATIN9) or true: 
  const
    XKcOE* = 0x000013BC
    XKOe* = 0x000013BD
    XKcYdiaeresis* = 0x000013BE
# XK_LATIN9 
#*
# * Katakana
# * Byte 3 = 4
# *

when defined(XK_KATAKANA) or true: 
  const
    XKOverline* = 0x0000047E
    XKKanaFullstop* = 0x000004A1
    XKKanaOpeningbracket* = 0x000004A2
    XKKanaClosingbracket* = 0x000004A3
    XKKanaComma* = 0x000004A4
    XKKanaConjunctive* = 0x000004A5
    XKKanaMiddledot* = 0x000004A5 # deprecated 
    XKcKanaWO* = 0x000004A6
    XKKanaA* = 0x000004A7
    XKKanaI* = 0x000004A8
    XKKanaU* = 0x000004A9
    XKKanaE* = 0x000004AA
    XKKanaO* = 0x000004AB
    XKKanaYa* = 0x000004AC
    XKKanaYu* = 0x000004AD
    XKKanaYo* = 0x000004AE
    XKKanaTsu* = 0x000004AF
    XKKanaTu* = 0x000004AF    # deprecated 
    XKProlongedsound* = 0x000004B0
    XKcKanaA* = 0x000004B1
    XKcKanaI* = 0x000004B2
    XKcKanaU* = 0x000004B3
    XKcKanaE* = 0x000004B4
    XKcKanaO* = 0x000004B5
    XKcKanaKA* = 0x000004B6
    XKcKanaKI* = 0x000004B7
    XKcKanaKU* = 0x000004B8
    XKcKanaKE* = 0x000004B9
    XKcKanaKO* = 0x000004BA
    XKcKanaSA* = 0x000004BB
    XKcKanaSHI* = 0x000004BC
    XKcKanaSU* = 0x000004BD
    XKcKanaSE* = 0x000004BE
    XKcKanaSO* = 0x000004BF
    XKcKanaTA* = 0x000004C0
    XKcKanaCHI* = 0x000004C1
    XKcKanaTI* = 0x000004C1   # deprecated 
    XKcKanaTSU* = 0x000004C2
    XKcKanaTU* = 0x000004C2   # deprecated 
    XKcKanaTE* = 0x000004C3
    XKcKanaTO* = 0x000004C4
    XKcKanaNA* = 0x000004C5
    XKcKanaNI* = 0x000004C6
    XKcKanaNU* = 0x000004C7
    XKcKanaNE* = 0x000004C8
    XKcKanaNO* = 0x000004C9
    XKcKanaHA* = 0x000004CA
    XKcKanaHI* = 0x000004CB
    XKcKanaFU* = 0x000004CC
    XKcKanaHU* = 0x000004CC   # deprecated 
    XKcKanaHE* = 0x000004CD
    XKcKanaHO* = 0x000004CE
    XKcKanaMA* = 0x000004CF
    XKcKanaMI* = 0x000004D0
    XKcKanaMU* = 0x000004D1
    XKcKanaME* = 0x000004D2
    XKcKanaMO* = 0x000004D3
    XKcKanaYA* = 0x000004D4
    XKcKanaYU* = 0x000004D5
    XKcKanaYO* = 0x000004D6
    XKcKanaRA* = 0x000004D7
    XKcKanaRI* = 0x000004D8
    XKcKanaRU* = 0x000004D9
    XKcKanaRE* = 0x000004DA
    XKcKanaRO* = 0x000004DB
    XKcKanaWA* = 0x000004DC
    XKcKanaN* = 0x000004DD
    XKVoicedsound* = 0x000004DE
    XKSemivoicedsound* = 0x000004DF
    XKKanaSwitch* = 0x0000FF7E # Alias for mode_switch 
# XK_KATAKANA 
#*
# *  Arabic
# *  Byte 3 = 5
# *

when defined(XK_ARABIC) or true: 
  const
    XKFarsi0* = 0x00000590
    XKFarsi1* = 0x00000591
    XKFarsi2* = 0x00000592
    XKFarsi3* = 0x00000593
    XKFarsi4* = 0x00000594
    XKFarsi5* = 0x00000595
    XKFarsi6* = 0x00000596
    XKFarsi7* = 0x00000597
    XKFarsi8* = 0x00000598
    XKFarsi9* = 0x00000599
    XKArabicPercent* = 0x000005A5
    XKArabicSuperscriptAlef* = 0x000005A6
    XKArabicTteh* = 0x000005A7
    XKArabicPeh* = 0x000005A8
    XKArabicTcheh* = 0x000005A9
    XKArabicDdal* = 0x000005AA
    XKArabicRreh* = 0x000005AB
    XKArabicComma* = 0x000005AC
    XKArabicFullstop* = 0x000005AE
    XKArabic0* = 0x000005B0
    XKArabic1* = 0x000005B1
    XKArabic2* = 0x000005B2
    XKArabic3* = 0x000005B3
    XKArabic4* = 0x000005B4
    XKArabic5* = 0x000005B5
    XKArabic6* = 0x000005B6
    XKArabic7* = 0x000005B7
    XKArabic8* = 0x000005B8
    XKArabic9* = 0x000005B9
    XKArabicSemicolon* = 0x000005BB
    XKArabicQuestionMark* = 0x000005BF
    XKArabicHamza* = 0x000005C1
    XKArabicMaddaonalef* = 0x000005C2
    XKArabicHamzaonalef* = 0x000005C3
    XKArabicHamzaonwaw* = 0x000005C4
    XKArabicHamzaunderalef* = 0x000005C5
    XKArabicHamzaonyeh* = 0x000005C6
    XKArabicAlef* = 0x000005C7
    XKArabicBeh* = 0x000005C8
    XKArabicTehmarbuta* = 0x000005C9
    XKArabicTeh* = 0x000005CA
    XKArabicTheh* = 0x000005CB
    XKArabicJeem* = 0x000005CC
    XKArabicHah* = 0x000005CD
    XKArabicKhah* = 0x000005CE
    XKArabicDal* = 0x000005CF
    XKArabicThal* = 0x000005D0
    XKArabicRa* = 0x000005D1
    XKArabicZain* = 0x000005D2
    XKArabicSeen* = 0x000005D3
    XKArabicSheen* = 0x000005D4
    XKArabicSad* = 0x000005D5
    XKArabicDad* = 0x000005D6
    XKArabicTah* = 0x000005D7
    XKArabicZah* = 0x000005D8
    XKArabicAin* = 0x000005D9
    XKArabicGhain* = 0x000005DA
    XKArabicTatweel* = 0x000005E0
    XKArabicFeh* = 0x000005E1
    XKArabicQaf* = 0x000005E2
    XKArabicKaf* = 0x000005E3
    XKArabicLam* = 0x000005E4
    XKArabicMeem* = 0x000005E5
    XKArabicNoon* = 0x000005E6
    XKArabicHa* = 0x000005E7
    XKArabicHeh* = 0x000005E7 # deprecated 
    XKArabicWaw* = 0x000005E8
    XKArabicAlefmaksura* = 0x000005E9
    XKArabicYeh* = 0x000005EA
    XKArabicFathatan* = 0x000005EB
    XKArabicDammatan* = 0x000005EC
    XKArabicKasratan* = 0x000005ED
    XKArabicFatha* = 0x000005EE
    XKArabicDamma* = 0x000005EF
    XKArabicKasra* = 0x000005F0
    XKArabicShadda* = 0x000005F1
    XKArabicSukun* = 0x000005F2
    XKArabicMaddaAbove* = 0x000005F3
    XKArabicHamzaAbove* = 0x000005F4
    XKArabicHamzaBelow* = 0x000005F5
    XKArabicJeh* = 0x000005F6
    XKArabicVeh* = 0x000005F7
    XKArabicKeheh* = 0x000005F8
    XKArabicGaf* = 0x000005F9
    XKArabicNoonGhunna* = 0x000005FA
    XKArabicHehDoachashmee* = 0x000005FB
    XKFarsiYeh* = 0x000005FC
    XKArabicFarsiYeh* = XK_Farsi_yeh
    XKArabicYehBaree* = 0x000005FD
    XKArabicHehGoal* = 0x000005FE
    XKArabicSwitch* = 0x0000FF7E # Alias for mode_switch 
# XK_ARABIC 
#*
# * Cyrillic
# * Byte 3 = 6
# *

when defined(XK_CYRILLIC) or true: 
  const
    XKcCyrillicGHEBar* = 0x00000680
    XKCyrillicGheBar* = 0x00000690
    XKcCyrillicZHEDescender* = 0x00000681
    XKCyrillicZheDescender* = 0x00000691
    XKcCyrillicKADescender* = 0x00000682
    XKCyrillicKaDescender* = 0x00000692
    XKcCyrillicKAVertstroke* = 0x00000683
    XKCyrillicKaVertstroke* = 0x00000693
    XKcCyrillicENDescender* = 0x00000684
    XKCyrillicEnDescender* = 0x00000694
    XKcCyrillicUStraight* = 0x00000685
    XKCyrillicUStraight* = 0x00000695
    XKcCyrillicUStraightBar* = 0x00000686
    XKCyrillicUStraightBar* = 0x00000696
    XKcCyrillicHADescender* = 0x00000687
    XKCyrillicHaDescender* = 0x00000697
    XKcCyrillicCHEDescender* = 0x00000688
    XKCyrillicCheDescender* = 0x00000698
    XKcCyrillicCHEVertstroke* = 0x00000689
    XKCyrillicCheVertstroke* = 0x00000699
    XKcCyrillicSHHA* = 0x0000068A
    XKCyrillicShha* = 0x0000069A
    XKcCyrillicSCHWA* = 0x0000068C
    XKCyrillicSchwa* = 0x0000069C
    XKcCyrillicIMacron* = 0x0000068D
    XKCyrillicIMacron* = 0x0000069D
    XKcCyrillicOBar* = 0x0000068E
    XKCyrillicOBar* = 0x0000069E
    XKcCyrillicUMacron* = 0x0000068F
    XKCyrillicUMacron* = 0x0000069F
    XKSerbianDje* = 0x000006A1
    XKMacedoniaGje* = 0x000006A2
    XKCyrillicIo* = 0x000006A3
    XKUkrainianIe* = 0x000006A4
    XKUkranianJe* = 0x000006A4 # deprecated 
    XKMacedoniaDse* = 0x000006A5
    XKUkrainianI* = 0x000006A6
    XKUkranianI* = 0x000006A6 # deprecated 
    XKUkrainianYi* = 0x000006A7
    XKUkranianYi* = 0x000006A7 # deprecated 
    XKCyrillicJe* = 0x000006A8
    XKSerbianJe* = 0x000006A8 # deprecated 
    XKCyrillicLje* = 0x000006A9
    XKSerbianLje* = 0x000006A9 # deprecated 
    XKCyrillicNje* = 0x000006AA
    XKSerbianNje* = 0x000006AA # deprecated 
    XKSerbianTshe* = 0x000006AB
    XKMacedoniaKje* = 0x000006AC
    XKUkrainianGheWithUpturn* = 0x000006AD
    XKByelorussianShortu* = 0x000006AE
    XKCyrillicDzhe* = 0x000006AF
    XKSerbianDze* = 0x000006AF # deprecated 
    XKNumerosign* = 0x000006B0
    XKcSerbianDJE* = 0x000006B1
    XKcMacedoniaGJE* = 0x000006B2
    XKcCyrillicIO* = 0x000006B3
    XKcUkrainianIE* = 0x000006B4
    XKcUkranianJE* = 0x000006B4 # deprecated 
    XKcMacedoniaDSE* = 0x000006B5
    XKcUkrainianI* = 0x000006B6
    XKcUkranianI* = 0x000006B6 # deprecated 
    XKcUkrainianYI* = 0x000006B7
    XKcUkranianYI* = 0x000006B7 # deprecated 
    XKcCyrillicJE* = 0x000006B8
    XKcSerbianJE* = 0x000006B8 # deprecated 
    XKcCyrillicLJE* = 0x000006B9
    XKcSerbianLJE* = 0x000006B9 # deprecated 
    XKcCyrillicNJE* = 0x000006BA
    XKcSerbianNJE* = 0x000006BA # deprecated 
    XKcSerbianTSHE* = 0x000006BB
    XKcMacedoniaKJE* = 0x000006BC
    XKcUkrainianGHEWITHUPTURN* = 0x000006BD
    XKcByelorussianSHORTU* = 0x000006BE
    XKcCyrillicDZHE* = 0x000006BF
    XKcSerbianDZE* = 0x000006BF # deprecated 
    XKCyrillicYu* = 0x000006C0
    XKCyrillicA* = 0x000006C1
    XKCyrillicBe* = 0x000006C2
    XKCyrillicTse* = 0x000006C3
    XKCyrillicDe* = 0x000006C4
    XKCyrillicIe* = 0x000006C5
    XKCyrillicEf* = 0x000006C6
    XKCyrillicGhe* = 0x000006C7
    XKCyrillicHa* = 0x000006C8
    XKCyrillicI* = 0x000006C9
    XKCyrillicShorti* = 0x000006CA
    XKCyrillicKa* = 0x000006CB
    XKCyrillicEl* = 0x000006CC
    XKCyrillicEm* = 0x000006CD
    XKCyrillicEn* = 0x000006CE
    XKCyrillicO* = 0x000006CF
    XKCyrillicPe* = 0x000006D0
    XKCyrillicYa* = 0x000006D1
    XKCyrillicEr* = 0x000006D2
    XKCyrillicEs* = 0x000006D3
    XKCyrillicTe* = 0x000006D4
    XKCyrillicU* = 0x000006D5
    XKCyrillicZhe* = 0x000006D6
    XKCyrillicVe* = 0x000006D7
    XKCyrillicSoftsign* = 0x000006D8
    XKCyrillicYeru* = 0x000006D9
    XKCyrillicZe* = 0x000006DA
    XKCyrillicSha* = 0x000006DB
    XKCyrillicE* = 0x000006DC
    XKCyrillicShcha* = 0x000006DD
    XKCyrillicChe* = 0x000006DE
    XKCyrillicHardsign* = 0x000006DF
    XKcCyrillicYU* = 0x000006E0
    XKcCyrillicA* = 0x000006E1
    XKcCyrillicBE* = 0x000006E2
    XKcCyrillicTSE* = 0x000006E3
    XKcCyrillicDE* = 0x000006E4
    XKcCyrillicIE* = 0x000006E5
    XKcCyrillicEF* = 0x000006E6
    XKcCyrillicGHE* = 0x000006E7
    XKcCyrillicHA* = 0x000006E8
    XKcCyrillicI* = 0x000006E9
    XKcCyrillicSHORTI* = 0x000006EA
    XKcCyrillicKA* = 0x000006EB
    XKcCyrillicEL* = 0x000006EC
    XKcCyrillicEM* = 0x000006ED
    XKcCyrillicEN* = 0x000006EE
    XKcCyrillicO* = 0x000006EF
    XKcCyrillicPE* = 0x000006F0
    XKcCyrillicYA* = 0x000006F1
    XKcCyrillicER* = 0x000006F2
    XKcCyrillicES* = 0x000006F3
    XKcCyrillicTE* = 0x000006F4
    XKcCyrillicU* = 0x000006F5
    XKcCyrillicZHE* = 0x000006F6
    XKcCyrillicVE* = 0x000006F7
    XKcCyrillicSOFTSIGN* = 0x000006F8
    XKcCyrillicYERU* = 0x000006F9
    XKcCyrillicZE* = 0x000006FA
    XKcCyrillicSHA* = 0x000006FB
    XKcCyrillicE* = 0x000006FC
    XKcCyrillicSHCHA* = 0x000006FD
    XKcCyrillicCHE* = 0x000006FE
    XKcCyrillicHARDSIGN* = 0x000006FF
# XK_CYRILLIC 
#*
# * Greek
# * Byte 3 = 7
# *

when defined(XK_GREEK) or true: 
  const
    XKcGreekALPHAaccent* = 0x000007A1
    XKcGreekEPSILONaccent* = 0x000007A2
    XKcGreekETAaccent* = 0x000007A3
    XKcGreekIOTAaccent* = 0x000007A4
    XKcGreekIOTAdieresis* = 0x000007A5
    XKcGreekIOTAdiaeresis* = XKc_Greek_IOTAdieresis # old typo 
    XKcGreekOMICRONaccent* = 0x000007A7
    XKcGreekUPSILONaccent* = 0x000007A8
    XKcGreekUPSILONdieresis* = 0x000007A9
    XKcGreekOMEGAaccent* = 0x000007AB
    XKGreekAccentdieresis* = 0x000007AE
    XKGreekHorizbar* = 0x000007AF
    XKGreekAlphaaccent* = 0x000007B1
    XKGreekEpsilonaccent* = 0x000007B2
    XKGreekEtaaccent* = 0x000007B3
    XKGreekIotaaccent* = 0x000007B4
    XKGreekIotadieresis* = 0x000007B5
    XKGreekIotaaccentdieresis* = 0x000007B6
    XKGreekOmicronaccent* = 0x000007B7
    XKGreekUpsilonaccent* = 0x000007B8
    XKGreekUpsilondieresis* = 0x000007B9
    XKGreekUpsilonaccentdieresis* = 0x000007BA
    XKGreekOmegaaccent* = 0x000007BB
    XKcGreekALPHA* = 0x000007C1
    XKcGreekBETA* = 0x000007C2
    XKcGreekGAMMA* = 0x000007C3
    XKcGreekDELTA* = 0x000007C4
    XKcGreekEPSILON* = 0x000007C5
    XKcGreekZETA* = 0x000007C6
    XKcGreekETA* = 0x000007C7
    XKcGreekTHETA* = 0x000007C8
    XKcGreekIOTA* = 0x000007C9
    XKcGreekKAPPA* = 0x000007CA
    XKcGreekLAMDA* = 0x000007CB
    XKcGreekLAMBDA* = 0x000007CB
    XKcGreekMU* = 0x000007CC
    XKcGreekNU* = 0x000007CD
    XKcGreekXI* = 0x000007CE
    XKcGreekOMICRON* = 0x000007CF
    XKcGreekPI* = 0x000007D0
    XKcGreekRHO* = 0x000007D1
    XKcGreekSIGMA* = 0x000007D2
    XKcGreekTAU* = 0x000007D4
    XKcGreekUPSILON* = 0x000007D5
    XKcGreekPHI* = 0x000007D6
    XKcGreekCHI* = 0x000007D7
    XKcGreekPSI* = 0x000007D8
    XKcGreekOMEGA* = 0x000007D9
    XKGreekAlpha* = 0x000007E1
    XKGreekBeta* = 0x000007E2
    XKGreekGamma* = 0x000007E3
    XKGreekDelta* = 0x000007E4
    XKGreekEpsilon* = 0x000007E5
    XKGreekZeta* = 0x000007E6
    XKGreekEta* = 0x000007E7
    XKGreekTheta* = 0x000007E8
    XKGreekIota* = 0x000007E9
    XKGreekKappa* = 0x000007EA
    XKGreekLamda* = 0x000007EB
    XKGreekLambda* = 0x000007EB
    XKGreekMu* = 0x000007EC
    XKGreekNu* = 0x000007ED
    XKGreekXi* = 0x000007EE
    XKGreekOmicron* = 0x000007EF
    XKGreekPi* = 0x000007F0
    XKGreekRho* = 0x000007F1
    XKGreekSigma* = 0x000007F2
    XKGreekFinalsmallsigma* = 0x000007F3
    XKGreekTau* = 0x000007F4
    XKGreekUpsilon* = 0x000007F5
    XKGreekPhi* = 0x000007F6
    XKGreekChi* = 0x000007F7
    XKGreekPsi* = 0x000007F8
    XKGreekOmega* = 0x000007F9
    XKGreekSwitch* = 0x0000FF7E # Alias for mode_switch 
# XK_GREEK 
#*
# * Technical
# * Byte 3 = 8
# *

when defined(XK_TECHNICAL) or true: 
  const
    XKLeftradical* = 0x000008A1
    XKTopleftradical* = 0x000008A2
    XKHorizconnector* = 0x000008A3
    XKTopintegral* = 0x000008A4
    XKBotintegral* = 0x000008A5
    XKVertconnector* = 0x000008A6
    XKTopleftsqbracket* = 0x000008A7
    XKBotleftsqbracket* = 0x000008A8
    XKToprightsqbracket* = 0x000008A9
    XKBotrightsqbracket* = 0x000008AA
    XKTopleftparens* = 0x000008AB
    XKBotleftparens* = 0x000008AC
    XKToprightparens* = 0x000008AD
    XKBotrightparens* = 0x000008AE
    XKLeftmiddlecurlybrace* = 0x000008AF
    XKRightmiddlecurlybrace* = 0x000008B0
    XKTopleftsummation* = 0x000008B1
    XKBotleftsummation* = 0x000008B2
    XKTopvertsummationconnector* = 0x000008B3
    XKBotvertsummationconnector* = 0x000008B4
    XKToprightsummation* = 0x000008B5
    XKBotrightsummation* = 0x000008B6
    XKRightmiddlesummation* = 0x000008B7
    XKLessthanequal* = 0x000008BC
    XKNotequal* = 0x000008BD
    XKGreaterthanequal* = 0x000008BE
    XKIntegral* = 0x000008BF
    XKTherefore* = 0x000008C0
    XKVariation* = 0x000008C1
    XKInfinity* = 0x000008C2
    XKNabla* = 0x000008C5
    XKApproximate* = 0x000008C8
    XKSimilarequal* = 0x000008C9
    XKIfonlyif* = 0x000008CD
    XKImplies* = 0x000008CE
    XKIdentical* = 0x000008CF
    XKRadical* = 0x000008D6
    XKIncludedin* = 0x000008DA
    XKIncludes* = 0x000008DB
    XKIntersection* = 0x000008DC
    XKUnion* = 0x000008DD
    XKLogicaland* = 0x000008DE
    XKLogicalor* = 0x000008DF
    XKPartialderivative* = 0x000008EF
    XKFunction* = 0x000008F6
    XKLeftarrow* = 0x000008FB
    XKUparrow* = 0x000008FC
    XKRightarrow* = 0x000008FD
    XKDownarrow* = 0x000008FE
# XK_TECHNICAL 
#*
# *  Special
# *  Byte 3 = 9
# *

when defined(XK_SPECIAL): 
  const
    XK_blank* = 0x000009DF
    XK_soliddiamond* = 0x000009E0
    XK_checkerboard* = 0x000009E1
    XK_ht* = 0x000009E2
    XK_ff* = 0x000009E3
    XK_cr* = 0x000009E4
    XK_lf* = 0x000009E5
    XK_nl* = 0x000009E8
    XK_vt* = 0x000009E9
    XK_lowrightcorner* = 0x000009EA
    XK_uprightcorner* = 0x000009EB
    XK_upleftcorner* = 0x000009EC
    XK_lowleftcorner* = 0x000009ED
    XK_crossinglines* = 0x000009EE
    XK_horizlinescan1* = 0x000009EF
    XK_horizlinescan3* = 0x000009F0
    XK_horizlinescan5* = 0x000009F1
    XK_horizlinescan7* = 0x000009F2
    XK_horizlinescan9* = 0x000009F3
    XK_leftt* = 0x000009F4
    XK_rightt* = 0x000009F5
    XK_bott* = 0x000009F6
    XK_topt* = 0x000009F7
    XK_vertbar* = 0x000009F8
# XK_SPECIAL 
#*
# *  Publishing
# *  Byte 3 = a
# *

when defined(XK_PUBLISHING) or true: 
  const
    XKEmspace* = 0x00000AA1
    XKEnspace* = 0x00000AA2
    XKEm3space* = 0x00000AA3
    XKEm4space* = 0x00000AA4
    XKDigitspace* = 0x00000AA5
    XKPunctspace* = 0x00000AA6
    XKThinspace* = 0x00000AA7
    XKHairspace* = 0x00000AA8
    XKEmdash* = 0x00000AA9
    XKEndash* = 0x00000AAA
    XKSignifblank* = 0x00000AAC
    XKEllipsis* = 0x00000AAE
    XKDoubbaselinedot* = 0x00000AAF
    XKOnethird* = 0x00000AB0
    XKTwothirds* = 0x00000AB1
    XKOnefifth* = 0x00000AB2
    XKTwofifths* = 0x00000AB3
    XKThreefifths* = 0x00000AB4
    XKFourfifths* = 0x00000AB5
    XKOnesixth* = 0x00000AB6
    XKFivesixths* = 0x00000AB7
    XKCareof* = 0x00000AB8
    XKFigdash* = 0x00000ABB
    XKLeftanglebracket* = 0x00000ABC
    XKDecimalpoint* = 0x00000ABD
    XKRightanglebracket* = 0x00000ABE
    XKMarker* = 0x00000ABF
    XKOneeighth* = 0x00000AC3
    XKThreeeighths* = 0x00000AC4
    XKFiveeighths* = 0x00000AC5
    XKSeveneighths* = 0x00000AC6
    XKTrademark* = 0x00000AC9
    XKSignaturemark* = 0x00000ACA
    XKTrademarkincircle* = 0x00000ACB
    XKLeftopentriangle* = 0x00000ACC
    XKRightopentriangle* = 0x00000ACD
    XKEmopencircle* = 0x00000ACE
    XKEmopenrectangle* = 0x00000ACF
    XKLeftsinglequotemark* = 0x00000AD0
    XKRightsinglequotemark* = 0x00000AD1
    XKLeftdoublequotemark* = 0x00000AD2
    XKRightdoublequotemark* = 0x00000AD3
    XKPrescription* = 0x00000AD4
    XKMinutes* = 0x00000AD6
    XKSeconds* = 0x00000AD7
    XKLatincross* = 0x00000AD9
    XKHexagram* = 0x00000ADA
    XKFilledrectbullet* = 0x00000ADB
    XKFilledlefttribullet* = 0x00000ADC
    XKFilledrighttribullet* = 0x00000ADD
    XKEmfilledcircle* = 0x00000ADE
    XKEmfilledrect* = 0x00000ADF
    XKEnopencircbullet* = 0x00000AE0
    XKEnopensquarebullet* = 0x00000AE1
    XKOpenrectbullet* = 0x00000AE2
    XKOpentribulletup* = 0x00000AE3
    XKOpentribulletdown* = 0x00000AE4
    XKOpenstar* = 0x00000AE5
    XKEnfilledcircbullet* = 0x00000AE6
    XKEnfilledsqbullet* = 0x00000AE7
    XKFilledtribulletup* = 0x00000AE8
    XKFilledtribulletdown* = 0x00000AE9
    XKLeftpointer* = 0x00000AEA
    XKRightpointer* = 0x00000AEB
    XKClub* = 0x00000AEC
    XKDiamond* = 0x00000AED
    XKHeart* = 0x00000AEE
    XKMaltesecross* = 0x00000AF0
    XKDagger* = 0x00000AF1
    XKDoubledagger* = 0x00000AF2
    XKCheckmark* = 0x00000AF3
    XKBallotcross* = 0x00000AF4
    XKMusicalsharp* = 0x00000AF5
    XKMusicalflat* = 0x00000AF6
    XKMalesymbol* = 0x00000AF7
    XKFemalesymbol* = 0x00000AF8
    XKTelephone* = 0x00000AF9
    XKTelephonerecorder* = 0x00000AFA
    XKPhonographcopyright* = 0x00000AFB
    XKCaret* = 0x00000AFC
    XKSinglelowquotemark* = 0x00000AFD
    XKDoublelowquotemark* = 0x00000AFE
    XKCursor* = 0x00000AFF
# XK_PUBLISHING 
#*
# *  APL
# *  Byte 3 = b
# *

when defined(XK_APL) or true: 
  const
    XKLeftcaret* = 0x00000BA3
    XKRightcaret* = 0x00000BA6
    XKDowncaret* = 0x00000BA8
    XKUpcaret* = 0x00000BA9
    XKOverbar* = 0x00000BC0
    XKDowntack* = 0x00000BC2
    XKUpshoe* = 0x00000BC3
    XKDownstile* = 0x00000BC4
    XKUnderbar* = 0x00000BC6
    XKJot* = 0x00000BCA
    XKQuad* = 0x00000BCC
    XKUptack* = 0x00000BCE
    XKCircle* = 0x00000BCF
    XKUpstile* = 0x00000BD3
    XKDownshoe* = 0x00000BD6
    XKRightshoe* = 0x00000BD8
    XKLeftshoe* = 0x00000BDA
    XKLefttack* = 0x00000BDC
    XKRighttack* = 0x00000BFC
# XK_APL 
#*
# * Hebrew
# * Byte 3 = c
# *

when defined(XK_HEBREW) or true: 
  const
    XKHebrewDoublelowline* = 0x00000CDF
    XKHebrewAleph* = 0x00000CE0
    XKHebrewBet* = 0x00000CE1
    XKHebrewBeth* = 0x00000CE1 # deprecated 
    XKHebrewGimel* = 0x00000CE2
    XKHebrewGimmel* = 0x00000CE2 # deprecated 
    XKHebrewDalet* = 0x00000CE3
    XKHebrewDaleth* = 0x00000CE3 # deprecated 
    XKHebrewHe* = 0x00000CE4
    XKHebrewWaw* = 0x00000CE5
    XKHebrewZain* = 0x00000CE6
    XKHebrewZayin* = 0x00000CE6 # deprecated 
    XKHebrewChet* = 0x00000CE7
    XKHebrewHet* = 0x00000CE7 # deprecated 
    XKHebrewTet* = 0x00000CE8
    XKHebrewTeth* = 0x00000CE8 # deprecated 
    XKHebrewYod* = 0x00000CE9
    XKHebrewFinalkaph* = 0x00000CEA
    XKHebrewKaph* = 0x00000CEB
    XKHebrewLamed* = 0x00000CEC
    XKHebrewFinalmem* = 0x00000CED
    XKHebrewMem* = 0x00000CEE
    XKHebrewFinalnun* = 0x00000CEF
    XKHebrewNun* = 0x00000CF0
    XKHebrewSamech* = 0x00000CF1
    XKHebrewSamekh* = 0x00000CF1 # deprecated 
    XKHebrewAyin* = 0x00000CF2
    XKHebrewFinalpe* = 0x00000CF3
    XKHebrewPe* = 0x00000CF4
    XKHebrewFinalzade* = 0x00000CF5
    XKHebrewFinalzadi* = 0x00000CF5 # deprecated 
    XKHebrewZade* = 0x00000CF6
    XKHebrewZadi* = 0x00000CF6 # deprecated 
    XKHebrewQoph* = 0x00000CF7
    XKHebrewKuf* = 0x00000CF7 # deprecated 
    XKHebrewResh* = 0x00000CF8
    XKHebrewShin* = 0x00000CF9
    XKHebrewTaw* = 0x00000CFA
    XKHebrewTaf* = 0x00000CFA # deprecated 
    XKHebrewSwitch* = 0x0000FF7E # Alias for mode_switch 
# XK_HEBREW 
#*
# * Thai
# * Byte 3 = d
# *

when defined(XK_THAI) or true: 
  const
    XKThaiKokai* = 0x00000DA1
    XKThaiKhokhai* = 0x00000DA2
    XKThaiKhokhuat* = 0x00000DA3
    XKThaiKhokhwai* = 0x00000DA4
    XKThaiKhokhon* = 0x00000DA5
    XKThaiKhorakhang* = 0x00000DA6
    XKThaiNgongu* = 0x00000DA7
    XKThaiChochan* = 0x00000DA8
    XKThaiChoching* = 0x00000DA9
    XKThaiChochang* = 0x00000DAA
    XKThaiSoso* = 0x00000DAB
    XKThaiChochoe* = 0x00000DAC
    XKThaiYoying* = 0x00000DAD
    XKThaiDochada* = 0x00000DAE
    XKThaiTopatak* = 0x00000DAF
    XKThaiThothan* = 0x00000DB0
    XKThaiThonangmontho* = 0x00000DB1
    XKThaiThophuthao* = 0x00000DB2
    XKThaiNonen* = 0x00000DB3
    XKThaiDodek* = 0x00000DB4
    XKThaiTotao* = 0x00000DB5
    XKThaiThothung* = 0x00000DB6
    XKThaiThothahan* = 0x00000DB7
    XKThaiThothong* = 0x00000DB8
    XKThaiNonu* = 0x00000DB9
    XKThaiBobaimai* = 0x00000DBA
    XKThaiPopla* = 0x00000DBB
    XKThaiPhophung* = 0x00000DBC
    XKThaiFofa* = 0x00000DBD
    XKThaiPhophan* = 0x00000DBE
    XKThaiFofan* = 0x00000DBF
    XKThaiPhosamphao* = 0x00000DC0
    XKThaiMoma* = 0x00000DC1
    XKThaiYoyak* = 0x00000DC2
    XKThaiRorua* = 0x00000DC3
    XKThaiRu* = 0x00000DC4
    XKThaiLoling* = 0x00000DC5
    XKThaiLu* = 0x00000DC6
    XKThaiWowaen* = 0x00000DC7
    XKThaiSosala* = 0x00000DC8
    XKThaiSorusi* = 0x00000DC9
    XKThaiSosua* = 0x00000DCA
    XKThaiHohip* = 0x00000DCB
    XKThaiLochula* = 0x00000DCC
    XKThaiOang* = 0x00000DCD
    XKThaiHonokhuk* = 0x00000DCE
    XKThaiPaiyannoi* = 0x00000DCF
    XKThaiSaraa* = 0x00000DD0
    XKThaiMaihanakat* = 0x00000DD1
    XKThaiSaraaa* = 0x00000DD2
    XKThaiSaraam* = 0x00000DD3
    XKThaiSarai* = 0x00000DD4
    XKThaiSaraii* = 0x00000DD5
    XKThaiSaraue* = 0x00000DD6
    XKThaiSarauee* = 0x00000DD7
    XKThaiSarau* = 0x00000DD8
    XKThaiSarauu* = 0x00000DD9
    XKThaiPhinthu* = 0x00000DDA
    XKThaiMaihanakatMaitho* = 0x00000DDE
    XKThaiBaht* = 0x00000DDF
    XKThaiSarae* = 0x00000DE0
    XKThaiSaraae* = 0x00000DE1
    XKThaiSarao* = 0x00000DE2
    XKThaiSaraaimaimuan* = 0x00000DE3
    XKThaiSaraaimaimalai* = 0x00000DE4
    XKThaiLakkhangyao* = 0x00000DE5
    XKThaiMaiyamok* = 0x00000DE6
    XKThaiMaitaikhu* = 0x00000DE7
    XKThaiMaiek* = 0x00000DE8
    XKThaiMaitho* = 0x00000DE9
    XKThaiMaitri* = 0x00000DEA
    XKThaiMaichattawa* = 0x00000DEB
    XKThaiThanthakhat* = 0x00000DEC
    XKThaiNikhahit* = 0x00000DED
    XKThaiLeksun* = 0x00000DF0
    XKThaiLeknung* = 0x00000DF1
    XKThaiLeksong* = 0x00000DF2
    XKThaiLeksam* = 0x00000DF3
    XKThaiLeksi* = 0x00000DF4
    XKThaiLekha* = 0x00000DF5
    XKThaiLekhok* = 0x00000DF6
    XKThaiLekchet* = 0x00000DF7
    XKThaiLekpaet* = 0x00000DF8
    XKThaiLekkao* = 0x00000DF9
# XK_THAI 
#*
# *   Korean
# *   Byte 3 = e
# *

when defined(XK_KOREAN) or true: 
  const
    XKHangul* = 0x0000FF31     # Hangul start/stop(toggle) 
    XKHangulStart* = 0x0000FF32 # Hangul start 
    XKHangulEnd* = 0x0000FF33 # Hangul end, English start 
    XKHangulHanja* = 0x0000FF34 # Start Hangul->Hanja Conversion 
    XKHangulJamo* = 0x0000FF35 # Hangul Jamo mode 
    XKHangulRomaja* = 0x0000FF36 # Hangul Romaja mode 
    XKHangulCodeinput* = 0x0000FF37 # Hangul code input mode 
    XKHangulJeonja* = 0x0000FF38 # Jeonja mode 
    XKHangulBanja* = 0x0000FF39 # Banja mode 
    XKHangulPreHanja* = 0x0000FF3A # Pre Hanja conversion 
    XKHangulPostHanja* = 0x0000FF3B # Post Hanja conversion 
    XKHangulSingleCandidate* = 0x0000FF3C # Single candidate 
    XKHangulMultipleCandidate* = 0x0000FF3D # Multiple candidate 
    XKHangulPreviousCandidate* = 0x0000FF3E # Previous candidate 
    XKHangulSpecial* = 0x0000FF3F # Special symbols 
    XKHangulSwitch* = 0x0000FF7E # Alias for mode_switch 
                                   # Hangul Consonant Characters 
    XKHangulKiyeog* = 0x00000EA1
    XKHangulSsangKiyeog* = 0x00000EA2
    XKHangulKiyeogSios* = 0x00000EA3
    XKHangulNieun* = 0x00000EA4
    XKHangulNieunJieuj* = 0x00000EA5
    XKHangulNieunHieuh* = 0x00000EA6
    XKHangulDikeud* = 0x00000EA7
    XKHangulSsangDikeud* = 0x00000EA8
    XKHangulRieul* = 0x00000EA9
    XKHangulRieulKiyeog* = 0x00000EAA
    XKHangulRieulMieum* = 0x00000EAB
    XKHangulRieulPieub* = 0x00000EAC
    XKHangulRieulSios* = 0x00000EAD
    XKHangulRieulTieut* = 0x00000EAE
    XKHangulRieulPhieuf* = 0x00000EAF
    XKHangulRieulHieuh* = 0x00000EB0
    XKHangulMieum* = 0x00000EB1
    XKHangulPieub* = 0x00000EB2
    XKHangulSsangPieub* = 0x00000EB3
    XKHangulPieubSios* = 0x00000EB4
    XKHangulSios* = 0x00000EB5
    XKHangulSsangSios* = 0x00000EB6
    XKHangulIeung* = 0x00000EB7
    XKHangulJieuj* = 0x00000EB8
    XKHangulSsangJieuj* = 0x00000EB9
    XKHangulCieuc* = 0x00000EBA
    XKHangulKhieuq* = 0x00000EBB
    XKHangulTieut* = 0x00000EBC
    XKHangulPhieuf* = 0x00000EBD
    XKHangulHieuh* = 0x00000EBE # Hangul Vowel Characters 
    XKHangulA* = 0x00000EBF
    XKHangulAE* = 0x00000EC0
    XKHangulYA* = 0x00000EC1
    XKHangulYAE* = 0x00000EC2
    XKHangulEO* = 0x00000EC3
    XKHangulE* = 0x00000EC4
    XKHangulYEO* = 0x00000EC5
    XKHangulYE* = 0x00000EC6
    XKHangulO* = 0x00000EC7
    XKHangulWA* = 0x00000EC8
    XKHangulWAE* = 0x00000EC9
    XKHangulOE* = 0x00000ECA
    XKHangulYO* = 0x00000ECB
    XKHangulU* = 0x00000ECC
    XKHangulWEO* = 0x00000ECD
    XKHangulWE* = 0x00000ECE
    XKHangulWI* = 0x00000ECF
    XKHangulYU* = 0x00000ED0
    XKHangulEU* = 0x00000ED1
    XKHangulYI* = 0x00000ED2
    XKHangulI* = 0x00000ED3   # Hangul syllable-final (JongSeong) Characters 
    XKHangulJKiyeog* = 0x00000ED4
    XKHangulJSsangKiyeog* = 0x00000ED5
    XKHangulJKiyeogSios* = 0x00000ED6
    XKHangulJNieun* = 0x00000ED7
    XKHangulJNieunJieuj* = 0x00000ED8
    XKHangulJNieunHieuh* = 0x00000ED9
    XKHangulJDikeud* = 0x00000EDA
    XKHangulJRieul* = 0x00000EDB
    XKHangulJRieulKiyeog* = 0x00000EDC
    XKHangulJRieulMieum* = 0x00000EDD
    XKHangulJRieulPieub* = 0x00000EDE
    XKHangulJRieulSios* = 0x00000EDF
    XKHangulJRieulTieut* = 0x00000EE0
    XKHangulJRieulPhieuf* = 0x00000EE1
    XKHangulJRieulHieuh* = 0x00000EE2
    XKHangulJMieum* = 0x00000EE3
    XKHangulJPieub* = 0x00000EE4
    XKHangulJPieubSios* = 0x00000EE5
    XKHangulJSios* = 0x00000EE6
    XKHangulJSsangSios* = 0x00000EE7
    XKHangulJIeung* = 0x00000EE8
    XKHangulJJieuj* = 0x00000EE9
    XKHangulJCieuc* = 0x00000EEA
    XKHangulJKhieuq* = 0x00000EEB
    XKHangulJTieut* = 0x00000EEC
    XKHangulJPhieuf* = 0x00000EED
    XKHangulJHieuh* = 0x00000EEE # Ancient Hangul Consonant Characters 
    XKHangulRieulYeorinHieuh* = 0x00000EEF
    XKHangulSunkyeongeumMieum* = 0x00000EF0
    XKHangulSunkyeongeumPieub* = 0x00000EF1
    XKHangulPanSios* = 0x00000EF2
    XKHangulKkogjiDalrinIeung* = 0x00000EF3
    XKHangulSunkyeongeumPhieuf* = 0x00000EF4
    XKHangulYeorinHieuh* = 0x00000EF5 # Ancient Hangul Vowel Characters 
    XKHangulAraeA* = 0x00000EF6
    XKHangulAraeAE* = 0x00000EF7 # Ancient Hangul syllable-final (JongSeong) Characters 
    XKHangulJPanSios* = 0x00000EF8
    XKHangulJKkogjiDalrinIeung* = 0x00000EF9
    XKHangulJYeorinHieuh* = 0x00000EFA # Korean currency symbol 
    XKKoreanWon* = 0x00000EFF
# XK_KOREAN 
#*
# *   Armenian
# *   Byte 3 = = $14
# *

when defined(XK_ARMENIAN) or true: 
  const
    XKArmenianEternity* = 0x000014A1
    XKArmenianLigatureEw* = 0x000014A2
    XKArmenianFullStop* = 0x000014A3
    XKArmenianVerjaket* = 0x000014A3
    XKArmenianParenright* = 0x000014A4
    XKArmenianParenleft* = 0x000014A5
    XKArmenianGuillemotright* = 0x000014A6
    XKArmenianGuillemotleft* = 0x000014A7
    XKArmenianEmDash* = 0x000014A8
    XKArmenianDot* = 0x000014A9
    XKArmenianMijaket* = 0x000014A9
    XKArmenianSeparationMark* = 0x000014AA
    XKArmenianBut* = 0x000014AA
    XKArmenianComma* = 0x000014AB
    XKArmenianEnDash* = 0x000014AC
    XKArmenianHyphen* = 0x000014AD
    XKArmenianYentamna* = 0x000014AD
    XKArmenianEllipsis* = 0x000014AE
    XKArmenianExclam* = 0x000014AF
    XKArmenianAmanak* = 0x000014AF
    XKArmenianAccent* = 0x000014B0
    XKArmenianShesht* = 0x000014B0
    XKArmenianQuestion* = 0x000014B1
    XKArmenianParuyk* = 0x000014B1
    XKcArmenianAYB* = 0x000014B2
    XKArmenianAyb* = 0x000014B3
    XKcArmenianBEN* = 0x000014B4
    XKArmenianBen* = 0x000014B5
    XKcArmenianGIM* = 0x000014B6
    XKArmenianGim* = 0x000014B7
    XKcArmenianDA* = 0x000014B8
    XKArmenianDa* = 0x000014B9
    XKcArmenianYECH* = 0x000014BA
    XKArmenianYech* = 0x000014BB
    XKcArmenianZA* = 0x000014BC
    XKArmenianZa* = 0x000014BD
    XKcArmenianE* = 0x000014BE
    XKArmenianE* = 0x000014BF
    XKcArmenianAT* = 0x000014C0
    XKArmenianAt* = 0x000014C1
    XKcArmenianTO* = 0x000014C2
    XKArmenianTo* = 0x000014C3
    XKcArmenianZHE* = 0x000014C4
    XKArmenianZhe* = 0x000014C5
    XKcArmenianINI* = 0x000014C6
    XKArmenianIni* = 0x000014C7
    XKcArmenianLYUN* = 0x000014C8
    XKArmenianLyun* = 0x000014C9
    XKcArmenianKHE* = 0x000014CA
    XKArmenianKhe* = 0x000014CB
    XKcArmenianTSA* = 0x000014CC
    XKArmenianTsa* = 0x000014CD
    XKcArmenianKEN* = 0x000014CE
    XKArmenianKen* = 0x000014CF
    XKcArmenianHO* = 0x000014D0
    XKArmenianHo* = 0x000014D1
    XKcArmenianDZA* = 0x000014D2
    XKArmenianDza* = 0x000014D3
    XKcArmenianGHAT* = 0x000014D4
    XKArmenianGhat* = 0x000014D5
    XKcArmenianTCHE* = 0x000014D6
    XKArmenianTche* = 0x000014D7
    XKcArmenianMEN* = 0x000014D8
    XKArmenianMen* = 0x000014D9
    XKcArmenianHI* = 0x000014DA
    XKArmenianHi* = 0x000014DB
    XKcArmenianNU* = 0x000014DC
    XKArmenianNu* = 0x000014DD
    XKcArmenianSHA* = 0x000014DE
    XKArmenianSha* = 0x000014DF
    XKcArmenianVO* = 0x000014E0
    XKArmenianVo* = 0x000014E1
    XKcArmenianCHA* = 0x000014E2
    XKArmenianCha* = 0x000014E3
    XKcArmenianPE* = 0x000014E4
    XKArmenianPe* = 0x000014E5
    XKcArmenianJE* = 0x000014E6
    XKArmenianJe* = 0x000014E7
    XKcArmenianRA* = 0x000014E8
    XKArmenianRa* = 0x000014E9
    XKcArmenianSE* = 0x000014EA
    XKArmenianSe* = 0x000014EB
    XKcArmenianVEV* = 0x000014EC
    XKArmenianVev* = 0x000014ED
    XKcArmenianTYUN* = 0x000014EE
    XKArmenianTyun* = 0x000014EF
    XKcArmenianRE* = 0x000014F0
    XKArmenianRe* = 0x000014F1
    XKcArmenianTSO* = 0x000014F2
    XKArmenianTso* = 0x000014F3
    XKcArmenianVYUN* = 0x000014F4
    XKArmenianVyun* = 0x000014F5
    XKcArmenianPYUR* = 0x000014F6
    XKArmenianPyur* = 0x000014F7
    XKcArmenianKE* = 0x000014F8
    XKArmenianKe* = 0x000014F9
    XKcArmenianO* = 0x000014FA
    XKArmenianO* = 0x000014FB
    XKcArmenianFE* = 0x000014FC
    XKArmenianFe* = 0x000014FD
    XKArmenianApostrophe* = 0x000014FE
    XKArmenianSectionSign* = 0x000014FF
# XK_ARMENIAN 
#*
# *   Georgian
# *   Byte 3 = = $15
# *

when defined(XK_GEORGIAN) or true: 
  const
    XKGeorgianAn* = 0x000015D0
    XKGeorgianBan* = 0x000015D1
    XKGeorgianGan* = 0x000015D2
    XKGeorgianDon* = 0x000015D3
    XKGeorgianEn* = 0x000015D4
    XKGeorgianVin* = 0x000015D5
    XKGeorgianZen* = 0x000015D6
    XKGeorgianTan* = 0x000015D7
    XKGeorgianIn* = 0x000015D8
    XKGeorgianKan* = 0x000015D9
    XKGeorgianLas* = 0x000015DA
    XKGeorgianMan* = 0x000015DB
    XKGeorgianNar* = 0x000015DC
    XKGeorgianOn* = 0x000015DD
    XKGeorgianPar* = 0x000015DE
    XKGeorgianZhar* = 0x000015DF
    XKGeorgianRae* = 0x000015E0
    XKGeorgianSan* = 0x000015E1
    XKGeorgianTar* = 0x000015E2
    XKGeorgianUn* = 0x000015E3
    XKGeorgianPhar* = 0x000015E4
    XKGeorgianKhar* = 0x000015E5
    XKGeorgianGhan* = 0x000015E6
    XKGeorgianQar* = 0x000015E7
    XKGeorgianShin* = 0x000015E8
    XKGeorgianChin* = 0x000015E9
    XKGeorgianCan* = 0x000015EA
    XKGeorgianJil* = 0x000015EB
    XKGeorgianCil* = 0x000015EC
    XKGeorgianChar* = 0x000015ED
    XKGeorgianXan* = 0x000015EE
    XKGeorgianJhan* = 0x000015EF
    XKGeorgianHae* = 0x000015F0
    XKGeorgianHe* = 0x000015F1
    XKGeorgianHie* = 0x000015F2
    XKGeorgianWe* = 0x000015F3
    XKGeorgianHar* = 0x000015F4
    XKGeorgianHoe* = 0x000015F5
    XKGeorgianFi* = 0x000015F6
# XK_GEORGIAN 
#*
# * Azeri (and other Turkic or Caucasian languages of ex-USSR)
# * Byte 3 = = $16
# *

when defined(XK_CAUCASUS) or true: 
  # latin 
  const
    XKcCcedillaabovedot* = 0x000016A2
    XKcXabovedot* = 0x000016A3
    XKcQabovedot* = 0x000016A5
    XKcIbreve* = 0x000016A6
    XKcIE* = 0x000016A7
    XKcUO* = 0x000016A8
    XKcZstroke* = 0x000016A9
    XKcGcaron* = 0x000016AA
    XKcObarred* = 0x000016AF
    XKCcedillaabovedot* = 0x000016B2
    XKXabovedot* = 0x000016B3
    XKcOcaron* = 0x000016B4
    XKQabovedot* = 0x000016B5
    XKIbreve* = 0x000016B6
    XKIe* = 0x000016B7
    XKUo* = 0x000016B8
    XKZstroke* = 0x000016B9
    XKGcaron* = 0x000016BA
    XKOcaron* = 0x000016BD
    XKObarred* = 0x000016BF
    XKcSCHWA* = 0x000016C6
    XKSchwa* = 0x000016F6 # those are not really Caucasus, but I put them here for now 
                           # For Inupiak 
    XKcLbelowdot* = 0x000016D1
    XKcLstrokebelowdot* = 0x000016D2
    XKLbelowdot* = 0x000016E1
    XKLstrokebelowdot* = 0x000016E2 # For Guarani 
    XKcGtilde* = 0x000016D3
    XKGtilde* = 0x000016E3
# XK_CAUCASUS 
#*
# *   Vietnamese
# *   Byte 3 = = $1e
# *

when defined(XK_VIETNAMESE) or true:
  const 
    XKcAbelowdot* = 0x00001EA0
    XKAbelowdot* = 0x00001EA1
    XKcAhook* = 0x00001EA2
    XKAhook* = 0x00001EA3
    XKcAcircumflexacute* = 0x00001EA4
    XKAcircumflexacute* = 0x00001EA5
    XKcAcircumflexgrave* = 0x00001EA6
    XKAcircumflexgrave* = 0x00001EA7
    XKcAcircumflexhook* = 0x00001EA8
    XKAcircumflexhook* = 0x00001EA9
    XKcAcircumflextilde* = 0x00001EAA
    XKAcircumflextilde* = 0x00001EAB
    XKcAcircumflexbelowdot* = 0x00001EAC
    XKAcircumflexbelowdot* = 0x00001EAD
    XKcAbreveacute* = 0x00001EAE
    XKAbreveacute* = 0x00001EAF
    XKcAbrevegrave* = 0x00001EB0
    XKAbrevegrave* = 0x00001EB1
    XKcAbrevehook* = 0x00001EB2
    XKAbrevehook* = 0x00001EB3
    XKcAbrevetilde* = 0x00001EB4
    XKAbrevetilde* = 0x00001EB5
    XKcAbrevebelowdot* = 0x00001EB6
    XKAbrevebelowdot* = 0x00001EB7
    XKcEbelowdot* = 0x00001EB8
    XKEbelowdot* = 0x00001EB9
    XKcEhook* = 0x00001EBA
    XKEhook* = 0x00001EBB
    XKcEtilde* = 0x00001EBC
    XKEtilde* = 0x00001EBD
    XKcEcircumflexacute* = 0x00001EBE
    XKEcircumflexacute* = 0x00001EBF
    XKcEcircumflexgrave* = 0x00001EC0
    XKEcircumflexgrave* = 0x00001EC1
    XKcEcircumflexhook* = 0x00001EC2
    XKEcircumflexhook* = 0x00001EC3
    XKcEcircumflextilde* = 0x00001EC4
    XKEcircumflextilde* = 0x00001EC5
    XKcEcircumflexbelowdot* = 0x00001EC6
    XKEcircumflexbelowdot* = 0x00001EC7
    XKcIhook* = 0x00001EC8
    XKIhook* = 0x00001EC9
    XKcIbelowdot* = 0x00001ECA
    XKIbelowdot* = 0x00001ECB
    XKcObelowdot* = 0x00001ECC
    XKObelowdot* = 0x00001ECD
    XKcOhook* = 0x00001ECE
    XKOhook* = 0x00001ECF
    XKcOcircumflexacute* = 0x00001ED0
    XKOcircumflexacute* = 0x00001ED1
    XKcOcircumflexgrave* = 0x00001ED2
    XKOcircumflexgrave* = 0x00001ED3
    XKcOcircumflexhook* = 0x00001ED4
    XKOcircumflexhook* = 0x00001ED5
    XKcOcircumflextilde* = 0x00001ED6
    XKOcircumflextilde* = 0x00001ED7
    XKcOcircumflexbelowdot* = 0x00001ED8
    XKOcircumflexbelowdot* = 0x00001ED9
    XKcOhornacute* = 0x00001EDA
    XKOhornacute* = 0x00001EDB
    XKcOhorngrave* = 0x00001EDC
    XKOhorngrave* = 0x00001EDD
    XKcOhornhook* = 0x00001EDE
    XKOhornhook* = 0x00001EDF
    XKcOhorntilde* = 0x00001EE0
    XKOhorntilde* = 0x00001EE1
    XKcOhornbelowdot* = 0x00001EE2
    XKOhornbelowdot* = 0x00001EE3
    XKcUbelowdot* = 0x00001EE4
    XKUbelowdot* = 0x00001EE5
    XKcUhook* = 0x00001EE6
    XKUhook* = 0x00001EE7
    XKcUhornacute* = 0x00001EE8
    XKUhornacute* = 0x00001EE9
    XKcUhorngrave* = 0x00001EEA
    XKUhorngrave* = 0x00001EEB
    XKcUhornhook* = 0x00001EEC
    XKUhornhook* = 0x00001EED
    XKcUhorntilde* = 0x00001EEE
    XKUhorntilde* = 0x00001EEF
    XKcUhornbelowdot* = 0x00001EF0
    XKUhornbelowdot* = 0x00001EF1
    XKcYbelowdot* = 0x00001EF4
    XKYbelowdot* = 0x00001EF5
    XKcYhook* = 0x00001EF6
    XKYhook* = 0x00001EF7
    XKcYtilde* = 0x00001EF8
    XKYtilde* = 0x00001EF9
    XKcOhorn* = 0x00001EFA     # U+01a0 
    XKOhorn* = 0x00001EFB      # U+01a1 
    XKcUhorn* = 0x00001EFC     # U+01af 
    XKUhorn* = 0x00001EFD      # U+01b0 
    XKCombiningTilde* = 0x00001E9F # U+0303 
    XKCombiningGrave* = 0x00001EF2 # U+0300 
    XKCombiningAcute* = 0x00001EF3 # U+0301 
    XKCombiningHook* = 0x00001EFE # U+0309 
    XKCombiningBelowdot* = 0x00001EFF # U+0323 
# XK_VIETNAMESE 

when defined(XK_CURRENCY) or true: 
  const
    XKEcuSign* = 0x000020A0
    XKColonSign* = 0x000020A1
    XKCruzeiroSign* = 0x000020A2
    XKFFrancSign* = 0x000020A3
    XKLiraSign* = 0x000020A4
    XKMillSign* = 0x000020A5
    XKNairaSign* = 0x000020A6
    XKPesetaSign* = 0x000020A7
    XKRupeeSign* = 0x000020A8
    XKWonSign* = 0x000020A9
    XKNewSheqelSign* = 0x000020AA
    XKDongSign* = 0x000020AB
    XKEuroSign* = 0x000020AC
# implementation
