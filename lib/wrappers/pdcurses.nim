{.deadCodeElim: on.}

discard """

curses.h:
#ifdef C2NIM
#dynlib pdcursesdll
#skipinclude
#prefix PDC_
#def FALSE
#def TRUE
#def NULL
#def bool unsigned char
#def chtype unsigned long
#def cchar_t unsigned long
#def attr_t unsigned long
#def mmask_t unsigned long
#def wchar_t char
#def PDCEX
#cdecl
#endif

pdcwin.h:
#ifdef C2NIM
#dynlib pdcursesdll
#skipinclude
#prefix pdc_
#prefix PDC_
#stdcall
#endif
"""

when defined(windows):
  import windows
  
  const
    pdcursesdll = "pdcurses.dll"
    unixOS = false
  {.pragma: extdecl, stdcall.}

when not defined(windows):
  const
    unixOS = true
  {.pragma: extdecl, cdecl.}

type
  Cunsignedchar = Char
  Cunsignedlong = Uint32

const 
  Build* = 3401
  Pdcurses* = 1               # PDCurses-only routines 
  Xopen* = 1                  # X/Open Curses routines 
  SYSVcurses* = 1             # System V Curses routines 
  BSDcurses* = 1              # BSD Curses routines 
  ChtypeLong* = 1            # size of chtype; long 
  Err* = (- 1)
  Ok* = 0
  ButtonReleased* = 0x00000000
  ButtonPressed* = 0x00000001
  ButtonClicked* = 0x00000002
  ButtonDoubleClicked* = 0x00000003
  ButtonTripleClicked* = 0x00000004
  ButtonMoved* = 0x00000005  # PDCurses 
  WheelScrolled* = 0x00000006 # PDCurses 
  ButtonActionMask* = 0x00000007 # PDCurses 
  ButtonModifierMask* = 0x00000038 # PDCurses 
  MouseMoved* = 0x00000008
  MousePosition* = 0x00000010
  MouseWheelUp* = 0x00000020
  MouseWheelDown* = 0x00000040
  Button1Released* = 0x00000001
  Button1Pressed* = 0x00000002
  Button1Clicked* = 0x00000004
  Button1DoubleClicked* = 0x00000008
  Button1TripleClicked* = 0x00000010
  Button1Moved* = 0x00000010 # PDCurses 
  Button2Released* = 0x00000020
  Button2Pressed* = 0x00000040
  Button2Clicked* = 0x00000080
  Button2DoubleClicked* = 0x00000100
  Button2TripleClicked* = 0x00000200
  Button2Moved* = 0x00000200 # PDCurses 
  Button3Released* = 0x00000400
  Button3Pressed* = 0x00000800
  Button3Clicked* = 0x00001000
  Button3DoubleClicked* = 0x00002000
  Button3TripleClicked* = 0x00004000
  Button3Moved* = 0x00004000 # PDCurses 
  Button4Released* = 0x00008000
  Button4Pressed* = 0x00010000
  Button4Clicked* = 0x00020000
  Button4DoubleClicked* = 0x00040000
  Button4TripleClicked* = 0x00080000
  Button5Released* = 0x00100000
  Button5Pressed* = 0x00200000
  Button5Clicked* = 0x00400000
  Button5DoubleClicked* = 0x00800000
  Button5TripleClicked* = 0x01000000
  MouseWheelScroll* = 0x02000000 # PDCurses 
  ButtonModifierShift* = 0x04000000 # PDCurses 
  ButtonModifierControl* = 0x08000000 # PDCurses 
  ButtonModifierAlt* = 0x10000000 # PDCurses 
  AllMouseEvents* = 0x1FFFFFFF
  ReportMousePosition* = 0x20000000
  ANormal* = 0
  AAltcharset* = 0x00010000
  ARightline* = 0x00020000
  ALeftline* = 0x00040000
  AInvis* = 0x00080000
  AUnderline* = 0x00100000
  AReverse* = 0x00200000
  ABlink* = 0x00400000
  ABold* = 0x00800000
  AAttributes* = 0xFFFF0000
  AChartext* = 0x0000FFFF
  AColor* = 0xFF000000
  AItalic* = A_INVIS
  AProtect* = (A_UNDERLINE or A_LEFTLINE or A_RIGHTLINE)
  AttrShift* = 19
  ColorShift* = 24
  AStandout* = (A_REVERSE or A_BOLD) # X/Open 
  ADim* = A_NORMAL
  ChrMsk* = A_CHARTEXT       # Obsolete 
  AtrMsk* = A_ATTRIBUTES     # Obsolete 
  AtrNrm* = A_NORMAL         # Obsolete 
  WaAltcharset* = A_ALTCHARSET
  WaBlink* = A_BLINK
  WaBold* = A_BOLD
  WaDim* = A_DIM
  WaInvis* = A_INVIS
  WaLeft* = A_LEFTLINE
  WaProtect* = A_PROTECT
  WaReverse* = A_REVERSE
  WaRight* = A_RIGHTLINE
  WaStandout* = A_STANDOUT
  WaUnderline* = A_UNDERLINE
  WaHorizontal* = A_NORMAL
  WaLow* = A_NORMAL
  WaTop* = A_NORMAL
  WaVertical* = A_NORMAL
  ColorBlack* = 0
  ColorRed* = 1
  ColorGreen* = 2
  ColorBlue* = 4
  ColorCyan* = (COLOR_BLUE or COLOR_GREEN)
  ColorMagenta* = (COLOR_RED or COLOR_BLUE)
  ColorYellow* = (COLOR_RED or COLOR_GREEN)
  ColorWhite* = 7
  KeyCodeYes* = 0x00000100  # If get_wch() gives a key code 
  KeyBreak* = 0x00000101     # Not on PC KBD 
  KeyDown* = 0x00000102      # Down arrow key 
  KeyUp* = 0x00000103        # Up arrow key 
  KeyLeft* = 0x00000104      # Left arrow key 
  KeyRight* = 0x00000105     # Right arrow key 
  KeyHome* = 0x00000106      # home key 
  KeyBackspace* = 0x00000107 # not on pc 
  KeyF0* = 0x00000108        # function keys; 64 reserved 
  KeyDl* = 0x00000148        # delete line 
  KeyIl* = 0x00000149        # insert line 
  KeyDc* = 0x0000014A        # delete character 
  KeyIc* = 0x0000014B        # insert char or enter ins mode 
  KeyEic* = 0x0000014C       # exit insert char mode 
  KeyClear* = 0x0000014D     # clear screen 
  KeyEos* = 0x0000014E       # clear to end of screen 
  KeyEol* = 0x0000014F       # clear to end of line 
  KeySf* = 0x00000150        # scroll 1 line forward 
  KeySr* = 0x00000151        # scroll 1 line back (reverse) 
  KeyNpage* = 0x00000152     # next page 
  KeyPpage* = 0x00000153     # previous page 
  KeyStab* = 0x00000154      # set tab 
  KeyCtab* = 0x00000155      # clear tab 
  KeyCatab* = 0x00000156     # clear all tabs 
  KeyEnter* = 0x00000157     # enter or send (unreliable) 
  KeySreset* = 0x00000158    # soft/reset (partial/unreliable) 
  KeyReset* = 0x00000159     # reset/hard reset (unreliable) 
  KeyPrint* = 0x0000015A     # print/copy 
  KeyLl* = 0x0000015B        # home down/bottom (lower left) 
  KeyAbort* = 0x0000015C     # abort/terminate key (any) 
  KeyShelp* = 0x0000015D     # short help 
  KeyLhelp* = 0x0000015E     # long help 
  KeyBtab* = 0x0000015F      # Back tab key 
  KeyBeg* = 0x00000160       # beg(inning) key 
  KeyCancel* = 0x00000161    # cancel key 
  KeyClose* = 0x00000162     # close key 
  KeyCommand* = 0x00000163   # cmd (command) key 
  KeyCopy* = 0x00000164      # copy key 
  KeyCreate* = 0x00000165    # create key 
  KeyEnd* = 0x00000166       # end key 
  KeyExit* = 0x00000167      # exit key 
  KeyFind* = 0x00000168      # find key 
  KeyHelp* = 0x00000169      # help key 
  KeyMark* = 0x0000016A      # mark key 
  KeyMessage* = 0x0000016B   # message key 
  KeyMove* = 0x0000016C      # move key 
  KeyNext* = 0x0000016D      # next object key 
  KeyOpen* = 0x0000016E      # open key 
  KeyOptions* = 0x0000016F   # options key 
  KeyPrevious* = 0x00000170  # previous object key 
  KeyRedo* = 0x00000171      # redo key 
  KeyReference* = 0x00000172 # ref(erence) key 
  KeyRefresh* = 0x00000173   # refresh key 
  KeyReplace* = 0x00000174   # replace key 
  KeyRestart* = 0x00000175   # restart key 
  KeyResume* = 0x00000176    # resume key 
  KeySave* = 0x00000177      # save key 
  KeySbeg* = 0x00000178      # shifted beginning key 
  KeyScancel* = 0x00000179   # shifted cancel key 
  KeyScommand* = 0x0000017A  # shifted command key 
  KeyScopy* = 0x0000017B     # shifted copy key 
  KeyScreate* = 0x0000017C   # shifted create key 
  KeySdc* = 0x0000017D       # shifted delete char key 
  KeySdl* = 0x0000017E       # shifted delete line key 
  KeySelect* = 0x0000017F    # select key 
  KeySend* = 0x00000180      # shifted end key 
  KeySeol* = 0x00000181      # shifted clear line key 
  KeySexit* = 0x00000182     # shifted exit key 
  KeySfind* = 0x00000183     # shifted find key 
  KeyShome* = 0x00000184     # shifted home key 
  KeySic* = 0x00000185       # shifted input key 
  KeySleft* = 0x00000187     # shifted left arrow key 
  KeySmessage* = 0x00000188  # shifted message key 
  KeySmove* = 0x00000189     # shifted move key 
  KeySnext* = 0x0000018A     # shifted next key 
  KeySoptions* = 0x0000018B  # shifted options key 
  KeySprevious* = 0x0000018C # shifted prev key 
  KeySprint* = 0x0000018D    # shifted print key 
  KeySredo* = 0x0000018E     # shifted redo key 
  KeySreplace* = 0x0000018F  # shifted replace key 
  KeySright* = 0x00000190    # shifted right arrow 
  KeySrsume* = 0x00000191    # shifted resume key 
  KeySsave* = 0x00000192     # shifted save key 
  KeySsuspend* = 0x00000193  # shifted suspend key 
  KeySundo* = 0x00000194     # shifted undo key 
  KeySuspend* = 0x00000195   # suspend key 
  KeyUndo* = 0x00000196      # undo key 
  Alt0* = 0x00000197
  Alt1* = 0x00000198
  Alt2* = 0x00000199
  Alt3* = 0x0000019A
  Alt4* = 0x0000019B
  Alt5* = 0x0000019C
  Alt6* = 0x0000019D
  Alt7* = 0x0000019E
  Alt8* = 0x0000019F
  Alt9* = 0x000001A0
  AltA* = 0x000001A1
  AltB* = 0x000001A2
  AltC* = 0x000001A3
  AltD* = 0x000001A4
  AltE* = 0x000001A5
  AltF* = 0x000001A6
  AltG* = 0x000001A7
  AltH* = 0x000001A8
  AltI* = 0x000001A9
  AltJ* = 0x000001AA
  AltK* = 0x000001AB
  AltL* = 0x000001AC
  AltM* = 0x000001AD
  AltN* = 0x000001AE
  AltO* = 0x000001AF
  AltP* = 0x000001B0
  AltQ* = 0x000001B1
  AltR* = 0x000001B2
  AltS* = 0x000001B3
  AltT* = 0x000001B4
  AltU* = 0x000001B5
  AltV* = 0x000001B6
  AltW* = 0x000001B7
  AltX* = 0x000001B8
  AltY* = 0x000001B9
  AltZ* = 0x000001BA
  CtlLeft* = 0x000001BB      # Control-Left-Arrow 
  CtlRight* = 0x000001BC
  CtlPgup* = 0x000001BD
  CtlPgdn* = 0x000001BE
  CtlHome* = 0x000001BF
  CtlEnd* = 0x000001C0
  KeyA1* = 0x000001C1        # upper left on Virtual keypad 
  KeyA2* = 0x000001C2        # upper middle on Virt. keypad 
  KeyA3* = 0x000001C3        # upper right on Vir. keypad 
  KeyB1* = 0x000001C4        # middle left on Virt. keypad 
  KeyB2* = 0x000001C5        # center on Virt. keypad 
  KeyB3* = 0x000001C6        # middle right on Vir. keypad 
  KeyC1* = 0x000001C7        # lower left on Virt. keypad 
  KeyC2* = 0x000001C8        # lower middle on Virt. keypad 
  KeyC3* = 0x000001C9        # lower right on Vir. keypad 
  Padslash* = 0x000001CA      # slash on keypad 
  Padenter* = 0x000001CB      # enter on keypad 
  CtlPadenter* = 0x000001CC  # ctl-enter on keypad 
  AltPadenter* = 0x000001CD  # alt-enter on keypad 
  Padstop* = 0x000001CE       # stop on keypad 
  Padstar* = 0x000001CF       # star on keypad 
  Padminus* = 0x000001D0      # minus on keypad 
  Padplus* = 0x000001D1       # plus on keypad 
  CtlPadstop* = 0x000001D2   # ctl-stop on keypad 
  CtlPadcenter* = 0x000001D3 # ctl-enter on keypad 
  CtlPadplus* = 0x000001D4   # ctl-plus on keypad 
  CtlPadminus* = 0x000001D5  # ctl-minus on keypad 
  CtlPadslash* = 0x000001D6  # ctl-slash on keypad 
  CtlPadstar* = 0x000001D7   # ctl-star on keypad 
  AltPadplus* = 0x000001D8   # alt-plus on keypad 
  AltPadminus* = 0x000001D9  # alt-minus on keypad 
  AltPadslash* = 0x000001DA  # alt-slash on keypad 
  AltPadstar* = 0x000001DB   # alt-star on keypad 
  AltPadstop* = 0x000001DC   # alt-stop on keypad 
  CtlIns* = 0x000001DD       # ctl-insert 
  AltDel* = 0x000001DE       # alt-delete 
  AltIns* = 0x000001DF       # alt-insert 
  CtlUp* = 0x000001E0        # ctl-up arrow 
  CtlDown* = 0x000001E1      # ctl-down arrow 
  CtlTab* = 0x000001E2       # ctl-tab 
  AltTab* = 0x000001E3
  AltMinus* = 0x000001E4
  AltEqual* = 0x000001E5
  AltHome* = 0x000001E6
  AltPgup* = 0x000001E7
  AltPgdn* = 0x000001E8
  AltEnd* = 0x000001E9
  AltUp* = 0x000001EA        # alt-up arrow 
  AltDown* = 0x000001EB      # alt-down arrow 
  AltRight* = 0x000001EC     # alt-right arrow 
  AltLeft* = 0x000001ED      # alt-left arrow 
  AltEnter* = 0x000001EE     # alt-enter 
  AltEsc* = 0x000001EF       # alt-escape 
  AltBquote* = 0x000001F0    # alt-back quote 
  AltLbracket* = 0x000001F1  # alt-left bracket 
  AltRbracket* = 0x000001F2  # alt-right bracket 
  AltSemicolon* = 0x000001F3 # alt-semi-colon 
  AltFquote* = 0x000001F4    # alt-forward quote 
  AltComma* = 0x000001F5     # alt-comma 
  AltStop* = 0x000001F6      # alt-stop 
  AltFslash* = 0x000001F7    # alt-forward slash 
  AltBksp* = 0x000001F8      # alt-backspace 
  CtlBksp* = 0x000001F9      # ctl-backspace 
  Pad0* = 0x000001FA          # keypad 0 
  CtlPad0* = 0x000001FB      # ctl-keypad 0 
  CtlPad1* = 0x000001FC
  CtlPad2* = 0x000001FD
  CtlPad3* = 0x000001FE
  CtlPad4* = 0x000001FF
  CtlPad5* = 0x00000200
  CtlPad6* = 0x00000201
  CtlPad7* = 0x00000202
  CtlPad8* = 0x00000203
  CtlPad9* = 0x00000204
  AltPad0* = 0x00000205      # alt-keypad 0 
  AltPad1* = 0x00000206
  AltPad2* = 0x00000207
  AltPad3* = 0x00000208
  AltPad4* = 0x00000209
  AltPad5* = 0x0000020A
  AltPad6* = 0x0000020B
  AltPad7* = 0x0000020C
  AltPad8* = 0x0000020D
  AltPad9* = 0x0000020E
  CtlDel* = 0x0000020F       # clt-delete 
  AltBslash* = 0x00000210    # alt-back slash 
  CtlEnter* = 0x00000211     # ctl-enter 
  ShfPadenter* = 0x00000212  # shift-enter on keypad 
  ShfPadslash* = 0x00000213  # shift-slash on keypad 
  ShfPadstar* = 0x00000214   # shift-star  on keypad 
  ShfPadplus* = 0x00000215   # shift-plus  on keypad 
  ShfPadminus* = 0x00000216  # shift-minus on keypad 
  ShfUp* = 0x00000217        # shift-up on keypad 
  ShfDown* = 0x00000218      # shift-down on keypad 
  ShfIc* = 0x00000219        # shift-insert on keypad 
  ShfDc* = 0x0000021A        # shift-delete on keypad 
  KeyMouse* = 0x0000021B     # "mouse" key 
  KeyShiftL* = 0x0000021C   # Left-shift 
  KeyShiftR* = 0x0000021D   # Right-shift 
  KeyControlL* = 0x0000021E # Left-control 
  KeyControlR* = 0x0000021F # Right-control 
  KeyAltL* = 0x00000220     # Left-alt 
  KeyAltR* = 0x00000221     # Right-alt 
  KeyResize* = 0x00000222    # Window resize 
  KeySup* = 0x00000223       # Shifted up arrow 
  KeySdown* = 0x00000224     # Shifted down arrow 
  KeyMin* = KEY_BREAK        # Minimum curses key value 
  KeyMax* = KEY_SDOWN        # Maximum curses key 
  ClipSuccess* = 0
  ClipAccessError* = 1
  ClipEmpty* = 2
  ClipMemoryError* = 3
  KeyModifierShift* = 1
  KeyModifierControl* = 2
  KeyModifierAlt* = 4
  KeyModifierNumlock* = 8

when appType == "gui":
  const
    BUTTON_SHIFT* = BUTTON_MODIFIER_SHIFT
    BUTTON_CONTROL* = BUTTON_MODIFIER_CONTROL
    BUTTON_CTRL* = BUTTON_MODIFIER_CONTROL
    BUTTON_ALT* = BUTTON_MODIFIER_ALT
else:
  const 
    ButtonShift* = 0x00000008
    ButtonControl* = 0x00000010
    ButtonAlt* = 0x00000020

type 
  TMOUSE_STATUS*{.pure, final.} = object 
    x*: Cint                  # absolute column, 0 based, measured in characters 
    y*: Cint                  # absolute row, 0 based, measured in characters 
    button*: Array[0..3 - 1, Cshort] # state of each button 
    changes*: Cint            # flags indicating what has changed with the mouse 
  
  TMEVENT*{.pure, final.} = object 
    id*: Cshort               # unused, always 0 
    x*: Cint
    y*: Cint
    z*: Cint                  # x, y same as MOUSE_STATUS; z unused 
    bstate*: Cunsignedlong    # equivalent to changes + button[], but
                              #                           in the same format as used for mousemask() 
  
  TWINDOW*{.pure, final.} = object 
    cury*: Cint              # current pseudo-cursor 
    curx*: Cint
    maxy*: Cint              # max window coordinates 
    maxx*: Cint
    begy*: Cint              # origin on screen 
    begx*: Cint
    flags*: Cint             # window properties 
    attrs*: Cunsignedlong    # standard attributes and colors 
    bkgd*: Cunsignedlong     # background, normally blank 
    clear*: Cunsignedchar    # causes clear at next refresh 
    leaveit*: Cunsignedchar  # leaves cursor where it is 
    scroll*: Cunsignedchar   # allows window scrolling 
    nodelay*: Cunsignedchar  # input character wait flag 
    immed*: Cunsignedchar    # immediate update flag 
    sync*: Cunsignedchar     # synchronise window ancestors 
    use_keypad*: Cunsignedchar # flags keypad key mode active 
    y*: ptr ptr Cunsignedlong # pointer to line pointer array 
    firstch*: ptr Cint       # first changed character in line 
    lastch*: ptr Cint        # last changed character in line 
    tmarg*: Cint             # top of scrolling region 
    bmarg*: Cint             # bottom of scrolling region 
    delayms*: Cint           # milliseconds of delay for getch() 
    parx*: Cint
    pary*: Cint              # coords relative to parent (0,0) 
    parent*: ptr TWINDOW        # subwin's pointer to parent win 
  
  TPANELOBS*{.pure, final.} = object 
    above*: ptr TPANELOBS
    pan*: ptr TPANEL

  TPANEL*{.pure, final.} = object 
    win*: ptr TWINDOW
    wstarty*: Cint
    wendy*: Cint
    wstartx*: Cint
    wendx*: Cint
    below*: ptr TPANEL
    above*: ptr TPANEL
    user*: Pointer
    obscure*: ptr TPANELOBS

when unixOS:
  type
    TSCREEN*{.pure, final.} = object 
      alive*: Cunsignedchar     # if initscr() called, and not endwin() 
      autocr*: Cunsignedchar    # if cr -> lf 
      cbreak*: Cunsignedchar    # if terminal unbuffered 
      echo*: Cunsignedchar      # if terminal echo 
      raw_inp*: Cunsignedchar   # raw input mode (v. cooked input) 
      raw_out*: Cunsignedchar   # raw output mode (7 v. 8 bits) 
      audible*: Cunsignedchar   # FALSE if the bell is visual 
      mono*: Cunsignedchar      # TRUE if current screen is mono 
      resized*: Cunsignedchar   # TRUE if TERM has been resized 
      orig_attr*: Cunsignedchar # TRUE if we have the original colors 
      orig_fore*: Cshort        # original screen foreground color 
      orig_back*: Cshort        # original screen foreground color 
      cursrow*: Cint            # position of physical cursor 
      curscol*: Cint            # position of physical cursor 
      visibility*: Cint         # visibility of cursor 
      orig_cursor*: Cint        # original cursor size 
      lines*: Cint              # new value for LINES 
      cols*: Cint               # new value for COLS 
      trap_mbe*: Cunsignedlong # trap these mouse button events 
      map_mbe_to_key*: Cunsignedlong # map mouse buttons to slk 
      mouse_wait*: Cint # time to wait (in ms) for a button release after a press
      slklines*: Cint           # lines in use by slk_init() 
      slk_winptr*: ptr TWINDOW   # window for slk 
      linesrippedoff*: Cint     # lines ripped off via ripoffline() 
      linesrippedoffontop*: Cint # lines ripped off on top via ripoffline() 
      delaytenths*: Cint        # 1/10ths second to wait block getch() for 
      preserve*: Cunsignedchar # TRUE if screen background to be preserved 
      restore*: Cint           # specifies if screen background to be restored, and how 
      save_key_modifiers*: Cunsignedchar # TRUE if each key modifiers saved with each key press 
      return_key_modifiers*: Cunsignedchar # TRUE if modifier keys are returned as "real" keys 
      key_code*: Cunsignedchar # TRUE if last key is a special key;
      XcurscrSize*: Cint        # size of Xcurscr shared memory block 
      sb_on*: Cunsignedchar
      sb_viewport_y*: Cint
      sb_viewport_x*: Cint
      sb_total_y*: Cint
      sb_total_x*: Cint
      sb_cur_y*: Cint
      sb_cur_x*: Cint
      line_color*: Cshort       # color of line attributes - default -1 
else:
  type
    TSCREEN*{.pure, final.} = object 
      alive*: cunsignedchar     # if initscr() called, and not endwin() 
      autocr*: cunsignedchar    # if cr -> lf 
      cbreak*: cunsignedchar    # if terminal unbuffered 
      echo*: cunsignedchar      # if terminal echo 
      raw_inp*: cunsignedchar   # raw input mode (v. cooked input) 
      raw_out*: cunsignedchar   # raw output mode (7 v. 8 bits) 
      audible*: cunsignedchar   # FALSE if the bell is visual 
      mono*: cunsignedchar      # TRUE if current screen is mono 
      resized*: cunsignedchar   # TRUE if TERM has been resized 
      orig_attr*: cunsignedchar # TRUE if we have the original colors 
      orig_fore*: cshort        # original screen foreground color 
      orig_back*: cshort        # original screen foreground color 
      cursrow*: cint            # position of physical cursor 
      curscol*: cint            # position of physical cursor 
      visibility*: cint         # visibility of cursor 
      orig_cursor*: cint        # original cursor size 
      lines*: cint              # new value for LINES 
      cols*: cint               # new value for COLS 
      trap_mbe*: cunsignedlong # trap these mouse button events 
      map_mbe_to_key*: cunsignedlong # map mouse buttons to slk 
      mouse_wait*: cint # time to wait (in ms) for a button release after a press
      slklines*: cint           # lines in use by slk_init() 
      slk_winptr*: ptr TWINDOW   # window for slk 
      linesrippedoff*: cint     # lines ripped off via ripoffline() 
      linesrippedoffontop*: cint # lines ripped off on top via ripoffline() 
      delaytenths*: cint        # 1/10ths second to wait block getch() for 
      preserve*: cunsignedchar # TRUE if screen background to be preserved 
      restore*: cint           # specifies if screen background to be restored, and how 
      save_key_modifiers*: cunsignedchar # TRUE if each key modifiers saved with each key press 
      return_key_modifiers*: cunsignedchar # TRUE if modifier keys are returned as "real" keys 
      key_code*: cunsignedchar # TRUE if last key is a special key;
      line_color*: cshort       # color of line attributes - default -1 

var
  lines*{.importc: "LINES", dynlib: pdcursesdll.}: Cint
  cols*{.importc: "COLS", dynlib: pdcursesdll.}: Cint
  stdscr*{.importc: "stdscr", dynlib: pdcursesdll.}: ptr TWINDOW
  curscr*{.importc: "curscr", dynlib: pdcursesdll.}: ptr TWINDOW
  sp*{.importc: "SP", dynlib: pdcursesdll.}: ptr TSCREEN
  mouseStatus*{.importc: "Mouse_status", dynlib: pdcursesdll.}: TMOUSE_STATUS
  colors*{.importc: "COLORS", dynlib: pdcursesdll.}: Cint
  colorPairs*{.importc: "COLOR_PAIRS", dynlib: pdcursesdll.}: Cint
  tabsize*{.importc: "TABSIZE", dynlib: pdcursesdll.}: Cint
  acsMap*{.importc: "acs_map", dynlib: pdcursesdll.}: ptr Cunsignedlong
  ttytype*{.importc: "ttytype", dynlib: pdcursesdll.}: Cstring

template buttonChanged*(x: Expr): Expr = 
  (Mouse_status.changes and (1 shl ((x) - 1)))

template buttonStatus*(x: Expr): Expr = 
  (Mouse_status.button[(x) - 1])

template acsPick*(w, n: Expr): Expr = 
  (cast[Int32](w) or A_ALTCHARSET)

template keyF*(n: Expr): Expr = 
  (KEY_F0 + (n))

template colorPair*(n: Expr): Expr = 
  ((cast[cunsignedlong]((n)) shl COLOR_SHIFT) and A_COLOR)

template pairNumber*(n: Expr): Expr = 
  (((n) and A_COLOR) shr COLOR_SHIFT)

const
  #MOUSE_X_POS* = (Mouse_status.x)
  #MOUSE_Y_POS* = (Mouse_status.y)
  #A_BUTTON_CHANGED* = (Mouse_status.changes and 7)
  #MOUSE_MOVED* = (Mouse_status.changes and MOUSE_MOVED)
  #MOUSE_POS_REPORT* = (Mouse_status.changes and MOUSE_POSITION)
  #MOUSE_WHEEL_UP* = (Mouse_status.changes and MOUSE_WHEEL_UP)
  #MOUSE_WHEEL_DOWN* = (Mouse_status.changes and MOUSE_WHEEL_DOWN)
  AcsUlcorner* = ACS_PICK('l', '+')
  AcsLlcorner* = ACS_PICK('m', '+')
  AcsUrcorner* = ACS_PICK('k', '+')
  AcsLrcorner* = ACS_PICK('j', '+')
  AcsRtee* = ACS_PICK('u', '+')
  AcsLtee* = ACS_PICK('t', '+')
  AcsBtee* = ACS_PICK('v', '+')
  AcsTtee* = ACS_PICK('w', '+')
  AcsHline* = ACS_PICK('q', '-')
  AcsVline* = ACS_PICK('x', '|')
  AcsPlus* = ACS_PICK('n', '+')
  AcsS1* = ACS_PICK('o', '-')
  AcsS9* = ACS_PICK('s', '_')
  AcsDiamond* = ACS_PICK('`', '+')
  AcsCkboard* = ACS_PICK('a', ':')
  AcsDegree* = ACS_PICK('f', '\'')
  AcsPlminus* = ACS_PICK('g', '#')
  AcsBullet* = ACS_PICK('~', 'o')
  AcsLarrow* = ACS_PICK(',', '<')
  AcsRarrow* = ACS_PICK('+', '>')
  AcsDarrow* = ACS_PICK('.', 'v')
  AcsUarrow* = ACS_PICK('-', '^')
  AcsBoard* = ACS_PICK('h', '#')
  AcsLantern* = ACS_PICK('i', '*')
  AcsBlock* = ACS_PICK('0', '#')
  AcsS3* = ACS_PICK('p', '-')
  AcsS7* = ACS_PICK('r', '-')
  AcsLequal* = ACS_PICK('y', '<')
  AcsGequal* = ACS_PICK('z', '>')
  AcsPi* = ACS_PICK('{', 'n')
  AcsNequal* = ACS_PICK('|', '+')
  AcsSterling* = ACS_PICK('}', 'L')
  AcsBssb* = ACS_ULCORNER
  AcsSsbb* = ACS_LLCORNER
  AcsBbss* = ACS_URCORNER
  AcsSbbs* = ACS_LRCORNER
  AcsSbss* = ACS_RTEE
  AcsSssb* = ACS_LTEE
  AcsSsbs* = ACS_BTEE
  AcsBsss* = ACS_TTEE
  AcsBsbs* = ACS_HLINE
  AcsSbsb* = ACS_VLINE
  AcsSsss* = ACS_PLUS
discard """WACS_ULCORNER* = (addr((acs_map['l'])))
  WACS_LLCORNER* = (addr((acs_map['m'])))
  WACS_URCORNER* = (addr((acs_map['k'])))
  WACS_LRCORNER* = (addr((acs_map['j'])))
  WACS_RTEE* = (addr((acs_map['u'])))
  WACS_LTEE* = (addr((acs_map['t'])))
  WACS_BTEE* = (addr((acs_map['v'])))
  WACS_TTEE* = (addr((acs_map['w'])))
  WACS_HLINE* = (addr((acs_map['q'])))
  WACS_VLINE* = (addr((acs_map['x'])))
  WACS_PLUS* = (addr((acs_map['n'])))
  WACS_S1* = (addr((acs_map['o'])))
  WACS_S9* = (addr((acs_map['s'])))
  WACS_DIAMOND* = (addr((acs_map['`'])))
  WACS_CKBOARD* = (addr((acs_map['a'])))
  WACS_DEGREE* = (addr((acs_map['f'])))
  WACS_PLMINUS* = (addr((acs_map['g'])))
  WACS_BULLET* = (addr((acs_map['~'])))
  WACS_LARROW* = (addr((acs_map[','])))
  WACS_RARROW* = (addr((acs_map['+'])))
  WACS_DARROW* = (addr((acs_map['.'])))
  WACS_UARROW* = (addr((acs_map['-'])))
  WACS_BOARD* = (addr((acs_map['h'])))
  WACS_LANTERN* = (addr((acs_map['i'])))
  WACS_BLOCK* = (addr((acs_map['0'])))
  WACS_S3* = (addr((acs_map['p'])))
  WACS_S7* = (addr((acs_map['r'])))
  WACS_LEQUAL* = (addr((acs_map['y'])))
  WACS_GEQUAL* = (addr((acs_map['z'])))
  WACS_PI* = (addr((acs_map['{'])))
  WACS_NEQUAL* = (addr((acs_map['|'])))
  WACS_STERLING* = (addr((acs_map['}'])))
  WACS_BSSB* = WACS_ULCORNER
  WACS_SSBB* = WACS_LLCORNER
  WACS_BBSS* = WACS_URCORNER
  WACS_SBBS* = WACS_LRCORNER
  WACS_SBSS* = WACS_RTEE
  WACS_SSSB* = WACS_LTEE
  WACS_SSBS* = WACS_BTEE
  WACS_BSSS* = WACS_TTEE
  WACS_BSBS* = WACS_HLINE
  WACS_SBSB* = WACS_VLINE
  WACS_SSSS* = WACS_PLUS"""

proc addch*(a2: Cunsignedlong): Cint{.extdecl, importc: "addch", 
                                      dynlib: pdcursesdll.}
proc addchnstr*(a2: ptr Cunsignedlong; a3: Cint): Cint{.extdecl, 
    importc: "addchnstr", dynlib: pdcursesdll.}
proc addchstr*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "addchstr", 
    dynlib: pdcursesdll.}
proc addnstr*(a2: Cstring; a3: Cint): Cint{.extdecl, importc: "addnstr", 
    dynlib: pdcursesdll.}
proc addstr*(a2: Cstring): Cint{.extdecl, importc: "addstr", dynlib: pdcursesdll.}
proc attroff*(a2: Cunsignedlong): Cint{.extdecl, importc: "attroff", 
                                        dynlib: pdcursesdll.}
proc attron*(a2: Cunsignedlong): Cint{.extdecl, importc: "attron", 
                                       dynlib: pdcursesdll.}
proc attrset*(a2: Cunsignedlong): Cint{.extdecl, importc: "attrset", 
                                        dynlib: pdcursesdll.}
proc attrGet*(a2: ptr Cunsignedlong; a3: ptr Cshort; a4: Pointer): Cint{.extdecl, 
    importc: "attr_get", dynlib: pdcursesdll.}
proc attrOff*(a2: Cunsignedlong; a3: Pointer): Cint{.extdecl, 
    importc: "attr_off", dynlib: pdcursesdll.}
proc attrOn*(a2: Cunsignedlong; a3: Pointer): Cint{.extdecl, importc: "attr_on", 
    dynlib: pdcursesdll.}
proc attrSet*(a2: Cunsignedlong; a3: Cshort; a4: Pointer): Cint{.extdecl, 
    importc: "attr_set", dynlib: pdcursesdll.}
proc baudrate*(): Cint{.extdecl, importc: "baudrate", dynlib: pdcursesdll.}
proc beep*(): Cint{.extdecl, importc: "beep", dynlib: pdcursesdll.}
proc bkgd*(a2: Cunsignedlong): Cint{.extdecl, importc: "bkgd", dynlib: pdcursesdll.}
proc bkgdset*(a2: Cunsignedlong){.extdecl, importc: "bkgdset", dynlib: pdcursesdll.}
proc border*(a2: Cunsignedlong; a3: Cunsignedlong; a4: Cunsignedlong; 
             a5: Cunsignedlong; a6: Cunsignedlong; a7: Cunsignedlong; 
             a8: Cunsignedlong; a9: Cunsignedlong): Cint{.extdecl, 
    importc: "border", dynlib: pdcursesdll.}
proc box*(a2: ptr TWINDOW; a3: Cunsignedlong; a4: Cunsignedlong): Cint{.extdecl, 
    importc: "box", dynlib: pdcursesdll.}
proc canChangeColor*(): Cunsignedchar{.extdecl, importc: "can_change_color", 
    dynlib: pdcursesdll.}
proc cbreak*(): Cint{.extdecl, importc: "cbreak", dynlib: pdcursesdll.}
proc chgat*(a2: Cint; a3: Cunsignedlong; a4: Cshort; a5: Pointer): Cint{.extdecl, 
    importc: "chgat", dynlib: pdcursesdll.}
proc clearok*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, 
    importc: "clearok", dynlib: pdcursesdll.}
proc clear*(): Cint{.extdecl, importc: "clear", dynlib: pdcursesdll.}
proc clrtobot*(): Cint{.extdecl, importc: "clrtobot", dynlib: pdcursesdll.}
proc clrtoeol*(): Cint{.extdecl, importc: "clrtoeol", dynlib: pdcursesdll.}
proc colorContent*(a2: Cshort; a3: ptr Cshort; a4: ptr Cshort; a5: ptr Cshort): Cint{.
    extdecl, importc: "color_content", dynlib: pdcursesdll.}
proc colorSet*(a2: Cshort; a3: Pointer): Cint{.extdecl, importc: "color_set", 
    dynlib: pdcursesdll.}
proc copywin*(a2: ptr TWINDOW; a3: ptr TWINDOW; a4: Cint; a5: Cint; a6: Cint; 
              a7: Cint; a8: Cint; a9: Cint; a10: Cint): Cint{.extdecl, 
    importc: "copywin", dynlib: pdcursesdll.}
proc cursSet*(a2: Cint): Cint{.extdecl, importc: "curs_set", dynlib: pdcursesdll.}
proc defProgMode*(): Cint{.extdecl, importc: "def_prog_mode", 
                             dynlib: pdcursesdll.}
proc defShellMode*(): Cint{.extdecl, importc: "def_shell_mode", 
                              dynlib: pdcursesdll.}
proc delayOutput*(a2: Cint): Cint{.extdecl, importc: "delay_output", 
                                    dynlib: pdcursesdll.}
proc delch*(): Cint{.extdecl, importc: "delch", dynlib: pdcursesdll.}
proc deleteln*(): Cint{.extdecl, importc: "deleteln", dynlib: pdcursesdll.}
proc delscreen*(a2: ptr TSCREEN){.extdecl, importc: "delscreen", 
                                 dynlib: pdcursesdll.}
proc delwin*(a2: ptr TWINDOW): Cint{.extdecl, importc: "delwin", 
                                    dynlib: pdcursesdll.}
proc derwin*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cint; a6: Cint): ptr TWINDOW{.
    extdecl, importc: "derwin", dynlib: pdcursesdll.}
proc doupdate*(): Cint{.extdecl, importc: "doupdate", dynlib: pdcursesdll.}
proc dupwin*(a2: ptr TWINDOW): ptr TWINDOW{.extdecl, importc: "dupwin", 
    dynlib: pdcursesdll.}
proc echochar*(a2: Cunsignedlong): Cint{.extdecl, importc: "echochar", 
    dynlib: pdcursesdll.}
proc echo*(): Cint{.extdecl, importc: "echo", dynlib: pdcursesdll.}
proc endwin*(): Cint{.extdecl, importc: "endwin", dynlib: pdcursesdll.}
proc erasechar*(): Char{.extdecl, importc: "erasechar", dynlib: pdcursesdll.}
proc erase*(): Cint{.extdecl, importc: "erase", dynlib: pdcursesdll.}
proc filter*(){.extdecl, importc: "filter", dynlib: pdcursesdll.}
proc flash*(): Cint{.extdecl, importc: "flash", dynlib: pdcursesdll.}
proc flushinp*(): Cint{.extdecl, importc: "flushinp", dynlib: pdcursesdll.}
proc getbkgd*(a2: ptr TWINDOW): Cunsignedlong{.extdecl, importc: "getbkgd", 
    dynlib: pdcursesdll.}
proc getnstr*(a2: Cstring; a3: Cint): Cint{.extdecl, importc: "getnstr", 
    dynlib: pdcursesdll.}
proc getstr*(a2: Cstring): Cint{.extdecl, importc: "getstr", dynlib: pdcursesdll.}
proc getwin*(a2: TFile): ptr TWINDOW{.extdecl, importc: "getwin", 
                                        dynlib: pdcursesdll.}
proc halfdelay*(a2: Cint): Cint{.extdecl, importc: "halfdelay", 
                                 dynlib: pdcursesdll.}
proc hasColors*(): Cunsignedchar{.extdecl, importc: "has_colors", 
                                   dynlib: pdcursesdll.}
proc hasIc*(): Cunsignedchar{.extdecl, importc: "has_ic", dynlib: pdcursesdll.}
proc hasIl*(): Cunsignedchar{.extdecl, importc: "has_il", dynlib: pdcursesdll.}
proc hline*(a2: Cunsignedlong; a3: Cint): Cint{.extdecl, importc: "hline", 
    dynlib: pdcursesdll.}
proc idcok*(a2: ptr TWINDOW; a3: Cunsignedchar){.extdecl, importc: "idcok", 
    dynlib: pdcursesdll.}
proc idlok*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, importc: "idlok", 
    dynlib: pdcursesdll.}
proc immedok*(a2: ptr TWINDOW; a3: Cunsignedchar){.extdecl, importc: "immedok", 
    dynlib: pdcursesdll.}
proc inchnstr*(a2: ptr Cunsignedlong; a3: Cint): Cint{.extdecl, 
    importc: "inchnstr", dynlib: pdcursesdll.}
proc inchstr*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "inchstr", 
    dynlib: pdcursesdll.}
proc inch*(): Cunsignedlong{.extdecl, importc: "inch", dynlib: pdcursesdll.}
proc initColor*(a2: Cshort; a3: Cshort; a4: Cshort; a5: Cshort): Cint{.extdecl, 
    importc: "init_color", dynlib: pdcursesdll.}
proc initPair*(a2: Cshort; a3: Cshort; a4: Cshort): Cint{.extdecl, 
    importc: "init_pair", dynlib: pdcursesdll.}
proc initscr*(): ptr TWINDOW{.extdecl, importc: "initscr", dynlib: pdcursesdll.}
proc innstr*(a2: Cstring; a3: Cint): Cint{.extdecl, importc: "innstr", 
    dynlib: pdcursesdll.}
proc insch*(a2: Cunsignedlong): Cint{.extdecl, importc: "insch", 
                                      dynlib: pdcursesdll.}
proc insdelln*(a2: Cint): Cint{.extdecl, importc: "insdelln", dynlib: pdcursesdll.}
proc insertln*(): Cint{.extdecl, importc: "insertln", dynlib: pdcursesdll.}
proc insnstr*(a2: Cstring; a3: Cint): Cint{.extdecl, importc: "insnstr", 
    dynlib: pdcursesdll.}
proc insstr*(a2: Cstring): Cint{.extdecl, importc: "insstr", dynlib: pdcursesdll.}
proc instr*(a2: Cstring): Cint{.extdecl, importc: "instr", dynlib: pdcursesdll.}
proc intrflush*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, 
    importc: "intrflush", dynlib: pdcursesdll.}
proc isendwin*(): Cunsignedchar{.extdecl, importc: "isendwin", dynlib: pdcursesdll.}
proc isLinetouched*(a2: ptr TWINDOW; a3: Cint): Cunsignedchar{.extdecl, 
    importc: "is_linetouched", dynlib: pdcursesdll.}
proc isWintouched*(a2: ptr TWINDOW): Cunsignedchar{.extdecl, 
    importc: "is_wintouched", dynlib: pdcursesdll.}
proc keyname*(a2: Cint): Cstring{.extdecl, importc: "keyname", dynlib: pdcursesdll.}
proc keypad*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, importc: "keypad", 
    dynlib: pdcursesdll.}
proc killchar*(): Char{.extdecl, importc: "killchar", dynlib: pdcursesdll.}
proc leaveok*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, 
    importc: "leaveok", dynlib: pdcursesdll.}
proc longname*(): Cstring{.extdecl, importc: "longname", dynlib: pdcursesdll.}
proc meta*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, importc: "meta", 
    dynlib: pdcursesdll.}
proc move*(a2: Cint; a3: Cint): Cint{.extdecl, importc: "move", 
                                      dynlib: pdcursesdll.}
proc mvaddch*(a2: Cint; a3: Cint; a4: Cunsignedlong): Cint{.extdecl, 
    importc: "mvaddch", dynlib: pdcursesdll.}
proc mvaddchnstr*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong; a5: Cint): Cint{.
    extdecl, importc: "mvaddchnstr", dynlib: pdcursesdll.}
proc mvaddchstr*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "mvaddchstr", dynlib: pdcursesdll.}
proc mvaddnstr*(a2: Cint; a3: Cint; a4: Cstring; a5: Cint): Cint{.extdecl, 
    importc: "mvaddnstr", dynlib: pdcursesdll.}
proc mvaddstr*(a2: Cint; a3: Cint; a4: Cstring): Cint{.extdecl, 
    importc: "mvaddstr", dynlib: pdcursesdll.}
proc mvchgat*(a2: Cint; a3: Cint; a4: Cint; a5: Cunsignedlong; a6: Cshort; 
              a7: Pointer): Cint{.extdecl, importc: "mvchgat", dynlib: pdcursesdll.}
proc mvcur*(a2: Cint; a3: Cint; a4: Cint; a5: Cint): Cint{.extdecl, 
    importc: "mvcur", dynlib: pdcursesdll.}
proc mvdelch*(a2: Cint; a3: Cint): Cint{.extdecl, importc: "mvdelch", 
    dynlib: pdcursesdll.}
proc mvderwin*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "mvderwin", dynlib: pdcursesdll.}
proc mvgetch*(a2: Cint; a3: Cint): Cint{.extdecl, importc: "mvgetch", 
    dynlib: pdcursesdll.}
proc mvgetnstr*(a2: Cint; a3: Cint; a4: Cstring; a5: Cint): Cint{.extdecl, 
    importc: "mvgetnstr", dynlib: pdcursesdll.}
proc mvgetstr*(a2: Cint; a3: Cint; a4: Cstring): Cint{.extdecl, 
    importc: "mvgetstr", dynlib: pdcursesdll.}
proc mvhline*(a2: Cint; a3: Cint; a4: Cunsignedlong; a5: Cint): Cint{.extdecl, 
    importc: "mvhline", dynlib: pdcursesdll.}
proc mvinch*(a2: Cint; a3: Cint): Cunsignedlong{.extdecl, importc: "mvinch", 
    dynlib: pdcursesdll.}
proc mvinchnstr*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong; a5: Cint): Cint{.
    extdecl, importc: "mvinchnstr", dynlib: pdcursesdll.}
proc mvinchstr*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "mvinchstr", dynlib: pdcursesdll.}
proc mvinnstr*(a2: Cint; a3: Cint; a4: Cstring; a5: Cint): Cint{.extdecl, 
    importc: "mvinnstr", dynlib: pdcursesdll.}
proc mvinsch*(a2: Cint; a3: Cint; a4: Cunsignedlong): Cint{.extdecl, 
    importc: "mvinsch", dynlib: pdcursesdll.}
proc mvinsnstr*(a2: Cint; a3: Cint; a4: Cstring; a5: Cint): Cint{.extdecl, 
    importc: "mvinsnstr", dynlib: pdcursesdll.}
proc mvinsstr*(a2: Cint; a3: Cint; a4: Cstring): Cint{.extdecl, 
    importc: "mvinsstr", dynlib: pdcursesdll.}
proc mvinstr*(a2: Cint; a3: Cint; a4: Cstring): Cint{.extdecl, importc: "mvinstr", 
    dynlib: pdcursesdll.}
proc mvprintw*(a2: Cint; a3: Cint; a4: Cstring): Cint{.varargs, extdecl, 
    importc: "mvprintw", dynlib: pdcursesdll.}
proc mvscanw*(a2: Cint; a3: Cint; a4: Cstring): Cint{.varargs, extdecl, 
    importc: "mvscanw", dynlib: pdcursesdll.}
proc mvvline*(a2: Cint; a3: Cint; a4: Cunsignedlong; a5: Cint): Cint{.extdecl, 
    importc: "mvvline", dynlib: pdcursesdll.}
proc mvwaddchnstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong; 
                   a6: Cint): Cint{.extdecl, importc: "mvwaddchnstr", 
                                    dynlib: pdcursesdll.}
proc mvwaddchstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong): Cint{.
    extdecl, importc: "mvwaddchstr", dynlib: pdcursesdll.}
proc mvwaddch*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cunsignedlong): Cint{.
    extdecl, importc: "mvwaddch", dynlib: pdcursesdll.}
proc mvwaddnstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring; a6: Cint): Cint{.
    extdecl, importc: "mvwaddnstr", dynlib: pdcursesdll.}
proc mvwaddstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.extdecl, 
    importc: "mvwaddstr", dynlib: pdcursesdll.}
proc mvwchgat*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cint; a6: Cunsignedlong; 
               a7: Cshort; a8: Pointer): Cint{.extdecl, importc: "mvwchgat", 
    dynlib: pdcursesdll.}
proc mvwdelch*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "mvwdelch", dynlib: pdcursesdll.}
proc mvwgetch*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "mvwgetch", dynlib: pdcursesdll.}
proc mvwgetnstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring; a6: Cint): Cint{.
    extdecl, importc: "mvwgetnstr", dynlib: pdcursesdll.}
proc mvwgetstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.extdecl, 
    importc: "mvwgetstr", dynlib: pdcursesdll.}
proc mvwhline*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cunsignedlong; a6: Cint): Cint{.
    extdecl, importc: "mvwhline", dynlib: pdcursesdll.}
proc mvwinchnstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong; 
                  a6: Cint): Cint{.extdecl, importc: "mvwinchnstr", 
                                   dynlib: pdcursesdll.}
proc mvwinchstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong): Cint{.
    extdecl, importc: "mvwinchstr", dynlib: pdcursesdll.}
proc mvwinch*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cunsignedlong{.extdecl, 
    importc: "mvwinch", dynlib: pdcursesdll.}
proc mvwinnstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring; a6: Cint): Cint{.
    extdecl, importc: "mvwinnstr", dynlib: pdcursesdll.}
proc mvwinsch*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cunsignedlong): Cint{.
    extdecl, importc: "mvwinsch", dynlib: pdcursesdll.}
proc mvwinsnstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring; a6: Cint): Cint{.
    extdecl, importc: "mvwinsnstr", dynlib: pdcursesdll.}
proc mvwinsstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.extdecl, 
    importc: "mvwinsstr", dynlib: pdcursesdll.}
proc mvwinstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.extdecl, 
    importc: "mvwinstr", dynlib: pdcursesdll.}
proc mvwin*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, importc: "mvwin", 
    dynlib: pdcursesdll.}
proc mvwprintw*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.varargs, 
    extdecl, importc: "mvwprintw", dynlib: pdcursesdll.}
proc mvwscanw*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.varargs, 
    extdecl, importc: "mvwscanw", dynlib: pdcursesdll.}
proc mvwvline*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cunsignedlong; a6: Cint): Cint{.
    extdecl, importc: "mvwvline", dynlib: pdcursesdll.}
proc napms*(a2: Cint): Cint{.extdecl, importc: "napms", dynlib: pdcursesdll.}
proc newpad*(a2: Cint; a3: Cint): ptr TWINDOW{.extdecl, importc: "newpad", 
    dynlib: pdcursesdll.}
proc newterm*(a2: Cstring; a3: TFile; a4: TFile): ptr TSCREEN{.extdecl, 
    importc: "newterm", dynlib: pdcursesdll.}
proc newwin*(a2: Cint; a3: Cint; a4: Cint; a5: Cint): ptr TWINDOW{.extdecl, 
    importc: "newwin", dynlib: pdcursesdll.}
proc nl*(): Cint{.extdecl, importc: "nl", dynlib: pdcursesdll.}
proc nocbreak*(): Cint{.extdecl, importc: "nocbreak", dynlib: pdcursesdll.}
proc nodelay*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, 
    importc: "nodelay", dynlib: pdcursesdll.}
proc noecho*(): Cint{.extdecl, importc: "noecho", dynlib: pdcursesdll.}
proc nonl*(): Cint{.extdecl, importc: "nonl", dynlib: pdcursesdll.}
proc noqiflush*(){.extdecl, importc: "noqiflush", dynlib: pdcursesdll.}
proc noraw*(): Cint{.extdecl, importc: "noraw", dynlib: pdcursesdll.}
proc notimeout*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, 
    importc: "notimeout", dynlib: pdcursesdll.}
proc overlay*(a2: ptr TWINDOW; a3: ptr TWINDOW): Cint{.extdecl, importc: "overlay", 
    dynlib: pdcursesdll.}
proc overwrite*(a2: ptr TWINDOW; a3: ptr TWINDOW): Cint{.extdecl, 
    importc: "overwrite", dynlib: pdcursesdll.}
proc pairContent*(a2: Cshort; a3: ptr Cshort; a4: ptr Cshort): Cint{.extdecl, 
    importc: "pair_content", dynlib: pdcursesdll.}
proc pechochar*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, 
    importc: "pechochar", dynlib: pdcursesdll.}
proc pnoutrefresh*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cint; a6: Cint; 
                   a7: Cint; a8: Cint): Cint{.extdecl, importc: "pnoutrefresh", 
    dynlib: pdcursesdll.}
proc prefresh*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cint; a6: Cint; a7: Cint; 
               a8: Cint): Cint{.extdecl, importc: "prefresh", dynlib: pdcursesdll.}
proc printw*(a2: Cstring): Cint{.varargs, extdecl, importc: "printw", 
                                 dynlib: pdcursesdll.}
proc putwin*(a2: ptr TWINDOW; a3: TFile): Cint{.extdecl, importc: "putwin", 
    dynlib: pdcursesdll.}
proc qiflush*(){.extdecl, importc: "qiflush", dynlib: pdcursesdll.}
proc raw*(): Cint{.extdecl, importc: "raw", dynlib: pdcursesdll.}
proc redrawwin*(a2: ptr TWINDOW): Cint{.extdecl, importc: "redrawwin", 
                                       dynlib: pdcursesdll.}
proc refresh*(): Cint{.extdecl, importc: "refresh", dynlib: pdcursesdll.}
proc resetProgMode*(): Cint{.extdecl, importc: "reset_prog_mode", 
                               dynlib: pdcursesdll.}
proc resetShellMode*(): Cint{.extdecl, importc: "reset_shell_mode", 
                                dynlib: pdcursesdll.}
proc resetty*(): Cint{.extdecl, importc: "resetty", dynlib: pdcursesdll.}
#int     ripoffline(int, int (*)(TWINDOW *, int));
proc savetty*(): Cint{.extdecl, importc: "savetty", dynlib: pdcursesdll.}
proc scanw*(a2: Cstring): Cint{.varargs, extdecl, importc: "scanw", 
                                dynlib: pdcursesdll.}
proc scrDump*(a2: Cstring): Cint{.extdecl, importc: "scr_dump", 
                                   dynlib: pdcursesdll.}
proc scrInit*(a2: Cstring): Cint{.extdecl, importc: "scr_init", 
                                   dynlib: pdcursesdll.}
proc scrRestore*(a2: Cstring): Cint{.extdecl, importc: "scr_restore", 
                                      dynlib: pdcursesdll.}
proc scrSet*(a2: Cstring): Cint{.extdecl, importc: "scr_set", dynlib: pdcursesdll.}
proc scrl*(a2: Cint): Cint{.extdecl, importc: "scrl", dynlib: pdcursesdll.}
proc scroll*(a2: ptr TWINDOW): Cint{.extdecl, importc: "scroll", 
                                    dynlib: pdcursesdll.}
proc scrollok*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, 
    importc: "scrollok", dynlib: pdcursesdll.}
proc setTerm*(a2: ptr TSCREEN): ptr TSCREEN{.extdecl, importc: "set_term", 
    dynlib: pdcursesdll.}
proc setscrreg*(a2: Cint; a3: Cint): Cint{.extdecl, importc: "setscrreg", 
    dynlib: pdcursesdll.}
proc slkAttroff*(a2: Cunsignedlong): Cint{.extdecl, importc: "slk_attroff", 
    dynlib: pdcursesdll.}
proc slkAttrOff*(a2: Cunsignedlong; a3: Pointer): Cint{.extdecl, 
    importc: "slk_attr_off", dynlib: pdcursesdll.}
proc slkAttron*(a2: Cunsignedlong): Cint{.extdecl, importc: "slk_attron", 
    dynlib: pdcursesdll.}
proc slkAttrOn*(a2: Cunsignedlong; a3: Pointer): Cint{.extdecl, 
    importc: "slk_attr_on", dynlib: pdcursesdll.}
proc slkAttrset*(a2: Cunsignedlong): Cint{.extdecl, importc: "slk_attrset", 
    dynlib: pdcursesdll.}
proc slkAttrSet*(a2: Cunsignedlong; a3: Cshort; a4: Pointer): Cint{.extdecl, 
    importc: "slk_attr_set", dynlib: pdcursesdll.}
proc slkClear*(): Cint{.extdecl, importc: "slk_clear", dynlib: pdcursesdll.}
proc slkColor*(a2: Cshort): Cint{.extdecl, importc: "slk_color", 
                                   dynlib: pdcursesdll.}
proc slkInit*(a2: Cint): Cint{.extdecl, importc: "slk_init", dynlib: pdcursesdll.}
proc slkLabel*(a2: Cint): Cstring{.extdecl, importc: "slk_label", 
                                    dynlib: pdcursesdll.}
proc slkNoutrefresh*(): Cint{.extdecl, importc: "slk_noutrefresh", 
                               dynlib: pdcursesdll.}
proc slkRefresh*(): Cint{.extdecl, importc: "slk_refresh", dynlib: pdcursesdll.}
proc slkRestore*(): Cint{.extdecl, importc: "slk_restore", dynlib: pdcursesdll.}
proc slkSet*(a2: Cint; a3: Cstring; a4: Cint): Cint{.extdecl, importc: "slk_set", 
    dynlib: pdcursesdll.}
proc slkTouch*(): Cint{.extdecl, importc: "slk_touch", dynlib: pdcursesdll.}
proc standend*(): Cint{.extdecl, importc: "standend", dynlib: pdcursesdll.}
proc standout*(): Cint{.extdecl, importc: "standout", dynlib: pdcursesdll.}
proc startColor*(): Cint{.extdecl, importc: "start_color", dynlib: pdcursesdll.}
proc subpad*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cint; a6: Cint): ptr TWINDOW{.
    extdecl, importc: "subpad", dynlib: pdcursesdll.}
proc subwin*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cint; a6: Cint): ptr TWINDOW{.
    extdecl, importc: "subwin", dynlib: pdcursesdll.}
proc syncok*(a2: ptr TWINDOW; a3: Cunsignedchar): Cint{.extdecl, importc: "syncok", 
    dynlib: pdcursesdll.}
proc termattrs*(): Cunsignedlong{.extdecl, importc: "termattrs", 
                                  dynlib: pdcursesdll.}
proc termattrs2*(): Cunsignedlong{.extdecl, importc: "term_attrs", 
                                   dynlib: pdcursesdll.}
proc termname*(): Cstring{.extdecl, importc: "termname", dynlib: pdcursesdll.}
proc timeout*(a2: Cint){.extdecl, importc: "timeout", dynlib: pdcursesdll.}
proc touchline*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "touchline", dynlib: pdcursesdll.}
proc touchwin*(a2: ptr TWINDOW): Cint{.extdecl, importc: "touchwin", 
                                      dynlib: pdcursesdll.}
proc typeahead*(a2: Cint): Cint{.extdecl, importc: "typeahead", 
                                 dynlib: pdcursesdll.}
proc untouchwin*(a2: ptr TWINDOW): Cint{.extdecl, importc: "untouchwin", 
                                        dynlib: pdcursesdll.}
proc useEnv*(a2: Cunsignedchar){.extdecl, importc: "use_env", dynlib: pdcursesdll.}
proc vidattr*(a2: Cunsignedlong): Cint{.extdecl, importc: "vidattr", 
                                        dynlib: pdcursesdll.}
proc vidAttr*(a2: Cunsignedlong; a3: Cshort; a4: Pointer): Cint{.extdecl, 
    importc: "vid_attr", dynlib: pdcursesdll.}
#int     vidputs(chtype, int (*)(int));
#int     vid_puts(attr_t, short, void *, int (*)(int));
proc vline*(a2: Cunsignedlong; a3: Cint): Cint{.extdecl, importc: "vline", 
    dynlib: pdcursesdll.}
proc vwprintw*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, varargs,
    importc: "vw_printw", dynlib: pdcursesdll.}
proc vwprintw2*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, varargs,
    importc: "vwprintw", dynlib: pdcursesdll.}
proc vwscanw*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, varargs,
    importc: "vw_scanw", dynlib: pdcursesdll.}
proc vwscanw2*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, varargs,
    importc: "vwscanw", dynlib: pdcursesdll.}
proc waddchnstr*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: Cint): Cint{.extdecl, 
    importc: "waddchnstr", dynlib: pdcursesdll.}
proc waddchstr*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "waddchstr", dynlib: pdcursesdll.}
proc waddch*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, importc: "waddch", 
    dynlib: pdcursesdll.}
proc waddnstr*(a2: ptr TWINDOW; a3: Cstring; a4: Cint): Cint{.extdecl, 
    importc: "waddnstr", dynlib: pdcursesdll.}
proc waddstr*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, importc: "waddstr", 
    dynlib: pdcursesdll.}
proc wattroff*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, 
    importc: "wattroff", dynlib: pdcursesdll.}
proc wattron*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, 
    importc: "wattron", dynlib: pdcursesdll.}
proc wattrset*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, 
    importc: "wattrset", dynlib: pdcursesdll.}
proc wattrGet*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: ptr Cshort; 
                a5: Pointer): Cint{.extdecl, importc: "wattr_get", 
                                    dynlib: pdcursesdll.}
proc wattrOff*(a2: ptr TWINDOW; a3: Cunsignedlong; a4: Pointer): Cint{.extdecl, 
    importc: "wattr_off", dynlib: pdcursesdll.}
proc wattrOn*(a2: ptr TWINDOW; a3: Cunsignedlong; a4: Pointer): Cint{.extdecl, 
    importc: "wattr_on", dynlib: pdcursesdll.}
proc wattrSet*(a2: ptr TWINDOW; a3: Cunsignedlong; a4: Cshort; a5: Pointer): Cint{.
    extdecl, importc: "wattr_set", dynlib: pdcursesdll.}
proc wbkgdset*(a2: ptr TWINDOW; a3: Cunsignedlong){.extdecl, importc: "wbkgdset", 
    dynlib: pdcursesdll.}
proc wbkgd*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, importc: "wbkgd", 
    dynlib: pdcursesdll.}
proc wborder*(a2: ptr TWINDOW; a3: Cunsignedlong; a4: Cunsignedlong; 
              a5: Cunsignedlong; a6: Cunsignedlong; a7: Cunsignedlong; 
              a8: Cunsignedlong; a9: Cunsignedlong; a10: Cunsignedlong): Cint{.
    extdecl, importc: "wborder", dynlib: pdcursesdll.}
proc wchgat*(a2: ptr TWINDOW; a3: Cint; a4: Cunsignedlong; a5: Cshort; 
             a6: Pointer): Cint{.extdecl, importc: "wchgat", dynlib: pdcursesdll.}
proc wclear*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wclear", 
                                    dynlib: pdcursesdll.}
proc wclrtobot*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wclrtobot", 
                                       dynlib: pdcursesdll.}
proc wclrtoeol*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wclrtoeol", 
                                       dynlib: pdcursesdll.}
proc wcolorSet*(a2: ptr TWINDOW; a3: Cshort; a4: Pointer): Cint{.extdecl, 
    importc: "wcolor_set", dynlib: pdcursesdll.}
proc wcursyncup*(a2: ptr TWINDOW){.extdecl, importc: "wcursyncup", 
                                  dynlib: pdcursesdll.}
proc wdelch*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wdelch", 
                                    dynlib: pdcursesdll.}
proc wdeleteln*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wdeleteln", 
                                       dynlib: pdcursesdll.}
proc wechochar*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, 
    importc: "wechochar", dynlib: pdcursesdll.}
proc werase*(a2: ptr TWINDOW): Cint{.extdecl, importc: "werase", 
                                    dynlib: pdcursesdll.}
proc wgetch*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wgetch", 
                                    dynlib: pdcursesdll.}
proc wgetnstr*(a2: ptr TWINDOW; a3: Cstring; a4: Cint): Cint{.extdecl, 
    importc: "wgetnstr", dynlib: pdcursesdll.}
proc wgetstr*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, importc: "wgetstr", 
    dynlib: pdcursesdll.}
proc whline*(a2: ptr TWINDOW; a3: Cunsignedlong; a4: Cint): Cint{.extdecl, 
    importc: "whline", dynlib: pdcursesdll.}
proc winchnstr*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: Cint): Cint{.extdecl, 
    importc: "winchnstr", dynlib: pdcursesdll.}
proc winchstr*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "winchstr", dynlib: pdcursesdll.}
proc winch*(a2: ptr TWINDOW): Cunsignedlong{.extdecl, importc: "winch", 
    dynlib: pdcursesdll.}
proc winnstr*(a2: ptr TWINDOW; a3: Cstring; a4: Cint): Cint{.extdecl, 
    importc: "winnstr", dynlib: pdcursesdll.}
proc winsch*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, importc: "winsch", 
    dynlib: pdcursesdll.}
proc winsdelln*(a2: ptr TWINDOW; a3: Cint): Cint{.extdecl, importc: "winsdelln", 
    dynlib: pdcursesdll.}
proc winsertln*(a2: ptr TWINDOW): Cint{.extdecl, importc: "winsertln", 
                                       dynlib: pdcursesdll.}
proc winsnstr*(a2: ptr TWINDOW; a3: Cstring; a4: Cint): Cint{.extdecl, 
    importc: "winsnstr", dynlib: pdcursesdll.}
proc winsstr*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, importc: "winsstr", 
    dynlib: pdcursesdll.}
proc winstr*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, importc: "winstr", 
    dynlib: pdcursesdll.}
proc wmove*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, importc: "wmove", 
    dynlib: pdcursesdll.}
proc wnoutrefresh*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wnoutrefresh", 
    dynlib: pdcursesdll.}
proc wprintw*(a2: ptr TWINDOW; a3: Cstring): Cint{.varargs, extdecl, 
    importc: "wprintw", dynlib: pdcursesdll.}
proc wredrawln*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "wredrawln", dynlib: pdcursesdll.}
proc wrefresh*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wrefresh", 
                                      dynlib: pdcursesdll.}
proc wscanw*(a2: ptr TWINDOW; a3: Cstring): Cint{.varargs, extdecl, 
    importc: "wscanw", dynlib: pdcursesdll.}
proc wscrl*(a2: ptr TWINDOW; a3: Cint): Cint{.extdecl, importc: "wscrl", 
    dynlib: pdcursesdll.}
proc wsetscrreg*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "wsetscrreg", dynlib: pdcursesdll.}
proc wstandend*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wstandend", 
                                       dynlib: pdcursesdll.}
proc wstandout*(a2: ptr TWINDOW): Cint{.extdecl, importc: "wstandout", 
                                       dynlib: pdcursesdll.}
proc wsyncdown*(a2: ptr TWINDOW){.extdecl, importc: "wsyncdown", 
                                 dynlib: pdcursesdll.}
proc wsyncup*(a2: ptr TWINDOW){.extdecl, importc: "wsyncup", dynlib: pdcursesdll.}
proc wtimeout*(a2: ptr TWINDOW; a3: Cint){.extdecl, importc: "wtimeout", 
    dynlib: pdcursesdll.}
proc wtouchln*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cint): Cint{.extdecl, 
    importc: "wtouchln", dynlib: pdcursesdll.}
proc wvline*(a2: ptr TWINDOW; a3: Cunsignedlong; a4: Cint): Cint{.extdecl, 
    importc: "wvline", dynlib: pdcursesdll.}
proc addnwstr*(a2: Cstring; a3: Cint): Cint{.extdecl, importc: "addnwstr", 
    dynlib: pdcursesdll.}
proc addwstr*(a2: Cstring): Cint{.extdecl, importc: "addwstr", 
                                      dynlib: pdcursesdll.}
proc addWch*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "add_wch", 
    dynlib: pdcursesdll.}
proc addWchnstr*(a2: ptr Cunsignedlong; a3: Cint): Cint{.extdecl, 
    importc: "add_wchnstr", dynlib: pdcursesdll.}
proc addWchstr*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "add_wchstr", 
    dynlib: pdcursesdll.}
proc borderSet*(a2: ptr Cunsignedlong; a3: ptr Cunsignedlong; 
                 a4: ptr Cunsignedlong; a5: ptr Cunsignedlong; 
                 a6: ptr Cunsignedlong; a7: ptr Cunsignedlong; 
                 a8: ptr Cunsignedlong; a9: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "border_set", dynlib: pdcursesdll.}
proc boxSet*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: ptr Cunsignedlong): Cint{.
    extdecl, importc: "box_set", dynlib: pdcursesdll.}
proc echoWchar*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "echo_wchar", 
    dynlib: pdcursesdll.}
proc erasewchar*(a2: Cstring): Cint{.extdecl, importc: "erasewchar", 
    dynlib: pdcursesdll.}
proc getbkgrnd*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "getbkgrnd", 
    dynlib: pdcursesdll.}
proc getcchar*(a2: ptr Cunsignedlong; a3: Cstring; a4: ptr Cunsignedlong; 
               a5: ptr Cshort; a6: Pointer): Cint{.extdecl, importc: "getcchar", 
    dynlib: pdcursesdll.}
proc getnWstr*(a2: ptr Cint; a3: Cint): Cint{.extdecl, importc: "getn_wstr", 
    dynlib: pdcursesdll.}
proc getWch*(a2: ptr Cint): Cint{.extdecl, importc: "get_wch", 
                                     dynlib: pdcursesdll.}
proc getWstr*(a2: ptr Cint): Cint{.extdecl, importc: "get_wstr", 
                                      dynlib: pdcursesdll.}
proc hlineSet*(a2: ptr Cunsignedlong; a3: Cint): Cint{.extdecl, 
    importc: "hline_set", dynlib: pdcursesdll.}
proc innwstr*(a2: Cstring; a3: Cint): Cint{.extdecl, importc: "innwstr", 
    dynlib: pdcursesdll.}
proc insNwstr*(a2: Cstring; a3: Cint): Cint{.extdecl, importc: "ins_nwstr", 
    dynlib: pdcursesdll.}
proc insWch*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "ins_wch", 
    dynlib: pdcursesdll.}
proc insWstr*(a2: Cstring): Cint{.extdecl, importc: "ins_wstr", 
                                       dynlib: pdcursesdll.}
proc inwstr*(a2: Cstring): Cint{.extdecl, importc: "inwstr", 
                                     dynlib: pdcursesdll.}
proc inWch*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "in_wch", 
    dynlib: pdcursesdll.}
proc inWchnstr*(a2: ptr Cunsignedlong; a3: Cint): Cint{.extdecl, 
    importc: "in_wchnstr", dynlib: pdcursesdll.}
proc inWchstr*(a2: ptr Cunsignedlong): Cint{.extdecl, importc: "in_wchstr", 
    dynlib: pdcursesdll.}
proc keyName*(a2: Char): Cstring{.extdecl, importc: "key_name", 
                                      dynlib: pdcursesdll.}
proc killwchar*(a2: Cstring): Cint{.extdecl, importc: "killwchar", 
                                        dynlib: pdcursesdll.}
proc mvaddnwstr*(a2: Cint; a3: Cint; a4: Cstring; a5: Cint): Cint{.extdecl, 
    importc: "mvaddnwstr", dynlib: pdcursesdll.}
proc mvaddwstr*(a2: Cint; a3: Cint; a4: Cstring): Cint{.extdecl, 
    importc: "mvaddwstr", dynlib: pdcursesdll.}
proc mvaddWch*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "mvadd_wch", dynlib: pdcursesdll.}
proc mvaddWchnstr*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong; a5: Cint): Cint{.
    extdecl, importc: "mvadd_wchnstr", dynlib: pdcursesdll.}
proc mvaddWchstr*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "mvadd_wchstr", dynlib: pdcursesdll.}
proc mvgetnWstr*(a2: Cint; a3: Cint; a4: ptr Cint; a5: Cint): Cint{.extdecl, 
    importc: "mvgetn_wstr", dynlib: pdcursesdll.}
proc mvgetWch*(a2: Cint; a3: Cint; a4: ptr Cint): Cint{.extdecl, 
    importc: "mvget_wch", dynlib: pdcursesdll.}
proc mvgetWstr*(a2: Cint; a3: Cint; a4: ptr Cint): Cint{.extdecl, 
    importc: "mvget_wstr", dynlib: pdcursesdll.}
proc mvhlineSet*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong; a5: Cint): Cint{.
    extdecl, importc: "mvhline_set", dynlib: pdcursesdll.}
proc mvinnwstr*(a2: Cint; a3: Cint; a4: Cstring; a5: Cint): Cint{.extdecl, 
    importc: "mvinnwstr", dynlib: pdcursesdll.}
proc mvinsNwstr*(a2: Cint; a3: Cint; a4: Cstring; a5: Cint): Cint{.extdecl, 
    importc: "mvins_nwstr", dynlib: pdcursesdll.}
proc mvinsWch*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "mvins_wch", dynlib: pdcursesdll.}
proc mvinsWstr*(a2: Cint; a3: Cint; a4: Cstring): Cint{.extdecl, 
    importc: "mvins_wstr", dynlib: pdcursesdll.}
proc mvinwstr*(a2: Cint; a3: Cint; a4: Cstring): Cint{.extdecl, 
    importc: "mvinwstr", dynlib: pdcursesdll.}
proc mvinWch*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "mvin_wch", dynlib: pdcursesdll.}
proc mvinWchnstr*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong; a5: Cint): Cint{.
    extdecl, importc: "mvin_wchnstr", dynlib: pdcursesdll.}
proc mvinWchstr*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "mvin_wchstr", dynlib: pdcursesdll.}
proc mvvlineSet*(a2: Cint; a3: Cint; a4: ptr Cunsignedlong; a5: Cint): Cint{.
    extdecl, importc: "mvvline_set", dynlib: pdcursesdll.}
proc mvwaddnwstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring; a6: Cint): Cint{.
    extdecl, importc: "mvwaddnwstr", dynlib: pdcursesdll.}
proc mvwaddwstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.
    extdecl, importc: "mvwaddwstr", dynlib: pdcursesdll.}
proc mvwaddWch*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong): Cint{.
    extdecl, importc: "mvwadd_wch", dynlib: pdcursesdll.}
proc mvwaddWchnstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong; 
                     a6: Cint): Cint{.extdecl, importc: "mvwadd_wchnstr", 
                                      dynlib: pdcursesdll.}
proc mvwaddWchstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong): Cint{.
    extdecl, importc: "mvwadd_wchstr", dynlib: pdcursesdll.}
proc mvwgetnWstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cint; a6: Cint): Cint{.
    extdecl, importc: "mvwgetn_wstr", dynlib: pdcursesdll.}
proc mvwgetWch*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cint): Cint{.
    extdecl, importc: "mvwget_wch", dynlib: pdcursesdll.}
proc mvwgetWstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cint): Cint{.
    extdecl, importc: "mvwget_wstr", dynlib: pdcursesdll.}
proc mvwhlineSet*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong; 
                   a6: Cint): Cint{.extdecl, importc: "mvwhline_set", 
                                    dynlib: pdcursesdll.}
proc mvwinnwstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring; a6: Cint): Cint{.
    extdecl, importc: "mvwinnwstr", dynlib: pdcursesdll.}
proc mvwinsNwstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring; a6: Cint): Cint{.
    extdecl, importc: "mvwins_nwstr", dynlib: pdcursesdll.}
proc mvwinsWch*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong): Cint{.
    extdecl, importc: "mvwins_wch", dynlib: pdcursesdll.}
proc mvwinsWstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.
    extdecl, importc: "mvwins_wstr", dynlib: pdcursesdll.}
proc mvwinWch*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong): Cint{.
    extdecl, importc: "mvwin_wch", dynlib: pdcursesdll.}
proc mvwinWchnstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong; 
                    a6: Cint): Cint{.extdecl, importc: "mvwin_wchnstr", 
                                     dynlib: pdcursesdll.}
proc mvwinWchstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong): Cint{.
    extdecl, importc: "mvwin_wchstr", dynlib: pdcursesdll.}
proc mvwinwstr*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cstring): Cint{.
    extdecl, importc: "mvwinwstr", dynlib: pdcursesdll.}
proc mvwvlineSet*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: ptr Cunsignedlong; 
                   a6: Cint): Cint{.extdecl, importc: "mvwvline_set", 
                                    dynlib: pdcursesdll.}
proc pechoWchar*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "pecho_wchar", dynlib: pdcursesdll.}
proc setcchar*(a2: ptr Cunsignedlong; a3: Cstring; a4: Cunsignedlong; 
               a5: Cshort; a6: Pointer): Cint{.extdecl, importc: "setcchar", 
    dynlib: pdcursesdll.}
proc slkWset*(a2: Cint; a3: Cstring; a4: Cint): Cint{.extdecl, 
    importc: "slk_wset", dynlib: pdcursesdll.}
proc ungetWch*(a2: Char): Cint{.extdecl, importc: "unget_wch", 
                                    dynlib: pdcursesdll.}
proc vlineSet*(a2: ptr Cunsignedlong; a3: Cint): Cint{.extdecl, 
    importc: "vline_set", dynlib: pdcursesdll.}
proc waddnwstr*(a2: ptr TWINDOW; a3: Cstring; a4: Cint): Cint{.extdecl, 
    importc: "waddnwstr", dynlib: pdcursesdll.}
proc waddwstr*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, 
    importc: "waddwstr", dynlib: pdcursesdll.}
proc waddWch*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "wadd_wch", dynlib: pdcursesdll.}
proc waddWchnstr*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: Cint): Cint{.
    extdecl, importc: "wadd_wchnstr", dynlib: pdcursesdll.}
proc waddWchstr*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "wadd_wchstr", dynlib: pdcursesdll.}
proc wbkgrnd*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "wbkgrnd", dynlib: pdcursesdll.}
proc wbkgrndset*(a2: ptr TWINDOW; a3: ptr Cunsignedlong){.extdecl, 
    importc: "wbkgrndset", dynlib: pdcursesdll.}
proc wborderSet*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: ptr Cunsignedlong; 
                  a5: ptr Cunsignedlong; a6: ptr Cunsignedlong; 
                  a7: ptr Cunsignedlong; a8: ptr Cunsignedlong; 
                  a9: ptr Cunsignedlong; a10: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "wborder_set", dynlib: pdcursesdll.}
proc wechoWchar*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "wecho_wchar", dynlib: pdcursesdll.}
proc wgetbkgrnd*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "wgetbkgrnd", dynlib: pdcursesdll.}
proc wgetnWstr*(a2: ptr TWINDOW; a3: ptr Cint; a4: Cint): Cint{.extdecl, 
    importc: "wgetn_wstr", dynlib: pdcursesdll.}
proc wgetWch*(a2: ptr TWINDOW; a3: ptr Cint): Cint{.extdecl, 
    importc: "wget_wch", dynlib: pdcursesdll.}
proc wgetWstr*(a2: ptr TWINDOW; a3: ptr Cint): Cint{.extdecl, 
    importc: "wget_wstr", dynlib: pdcursesdll.}
proc whlineSet*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: Cint): Cint{.extdecl, 
    importc: "whline_set", dynlib: pdcursesdll.}
proc winnwstr*(a2: ptr TWINDOW; a3: Cstring; a4: Cint): Cint{.extdecl, 
    importc: "winnwstr", dynlib: pdcursesdll.}
proc winsNwstr*(a2: ptr TWINDOW; a3: Cstring; a4: Cint): Cint{.extdecl, 
    importc: "wins_nwstr", dynlib: pdcursesdll.}
proc winsWch*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "wins_wch", dynlib: pdcursesdll.}
proc winsWstr*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, 
    importc: "wins_wstr", dynlib: pdcursesdll.}
proc winwstr*(a2: ptr TWINDOW; a3: Cstring): Cint{.extdecl, importc: "winwstr", 
    dynlib: pdcursesdll.}
proc winWch*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "win_wch", dynlib: pdcursesdll.}
proc winWchnstr*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: Cint): Cint{.extdecl, 
    importc: "win_wchnstr", dynlib: pdcursesdll.}
proc winWchstr*(a2: ptr TWINDOW; a3: ptr Cunsignedlong): Cint{.extdecl, 
    importc: "win_wchstr", dynlib: pdcursesdll.}
proc wunctrl*(a2: ptr Cunsignedlong): Cstring{.extdecl, importc: "wunctrl", 
    dynlib: pdcursesdll.}
proc wvlineSet*(a2: ptr TWINDOW; a3: ptr Cunsignedlong; a4: Cint): Cint{.extdecl, 
    importc: "wvline_set", dynlib: pdcursesdll.}
proc getattrs*(a2: ptr TWINDOW): Cunsignedlong{.extdecl, importc: "getattrs", 
    dynlib: pdcursesdll.}
proc getbegx*(a2: ptr TWINDOW): Cint{.extdecl, importc: "getbegx", 
                                     dynlib: pdcursesdll.}
proc getbegy*(a2: ptr TWINDOW): Cint{.extdecl, importc: "getbegy", 
                                     dynlib: pdcursesdll.}
proc getmaxx*(a2: ptr TWINDOW): Cint{.extdecl, importc: "getmaxx", 
                                     dynlib: pdcursesdll.}
proc getmaxy*(a2: ptr TWINDOW): Cint{.extdecl, importc: "getmaxy", 
                                     dynlib: pdcursesdll.}
proc getparx*(a2: ptr TWINDOW): Cint{.extdecl, importc: "getparx", 
                                     dynlib: pdcursesdll.}
proc getpary*(a2: ptr TWINDOW): Cint{.extdecl, importc: "getpary", 
                                     dynlib: pdcursesdll.}
proc getcurx*(a2: ptr TWINDOW): Cint{.extdecl, importc: "getcurx", 
                                     dynlib: pdcursesdll.}
proc getcury*(a2: ptr TWINDOW): Cint{.extdecl, importc: "getcury", 
                                     dynlib: pdcursesdll.}
proc traceoff*(){.extdecl, importc: "traceoff", dynlib: pdcursesdll.}
proc traceon*(){.extdecl, importc: "traceon", dynlib: pdcursesdll.}
proc unctrl*(a2: Cunsignedlong): Cstring{.extdecl, importc: "unctrl", 
    dynlib: pdcursesdll.}
proc crmode*(): Cint{.extdecl, importc: "crmode", dynlib: pdcursesdll.}
proc nocrmode*(): Cint{.extdecl, importc: "nocrmode", dynlib: pdcursesdll.}
proc draino*(a2: Cint): Cint{.extdecl, importc: "draino", dynlib: pdcursesdll.}
proc resetterm*(): Cint{.extdecl, importc: "resetterm", dynlib: pdcursesdll.}
proc fixterm*(): Cint{.extdecl, importc: "fixterm", dynlib: pdcursesdll.}
proc saveterm*(): Cint{.extdecl, importc: "saveterm", dynlib: pdcursesdll.}
proc setsyx*(a2: Cint; a3: Cint): Cint{.extdecl, importc: "setsyx", 
                                        dynlib: pdcursesdll.}
proc mouseSet*(a2: Cunsignedlong): Cint{.extdecl, importc: "mouse_set", 
    dynlib: pdcursesdll.}
proc mouseOn*(a2: Cunsignedlong): Cint{.extdecl, importc: "mouse_on", 
    dynlib: pdcursesdll.}
proc mouseOff*(a2: Cunsignedlong): Cint{.extdecl, importc: "mouse_off", 
    dynlib: pdcursesdll.}
proc requestMousePos*(): Cint{.extdecl, importc: "request_mouse_pos", 
                                 dynlib: pdcursesdll.}
proc mapButton*(a2: Cunsignedlong): Cint{.extdecl, importc: "map_button", 
    dynlib: pdcursesdll.}
proc wmousePosition*(a2: ptr TWINDOW; a3: ptr Cint; a4: ptr Cint){.extdecl, 
    importc: "wmouse_position", dynlib: pdcursesdll.}
proc getmouse*(): Cunsignedlong{.extdecl, importc: "getmouse", dynlib: pdcursesdll.}
proc getbmap*(): Cunsignedlong{.extdecl, importc: "getbmap", dynlib: pdcursesdll.}
proc assumeDefaultColors*(a2: Cint; a3: Cint): Cint{.extdecl, 
    importc: "assume_default_colors", dynlib: pdcursesdll.}
proc cursesVersion*(): Cstring{.extdecl, importc: "curses_version", 
                                 dynlib: pdcursesdll.}
proc hasKey*(a2: Cint): Cunsignedchar{.extdecl, importc: "has_key", 
                                        dynlib: pdcursesdll.}
proc useDefaultColors*(): Cint{.extdecl, importc: "use_default_colors", 
                                  dynlib: pdcursesdll.}
proc wresize*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "wresize", dynlib: pdcursesdll.}
proc mouseinterval*(a2: Cint): Cint{.extdecl, importc: "mouseinterval", 
                                     dynlib: pdcursesdll.}
proc mousemask*(a2: Cunsignedlong; a3: ptr Cunsignedlong): Cunsignedlong{.extdecl, 
    importc: "mousemask", dynlib: pdcursesdll.}
proc mouseTrafo*(a2: ptr Cint; a3: ptr Cint; a4: Cunsignedchar): Cunsignedchar{.
    extdecl, importc: "mouse_trafo", dynlib: pdcursesdll.}
proc ncGetmouse*(a2: ptr TMEVENT): Cint{.extdecl, importc: "nc_getmouse", 
    dynlib: pdcursesdll.}
proc ungetmouse*(a2: ptr TMEVENT): Cint{.extdecl, importc: "ungetmouse", 
                                        dynlib: pdcursesdll.}
proc wenclose*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cunsignedchar{.extdecl, 
    importc: "wenclose", dynlib: pdcursesdll.}
proc wmouseTrafo*(a2: ptr TWINDOW; a3: ptr Cint; a4: ptr Cint; a5: Cunsignedchar): Cunsignedchar{.
    extdecl, importc: "wmouse_trafo", dynlib: pdcursesdll.}
proc addrawch*(a2: Cunsignedlong): Cint{.extdecl, importc: "addrawch", 
    dynlib: pdcursesdll.}
proc insrawch*(a2: Cunsignedlong): Cint{.extdecl, importc: "insrawch", 
    dynlib: pdcursesdll.}
proc isTermresized*(): Cunsignedchar{.extdecl, importc: "is_termresized", 
                                       dynlib: pdcursesdll.}
proc mvaddrawch*(a2: Cint; a3: Cint; a4: Cunsignedlong): Cint{.extdecl, 
    importc: "mvaddrawch", dynlib: pdcursesdll.}
proc mvdeleteln*(a2: Cint; a3: Cint): Cint{.extdecl, importc: "mvdeleteln", 
    dynlib: pdcursesdll.}
proc mvinsertln*(a2: Cint; a3: Cint): Cint{.extdecl, importc: "mvinsertln", 
    dynlib: pdcursesdll.}
proc mvinsrawch*(a2: Cint; a3: Cint; a4: Cunsignedlong): Cint{.extdecl, 
    importc: "mvinsrawch", dynlib: pdcursesdll.}
proc mvwaddrawch*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cunsignedlong): Cint{.
    extdecl, importc: "mvwaddrawch", dynlib: pdcursesdll.}
proc mvwdeleteln*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "mvwdeleteln", dynlib: pdcursesdll.}
proc mvwinsertln*(a2: ptr TWINDOW; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "mvwinsertln", dynlib: pdcursesdll.}
proc mvwinsrawch*(a2: ptr TWINDOW; a3: Cint; a4: Cint; a5: Cunsignedlong): Cint{.
    extdecl, importc: "mvwinsrawch", dynlib: pdcursesdll.}
proc rawOutput*(a2: Cunsignedchar): Cint{.extdecl, importc: "raw_output", 
    dynlib: pdcursesdll.}
proc resizeTerm*(a2: Cint; a3: Cint): Cint{.extdecl, importc: "resize_term", 
    dynlib: pdcursesdll.}
proc resizeWindow*(a2: ptr TWINDOW; a3: Cint; a4: Cint): ptr TWINDOW{.extdecl, 
    importc: "resize_window", dynlib: pdcursesdll.}
proc waddrawch*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, 
    importc: "waddrawch", dynlib: pdcursesdll.}
proc winsrawch*(a2: ptr TWINDOW; a3: Cunsignedlong): Cint{.extdecl, 
    importc: "winsrawch", dynlib: pdcursesdll.}
proc wordchar*(): Char{.extdecl, importc: "wordchar", dynlib: pdcursesdll.}
proc slkWlabel*(a2: Cint): Cstring{.extdecl, importc: "slk_wlabel", 
    dynlib: pdcursesdll.}
proc debug*(a2: Cstring){.varargs, extdecl, importc: "PDC_debug", 
                          dynlib: pdcursesdll.}
proc ungetch*(a2: Cint): Cint{.extdecl, importc: "PDC_ungetch", 
                               dynlib: pdcursesdll.}
proc setBlink*(a2: Cunsignedchar): Cint{.extdecl, importc: "PDC_set_blink", 
    dynlib: pdcursesdll.}
proc setLineColor*(a2: Cshort): Cint{.extdecl, importc: "PDC_set_line_color", 
                                        dynlib: pdcursesdll.}
proc setTitle*(a2: Cstring){.extdecl, importc: "PDC_set_title", 
                              dynlib: pdcursesdll.}
proc clearclipboard*(): Cint{.extdecl, importc: "PDC_clearclipboard", 
                              dynlib: pdcursesdll.}
proc freeclipboard*(a2: Cstring): Cint{.extdecl, importc: "PDC_freeclipboard", 
                                        dynlib: pdcursesdll.}
proc getclipboard*(a2: CstringArray; a3: ptr Clong): Cint{.extdecl, 
    importc: "PDC_getclipboard", dynlib: pdcursesdll.}
proc setclipboard*(a2: Cstring; a3: Clong): Cint{.extdecl, 
    importc: "PDC_setclipboard", dynlib: pdcursesdll.}
proc getInputFd*(): Cunsignedlong{.extdecl, importc: "PDC_get_input_fd", 
                                     dynlib: pdcursesdll.}
proc getKeyModifiers*(): Cunsignedlong{.extdecl, 
    importc: "PDC_get_key_modifiers", dynlib: pdcursesdll.}
proc returnKeyModifiers*(a2: Cunsignedchar): Cint{.extdecl, 
    importc: "PDC_return_key_modifiers", dynlib: pdcursesdll.}
proc saveKeyModifiers*(a2: Cunsignedchar): Cint{.extdecl, 
    importc: "PDC_save_key_modifiers", dynlib: pdcursesdll.}
proc bottomPanel*(pan: ptr TPANEL): Cint{.extdecl, importc: "bottom_panel", 
    dynlib: pdcursesdll.}
proc delPanel*(pan: ptr TPANEL): Cint{.extdecl, importc: "del_panel", 
                                       dynlib: pdcursesdll.}
proc hidePanel*(pan: ptr TPANEL): Cint{.extdecl, importc: "hide_panel", 
                                        dynlib: pdcursesdll.}
proc movePanel*(pan: ptr TPANEL; starty: Cint; startx: Cint): Cint{.extdecl, 
    importc: "move_panel", dynlib: pdcursesdll.}
proc newPanel*(win: ptr TWINDOW): ptr TPANEL{.extdecl, importc: "new_panel", 
    dynlib: pdcursesdll.}
proc panelAbove*(pan: ptr TPANEL): ptr TPANEL{.extdecl, importc: "panel_above", 
    dynlib: pdcursesdll.}
proc panelBelow*(pan: ptr TPANEL): ptr TPANEL{.extdecl, importc: "panel_below", 
    dynlib: pdcursesdll.}
proc panelHidden*(pan: ptr TPANEL): Cint{.extdecl, importc: "panel_hidden", 
    dynlib: pdcursesdll.}
proc panelUserptr*(pan: ptr TPANEL): Pointer{.extdecl, importc: "panel_userptr", 
    dynlib: pdcursesdll.}
proc panelWindow*(pan: ptr TPANEL): ptr TWINDOW{.extdecl, importc: "panel_window", 
    dynlib: pdcursesdll.}
proc replacePanel*(pan: ptr TPANEL; win: ptr TWINDOW): Cint{.extdecl, 
    importc: "replace_panel", dynlib: pdcursesdll.}
proc setPanelUserptr*(pan: ptr TPANEL; uptr: Pointer): Cint{.extdecl, 
    importc: "set_panel_userptr", dynlib: pdcursesdll.}
proc showPanel*(pan: ptr TPANEL): Cint{.extdecl, importc: "show_panel", 
                                        dynlib: pdcursesdll.}
proc topPanel*(pan: ptr TPANEL): Cint{.extdecl, importc: "top_panel", 
                                       dynlib: pdcursesdll.}
proc updatePanels*(){.extdecl, importc: "update_panels", dynlib: pdcursesdll.}

when unixOS:
  proc xinitscr*(a2: Cint; a3: CstringArray): ptr TWINDOW{.extdecl, 
    importc: "Xinitscr", dynlib: pdcursesdll.}
  proc xCursesExit*(){.extdecl, importc: "XCursesExit", dynlib: pdcursesdll.}
  proc sbInit*(): Cint{.extdecl, importc: "sb_init", dynlib: pdcursesdll.}
  proc sbSetHorz*(a2: Cint; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "sb_set_horz", dynlib: pdcursesdll.}
  proc sbSetVert*(a2: Cint; a3: Cint; a4: Cint): Cint{.extdecl, 
    importc: "sb_set_vert", dynlib: pdcursesdll.}
  proc sbGetHorz*(a2: ptr Cint; a3: ptr Cint; a4: ptr Cint): Cint{.extdecl, 
    importc: "sb_get_horz", dynlib: pdcursesdll.}
  proc sbGetVert*(a2: ptr Cint; a3: ptr Cint; a4: ptr Cint): Cint{.extdecl, 
    importc: "sb_get_vert", dynlib: pdcursesdll.}
  proc sbRefresh*(): Cint{.extdecl, importc: "sb_refresh", dynlib: pdcursesdll.}

template getch*(): Expr = 
  wgetch(stdscr)

template ungetch*(ch: Expr): Expr = 
  ungetch(ch)

template getbegyx*(w, y, x: Expr): Expr =
  y = getbegy(w)
  x = getbegx(w)

template getmaxyx*(w, y, x: Expr): Expr =
  y = getmaxy(w)
  x = getmaxx(w)

template getparyx*(w, y, x: Expr): Expr =
  y = getpary(w)
  x = getparx(w)

template getyx*(w, y, x: Expr): Expr =
  y = getcury(w)
  x = getcurx(w)

template getsyx*(y, x: Expr): Stmt = 
  if curscr.leaveit:
    (x) = - 1
    (y) = (x)
  else: getyx(curscr, (y), (x))
  
template getmouse*(x: Expr): Expr = 
  nc_getmouse(x)

when defined(windows):
  var
    atrtab*{.importc: "pdc_atrtab", dynlib: pdcursesdll.}: cstring
    con_out*{.importc: "pdc_con_out", dynlib: pdcursesdll.}: HANDLE
    con_in*{.importc: "pdc_con_in", dynlib: pdcursesdll.}: HANDLE
    quick_edit*{.importc: "pdc_quick_edit", dynlib: pdcursesdll.}: DWORD

  proc get_buffer_rows*(): cint{.extdecl, importc: "PDC_get_buffer_rows", 
                               dynlib: pdcursesdll.}
