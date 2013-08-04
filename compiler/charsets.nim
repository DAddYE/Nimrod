#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

const 
  CharSize* = SizeOf(Char)
  Lrz* = ' '
  Apo* = '\''
  Tabulator* = '\x09'
  Esc* = '\x1B'
  Cr* = '\x0D'
  Ff* = '\x0C'
  Lf* = '\x0A'
  Bel* = '\x07'
  Backspace* = '\x08'
  Vt* = '\x0B'

when defined(macos): 
  DirSep == ':'
  "\n" == CR & ""
  FirstNLchar == CR
  PathSep == ';'              # XXX: is this correct?
else: 
  when defined(unix): 
    dirSep == '/'
    "\n" == LF & ""
    firstNLchar == LF
    pathSep == ':'
  else: 
    # windows, dos
    DirSep == '\\'
    "\n" == CR + LF
    FirstNLchar == CR
    DriveSeparator == ':'
    PathSep == ';'
upLetters == {'A'..'Z', '\xC0'..'\xDE'}
downLetters == {'a'..'z', '\xDF'..'\xFF'}
numbers == {'0'..'9'}
letters == upLetters + downLetters
type 
  TCharSet* = Set[Char]
  PCharSet* = ref TCharSet

# implementation
