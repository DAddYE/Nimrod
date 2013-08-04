# Readline.h -- the names of functions callable from within readline. 
# Copyright (C) 1987-2009 Free Software Foundation, Inc.
#
#   This file is part of the GNU Readline Library (Readline), a library
#   for reading lines of text with interactive input and history editing.      
#
#   Readline is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Readline is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Readline.  If not, see <http://www.gnu.org/licenses/>.
#

{.deadCodeElim: on.}
when defined(windows): 
  const 
    readlineDll* = "readline.dll"
elif defined(macosx): 
  # Mac OS X ships with 'libedit'
  const 
    readlineDll* = "libedit(.2|.1|).dylib"
else: 
  const 
    readlineDll* = "libreadline.so.6(|.0)"
##  mangle "'TCommandFunc'" TCommandFunc
##  mangle TvcpFunc TvcpFunc

import rltypedefs

# Some character stuff. 

const 
  controlCharacterThreshold* = 0x00000020 # Smaller than this is control. 
  controlCharacterMask* = 0x0000001F # 0x20 - 1 
  metaCharacterThreshold* = 0x0000007F # Larger than this is Meta. 
  controlCharacterBit* = 0x00000040 # 0x000000, must be off. 
  metaCharacterBit* = 0x00000080 # x0000000, must be on. 
  largestChar* = 255         # Largest character value. 

template ctrlChar*(c: Expr): Expr = 
  (c < control_character_threshold and ((c and 0x00000080) == 0))

template metaChar*(c: Expr): Expr = 
  (c > meta_character_threshold and c <= largest_char)

template ctrl*(c: Expr): Expr = 
  (c and control_character_mask)

template meta*(c: Expr): Expr = 
  (c or meta_character_bit)

template unmeta*(c: Expr): Expr = 
  (c and not meta_character_bit)

template unctrl*(c: Expr): Expr = 
  (c or 32 or control_character_bit)

# Beware:  these only work with single-byte ASCII characters. 

const 
  ReturnChar* = CTRL('M'.ord)
  RuboutChar* = 0x0000007F
  AbortChar* = CTRL('G'.ord)
  PageChar* = CTRL('L'.ord)
  EscChar* = CTRL('['.ord)

# A keymap contains one entry for each key in the ASCII set.
#   Each entry consists of a type and a pointer.
#   FUNCTION is the address of a function to run, or the
#   address of a keymap to indirect through.
#   TYPE says which kind of thing FUNCTION is. 

type 
  TKEYMAP_ENTRY*{.pure, final.} = object 
    typ*: Char
    function*: TcommandFunc


# This must be large enough to hold bindings for all of the characters
#   in a desired character set (e.g, 128 for ASCII, 256 for ISO Latin-x,
#   and so on) plus one for subsequence matching. 

const 
  KeymapSize* = 257
  Anyotherkey* = KEYMAP_SIZE - 1

# I wanted to make the above structure contain a union of:
#   union { rl_TCommandFunc_t *function; struct _keymap_entry *keymap; } value;
#   but this made it impossible for me to create a static array.
#   Maybe I need C lessons. 

type 
  TKEYMAP_ENTRY_ARRAY* = Array[0..KEYMAP_SIZE - 1, TKEYMAP_ENTRY]
  PKeymap* = ptr TKEYMAP_ENTRY

# The values that TYPE can have in a keymap entry. 

const 
  Isfunc* = 0
  Iskmap* = 1
  Ismacr* = 2

when false: 
  var 
    emacs_standard_keymap*{.importc: "emacs_standard_keymap", 
                            dynlib: readlineDll.}: TKEYMAP_ENTRY_ARRAY
    emacs_meta_keymap*{.importc: "emacs_meta_keymap", dynlib: readlineDll.}: TKEYMAP_ENTRY_ARRAY
    emacs_ctlx_keymap*{.importc: "emacs_ctlx_keymap", dynlib: readlineDll.}: TKEYMAP_ENTRY_ARRAY
  var 
    vi_insertion_keymap*{.importc: "vi_insertion_keymap", dynlib: readlineDll.}: TKEYMAP_ENTRY_ARRAY
    vi_movement_keymap*{.importc: "vi_movement_keymap", dynlib: readlineDll.}: TKEYMAP_ENTRY_ARRAY
# Return a new, empty keymap.
#   Free it with free() when you are done. 

proc makeBareKeymap*(): PKeymap{.cdecl, importc: "rl_make_bare_keymap", 
                                   dynlib: readlineDll.}
# Return a new keymap which is a copy of MAP. 

proc copyKeymap*(a2: PKeymap): PKeymap{.cdecl, importc: "rl_copy_keymap", 
    dynlib: readlineDll.}
# Return a new keymap with the printing characters bound to rl_insert,
#   the lowercase Meta characters bound to run their equivalents, and
#   the Meta digits bound to produce numeric arguments. 

proc makeKeymap*(): PKeymap{.cdecl, importc: "rl_make_keymap", 
                              dynlib: readlineDll.}
# Free the storage associated with a keymap. 

proc discardKeymap*(a2: PKeymap){.cdecl, importc: "rl_discard_keymap", 
                                   dynlib: readlineDll.}
# These functions actually appear in bind.c 
# Return the keymap corresponding to a given name.  Names look like
#   `emacs' or `emacs-meta' or `vi-insert'.  

proc getKeymapByName*(a2: Cstring): PKeymap{.cdecl, 
    importc: "rl_get_keymap_by_name", dynlib: readlineDll.}
# Return the current keymap. 

proc getKeymap*(): PKeymap{.cdecl, importc: "rl_get_keymap", 
                             dynlib: readlineDll.}
# Set the current keymap to MAP. 

proc setKeymap*(a2: PKeymap){.cdecl, importc: "rl_set_keymap", 
                               dynlib: readlineDll.}

const 
  tildeDll = readlineDll

type 
  ThookFunc* = proc (a2: Cstring): Cstring{.cdecl.}

when not defined(macosx):
  # If non-null, this contains the address of a function that the application
  #   wants called before trying the standard tilde expansions.  The function
  #   is called with the text sans tilde, and returns a malloc()'ed string
  #   which is the expansion, or a NULL pointer if the expansion fails. 

  var expansion_preexpansion_hook*{.importc: "tilde_expansion_preexpansion_hook", 
                                    dynlib: tildeDll.}: Thook_func

  # If non-null, this contains the address of a function to call if the
  #   standard meaning for expanding a tilde fails.  The function is called
  #   with the text (sans tilde, as in "foo"), and returns a malloc()'ed string
  #   which is the expansion, or a NULL pointer if there is no expansion. 

  var expansion_failure_hook*{.importc: "tilde_expansion_failure_hook", 
                               dynlib: tildeDll.}: Thook_func

  # When non-null, this is a NULL terminated array of strings which
  #   are duplicates for a tilde prefix.  Bash uses this to expand
  #   `=~' and `:~'. 

  var additional_prefixes*{.importc: "tilde_additional_prefixes", dynlib: tildeDll.}: cstringArray

  # When non-null, this is a NULL terminated array of strings which match
  #   the end of a username, instead of just "/".  Bash sets this to
  #   `:' and `=~'. 

  var additional_suffixes*{.importc: "tilde_additional_suffixes", dynlib: tildeDll.}: cstringArray

# Return a new string which is the result of tilde expanding STRING. 

proc expand*(a2: Cstring): Cstring{.cdecl, importc: "tilde_expand", 
                                    dynlib: tildeDll.}
# Do the work of tilde expansion on FILENAME.  FILENAME starts with a
#   tilde.  If there is no expansion, call tilde_expansion_failure_hook. 

proc expandWord*(a2: Cstring): Cstring{.cdecl, importc: "tilde_expand_word", 
    dynlib: tildeDll.}
# Find the portion of the string beginning with ~ that should be expanded. 

proc findWord*(a2: Cstring, a3: Cint, a4: ptr Cint): Cstring{.cdecl, 
    importc: "tilde_find_word", dynlib: tildeDll.}

# Hex-encoded Readline version number. 

const 
  ReadlineVersion* = 0x00000600 # Readline 6.0 
  VersionMajor* = 6
  VersionMinor* = 0

# Readline data structures. 
# Maintaining the state of undo.  We remember individual deletes and inserts
#   on a chain of things to do. 
# The actions that undo knows how to undo.  Notice that UNDO_DELETE means
#   to insert some text, and UNDO_INSERT means to delete some text.   I.e.,
#   the code tells undo what to undo, not how to undo it. 

type 
  TundoCode* = enum 
    UNDO_DELETE, UNDO_INSERT, UNDO_BEGIN, UNDO_END

# What an element of THE_UNDO_LIST looks like. 

type 
  TUNDO_LIST*{.pure, final.} = object 
    next*: ptr Tundo_list
    start*: Cint
    theEnd*: Cint             # Where the change took place. 
    text*: Cstring            # The text to insert, if undoing a delete. 
    what*: TundoCode         # Delete, Insert, Begin, End. 
  

# The current undo list for RL_LINE_BUFFER. 

when not defined(macosx):
  var undo_list*{.importc: "rl_undo_list", dynlib: readlineDll.}: ptr TUNDO_LIST

# The data structure for mapping textual names to code addresses. 

type 
  TFUNMAP*{.pure, final.} = object 
    name*: Cstring
    function*: TcommandFunc


when not defined(macosx):
  var funmap*{.importc: "funmap", dynlib: readlineDll.}: ptr ptr TFUNMAP

# **************************************************************** 
#								    
#	     Functions available to bind to key sequences	    
#								    
# **************************************************************** 
# Bindable commands for numeric arguments. 

proc digitArgument*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_digit_argument", dynlib: readlineDll.}
proc universalArgument*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_universal_argument", dynlib: readlineDll.}
# Bindable commands for moving the cursor. 

proc forwardByte*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_forward_byte", 
    dynlib: readlineDll.}
proc forwardChar*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_forward_char", 
    dynlib: readlineDll.}
proc forward*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_forward", 
    dynlib: readlineDll.}
proc backwardByte*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_backward_byte", dynlib: readlineDll.}
proc backwardChar*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_backward_char", dynlib: readlineDll.}
proc backward*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_backward", 
    dynlib: readlineDll.}
proc begOfLine*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_beg_of_line", 
    dynlib: readlineDll.}
proc endOfLine*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_end_of_line", 
    dynlib: readlineDll.}
proc forwardWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_forward_word", 
    dynlib: readlineDll.}
proc backwardWord*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_backward_word", dynlib: readlineDll.}
proc refreshLine*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_refresh_line", 
    dynlib: readlineDll.}
proc clearScreen*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_clear_screen", 
    dynlib: readlineDll.}
proc skipCsiSequence*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_skip_csi_sequence", dynlib: readlineDll.}
proc arrowKeys*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_arrow_keys", 
    dynlib: readlineDll.}
# Bindable commands for inserting and deleting text. 

proc insert*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_insert", 
                                        dynlib: readlineDll.}
proc quotedInsert*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_quoted_insert", dynlib: readlineDll.}
proc tabInsert*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_tab_insert", 
    dynlib: readlineDll.}
proc newline*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_newline", 
    dynlib: readlineDll.}
proc doLowercaseVersion*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_do_lowercase_version", dynlib: readlineDll.}
proc rubout*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_rubout", 
                                        dynlib: readlineDll.}
proc delete*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_delete", 
                                        dynlib: readlineDll.}
proc ruboutOrDelete*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_rubout_or_delete", dynlib: readlineDll.}
proc deleteHorizontalSpace*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_delete_horizontal_space", dynlib: readlineDll.}
proc deleteOrShowCompletions*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_delete_or_show_completions", dynlib: readlineDll.}
proc insertComment*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_insert_comment", dynlib: readlineDll.}
# Bindable commands for changing case. 

proc upcaseWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_upcase_word", 
    dynlib: readlineDll.}
proc downcaseWord*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_downcase_word", dynlib: readlineDll.}
proc capitalizeWord*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_capitalize_word", dynlib: readlineDll.}
# Bindable commands for transposing characters and words. 

proc transposeWords*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_transpose_words", dynlib: readlineDll.}
proc transposeChars*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_transpose_chars", dynlib: readlineDll.}
# Bindable commands for searching within a line. 

proc charSearch*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_char_search", 
    dynlib: readlineDll.}
proc backwardCharSearch*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_backward_char_search", dynlib: readlineDll.}
# Bindable commands for readline's interface to the command history. 

proc beginningOfHistory*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_beginning_of_history", dynlib: readlineDll.}
proc endOfHistory*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_end_of_history", dynlib: readlineDll.}
proc getNextHistory*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_get_next_history", dynlib: readlineDll.}
proc getPreviousHistory*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_get_previous_history", dynlib: readlineDll.}
# Bindable commands for managing the mark and region. 

proc setMark*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_set_mark", 
    dynlib: readlineDll.}
proc exchangePointAndMark*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_exchange_point_and_mark", dynlib: readlineDll.}
# Bindable commands to set the editing mode (emacs or vi). 

proc viEditingMode*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_editing_mode", dynlib: readlineDll.}
proc emacsEditingMode*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_emacs_editing_mode", dynlib: readlineDll.}
# Bindable commands to change the insert mode (insert or overwrite) 

proc overwriteMode*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_overwrite_mode", dynlib: readlineDll.}
# Bindable commands for managing key bindings. 

proc reReadInitFile*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_re_read_init_file", dynlib: readlineDll.}
proc dumpFunctions*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_dump_functions", dynlib: readlineDll.}
proc dumpMacros*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_dump_macros", 
    dynlib: readlineDll.}
proc dumpVariables*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_dump_variables", dynlib: readlineDll.}
# Bindable commands for word completion. 

proc complete*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_complete", 
    dynlib: readlineDll.}
proc possibleCompletions*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_possible_completions", dynlib: readlineDll.}
proc insertCompletions*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_insert_completions", dynlib: readlineDll.}
proc oldMenuComplete*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_old_menu_complete", dynlib: readlineDll.}
proc menuComplete*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_menu_complete", dynlib: readlineDll.}
proc backwardMenuComplete*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_backward_menu_complete", dynlib: readlineDll.}
# Bindable commands for killing and yanking text, and managing the kill ring. 

proc killWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_kill_word", 
    dynlib: readlineDll.}
proc backwardKillWord*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_backward_kill_word", dynlib: readlineDll.}
proc killLine*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_kill_line", 
    dynlib: readlineDll.}
proc backwardKillLine*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_backward_kill_line", dynlib: readlineDll.}
proc killFullLine*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_kill_full_line", dynlib: readlineDll.}
proc unixWordRubout*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_unix_word_rubout", dynlib: readlineDll.}
proc unixFilenameRubout*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_unix_filename_rubout", dynlib: readlineDll.}
proc unixLineDiscard*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_unix_line_discard", dynlib: readlineDll.}
proc copyRegionToKill*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_copy_region_to_kill", dynlib: readlineDll.}
proc killRegion*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_kill_region", 
    dynlib: readlineDll.}
proc copyForwardWord*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_copy_forward_word", dynlib: readlineDll.}
proc copyBackwardWord*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_copy_backward_word", dynlib: readlineDll.}
proc yank*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_yank", 
                                      dynlib: readlineDll.}
proc yankPop*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_yank_pop", 
    dynlib: readlineDll.}
proc yankNthArg*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_yank_nth_arg", 
    dynlib: readlineDll.}
proc yankLastArg*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_yank_last_arg", dynlib: readlineDll.}
when defined(Windows): 
  proc paste_from_clipboard*(a2: cint, a3: cint): cint{.cdecl, 
      importc: "rl_paste_from_clipboard", dynlib: readlineDll.}
# Bindable commands for incremental searching. 

proc reverseSearchHistory*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_reverse_search_history", dynlib: readlineDll.}
proc forwardSearchHistory*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_forward_search_history", dynlib: readlineDll.}
# Bindable keyboard macro commands. 

proc startKbdMacro*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_start_kbd_macro", dynlib: readlineDll.}
proc endKbdMacro*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_end_kbd_macro", dynlib: readlineDll.}
proc callLastKbdMacro*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_call_last_kbd_macro", dynlib: readlineDll.}
# Bindable undo commands. 

proc revertLine*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_revert_line", 
    dynlib: readlineDll.}
proc undoCommand*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_undo_command", 
    dynlib: readlineDll.}
# Bindable tilde expansion commands. 

proc tildeExpand*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_tilde_expand", 
    dynlib: readlineDll.}
# Bindable terminal control commands. 

proc restartOutput*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_restart_output", dynlib: readlineDll.}
proc stopOutput*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_stop_output", 
    dynlib: readlineDll.}
# Miscellaneous bindable commands. 

proc abort*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_abort", 
                                       dynlib: readlineDll.}
proc ttyStatus*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_tty_status", 
    dynlib: readlineDll.}
# Bindable commands for incremental and non-incremental history searching. 

proc historySearchForward*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_history_search_forward", dynlib: readlineDll.}
proc historySearchBackward*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_history_search_backward", dynlib: readlineDll.}
proc nonincForwardSearch*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_noninc_forward_search", dynlib: readlineDll.}
proc nonincReverseSearch*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_noninc_reverse_search", dynlib: readlineDll.}
proc nonincForwardSearchAgain*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_noninc_forward_search_again", dynlib: readlineDll.}
proc nonincReverseSearchAgain*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_noninc_reverse_search_again", dynlib: readlineDll.}
# Bindable command used when inserting a matching close character. 

proc insertClose*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_insert_close", 
    dynlib: readlineDll.}
# Not available unless READLINE_CALLBACKS is defined. 

proc callbackHandlerInstall*(a2: Cstring, a3: Tvcpfunc){.cdecl, 
    importc: "rl_callback_handler_install", dynlib: readlineDll.}
proc callbackReadChar*(){.cdecl, importc: "rl_callback_read_char", 
                            dynlib: readlineDll.}
proc callbackHandlerRemove*(){.cdecl, importc: "rl_callback_handler_remove", 
                                 dynlib: readlineDll.}
# Things for vi mode. Not available unless readline is compiled -DVI_MODE. 
# VI-mode bindable commands. 

proc viRedo*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_redo", 
    dynlib: readlineDll.}
proc viUndo*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_undo", 
    dynlib: readlineDll.}
proc viYankArg*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_yank_arg", 
    dynlib: readlineDll.}
proc viFetchHistory*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_fetch_history", dynlib: readlineDll.}
proc viSearchAgain*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_search_again", dynlib: readlineDll.}
proc viSearch*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_search", 
    dynlib: readlineDll.}
proc viComplete*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_complete", 
    dynlib: readlineDll.}
proc viTildeExpand*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_tilde_expand", dynlib: readlineDll.}
proc viPrevWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_prev_word", 
    dynlib: readlineDll.}
proc viNextWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_next_word", 
    dynlib: readlineDll.}
proc viEndWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_end_word", 
    dynlib: readlineDll.}
proc viInsertBeg*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_insert_beg", dynlib: readlineDll.}
proc viAppendMode*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_append_mode", dynlib: readlineDll.}
proc viAppendEol*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_append_eol", dynlib: readlineDll.}
proc viEofMaybe*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_eof_maybe", 
    dynlib: readlineDll.}
proc viInsertionMode*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_insertion_mode", dynlib: readlineDll.}
proc viInsertMode*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_insert_mode", dynlib: readlineDll.}
proc viMovementMode*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_movement_mode", dynlib: readlineDll.}
proc viArgDigit*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_arg_digit", 
    dynlib: readlineDll.}
proc viChangeCase*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_change_case", dynlib: readlineDll.}
proc viPut*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_put", 
                                        dynlib: readlineDll.}
proc viColumn*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_column", 
    dynlib: readlineDll.}
proc viDeleteTo*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_delete_to", 
    dynlib: readlineDll.}
proc viChangeTo*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_change_to", 
    dynlib: readlineDll.}
proc viYankTo*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_yank_to", 
    dynlib: readlineDll.}
proc viRubout*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_rubout", 
    dynlib: readlineDll.}
proc viDelete*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_delete", 
    dynlib: readlineDll.}
proc viBackToIndent*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_back_to_indent", dynlib: readlineDll.}
proc viFirstPrint*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_first_print", dynlib: readlineDll.}
proc viCharSearch*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_char_search", dynlib: readlineDll.}
proc viMatch*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_match", 
    dynlib: readlineDll.}
proc viChangeChar*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_change_char", dynlib: readlineDll.}
proc viSubst*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_subst", 
    dynlib: readlineDll.}
proc viOverstrike*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_overstrike", dynlib: readlineDll.}
proc viOverstrikeDelete*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_vi_overstrike_delete", dynlib: readlineDll.}
proc viReplace*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_replace", 
    dynlib: readlineDll.}
proc viSetMark*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_set_mark", 
    dynlib: readlineDll.}
proc viGotoMark*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_goto_mark", 
    dynlib: readlineDll.}
# VI-mode utility functions. 

proc viCheck*(): Cint{.cdecl, importc: "rl_vi_check", dynlib: readlineDll.}
proc viDomove*(a2: Cint, a3: ptr Cint): Cint{.cdecl, importc: "rl_vi_domove", 
    dynlib: readlineDll.}
proc viBracktype*(a2: Cint): Cint{.cdecl, importc: "rl_vi_bracktype", 
                                    dynlib: readlineDll.}
proc viStartInserting*(a2: Cint, a3: Cint, a4: Cint){.cdecl, 
    importc: "rl_vi_start_inserting", dynlib: readlineDll.}
# VI-mode pseudo-bindable commands, used as utility functions. 

proc viFXWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_fWord", 
    dynlib: readlineDll.}
proc viBXWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_bWord", 
    dynlib: readlineDll.}
proc viEXWord*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_eWord", 
    dynlib: readlineDll.}
proc viFword*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_fword", 
    dynlib: readlineDll.}
proc viBword*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_bword", 
    dynlib: readlineDll.}
proc viEword*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_vi_eword", 
    dynlib: readlineDll.}
# **************************************************************** 
#								    
#			Well Published Functions		    
#								    
# **************************************************************** 
# Readline functions. 
# Read a line of input.  Prompt with PROMPT.  A NULL PROMPT means none. 

proc readline*(a2: Cstring): Cstring{.cdecl, importc: "readline", 
                                      dynlib: readlineDll.}
proc free*(mem: Cstring) {.importc: "free", nodecl.}
  ## free the buffer that `readline` returned.

proc setPrompt*(a2: Cstring): Cint{.cdecl, importc: "rl_set_prompt", 
                                     dynlib: readlineDll.}
proc expandPrompt*(a2: Cstring): Cint{.cdecl, importc: "rl_expand_prompt", 
                                        dynlib: readlineDll.}
proc initialize*(): Cint{.cdecl, importc: "rl_initialize", dynlib: readlineDll.}
# Undocumented; unused by readline 

proc discardArgument*(): Cint{.cdecl, importc: "rl_discard_argument", 
                                dynlib: readlineDll.}
# Utility functions to bind keys to readline commands. 

proc addDefun*(a2: Cstring, a3: TcommandFunc, a4: Cint): Cint{.cdecl, 
    importc: "rl_add_defun", dynlib: readlineDll.}
proc bindKey*(a2: Cint, a3: TcommandFunc): Cint{.cdecl, 
    importc: "rl_bind_key", dynlib: readlineDll.}
proc bindKeyInMap*(a2: Cint, a3: TcommandFunc, a4: PKeymap): Cint{.cdecl, 
    importc: "rl_bind_key_in_map", dynlib: readlineDll.}
proc unbindKey*(a2: Cint): Cint{.cdecl, importc: "rl_unbind_key", 
                                  dynlib: readlineDll.}
proc unbindKeyInMap*(a2: Cint, a3: PKeymap): Cint{.cdecl, 
    importc: "rl_unbind_key_in_map", dynlib: readlineDll.}
proc bindKeyIfUnbound*(a2: Cint, a3: TcommandFunc): Cint{.cdecl, 
    importc: "rl_bind_key_if_unbound", dynlib: readlineDll.}
proc bindKeyIfUnboundInMap*(a2: cint, a3: TcommandFunc, a4: PKeymap): cint{.
    cdecl, importc: "rl_bind_key_if_unbound_in_map", dynlib: readlineDll.}
proc unbindFunctionInMap*(a2: TcommandFunc, a3: PKeymap): Cint{.cdecl, 
    importc: "rl_unbind_function_in_map", dynlib: readlineDll.}
proc unbindCommandInMap*(a2: Cstring, a3: PKeymap): Cint{.cdecl, 
    importc: "rl_unbind_command_in_map", dynlib: readlineDll.}
proc bindKeyseq*(a2: Cstring, a3: TcommandFunc): Cint{.cdecl, 
    importc: "rl_bind_keyseq", dynlib: readlineDll.}
proc bindKeyseqInMap*(a2: Cstring, a3: TcommandFunc, a4: PKeymap): Cint{.
    cdecl, importc: "rl_bind_keyseq_in_map", dynlib: readlineDll.}
proc bindKeyseqIfUnbound*(a2: Cstring, a3: TcommandFunc): Cint{.cdecl, 
    importc: "rl_bind_keyseq_if_unbound", dynlib: readlineDll.}
proc bindKeyseqIfUnboundInMap*(a2: Cstring, a3: TcommandFunc, 
                                    a4: PKeymap): Cint{.cdecl, 
    importc: "rl_bind_keyseq_if_unbound_in_map", dynlib: readlineDll.}
proc genericBind*(a2: Cint, a3: Cstring, a4: Cstring, a5: PKeymap): Cint{.
    cdecl, importc: "rl_generic_bind", dynlib: readlineDll.}
proc variableValue*(a2: Cstring): Cstring{.cdecl, importc: "rl_variable_value", 
    dynlib: readlineDll.}
proc variableBind*(a2: Cstring, a3: Cstring): Cint{.cdecl, 
    importc: "rl_variable_bind", dynlib: readlineDll.}
# Backwards compatibility, use rl_bind_keyseq_in_map instead. 

proc setKey*(a2: Cstring, a3: TcommandFunc, a4: PKeymap): Cint{.cdecl, 
    importc: "rl_set_key", dynlib: readlineDll.}
# Backwards compatibility, use rl_generic_bind instead. 

proc macroBind*(a2: Cstring, a3: Cstring, a4: PKeymap): Cint{.cdecl, 
    importc: "rl_macro_bind", dynlib: readlineDll.}
# Undocumented in the texinfo manual; not really useful to programs. 

proc translateKeyseq*(a2: Cstring, a3: Cstring, a4: ptr Cint): Cint{.cdecl, 
    importc: "rl_translate_keyseq", dynlib: readlineDll.}
proc untranslateKeyseq*(a2: Cint): Cstring{.cdecl, 
    importc: "rl_untranslate_keyseq", dynlib: readlineDll.}
proc namedFunction*(a2: Cstring): TcommandFunc{.cdecl, 
    importc: "rl_named_function", dynlib: readlineDll.}
proc functionOfKeyseq*(a2: Cstring, a3: PKeymap, a4: ptr Cint): TcommandFunc{.
    cdecl, importc: "rl_function_of_keyseq", dynlib: readlineDll.}
proc listFunmapNames*(){.cdecl, importc: "rl_list_funmap_names", 
                           dynlib: readlineDll.}
proc invokingKeyseqsInMap*(a2: TcommandFunc, a3: PKeymap): CstringArray{.
    cdecl, importc: "rl_invoking_keyseqs_in_map", dynlib: readlineDll.}
proc invokingKeyseqs*(a2: TcommandFunc): CstringArray{.cdecl, 
    importc: "rl_invoking_keyseqs", dynlib: readlineDll.}
proc functionDumper*(a2: Cint){.cdecl, importc: "rl_function_dumper", 
                                 dynlib: readlineDll.}
proc macroDumper*(a2: Cint){.cdecl, importc: "rl_macro_dumper", 
                              dynlib: readlineDll.}
proc variableDumper*(a2: Cint){.cdecl, importc: "rl_variable_dumper", 
                                 dynlib: readlineDll.}
proc readInitFile*(a2: Cstring): Cint{.cdecl, importc: "rl_read_init_file", 
    dynlib: readlineDll.}
proc parseAndBind*(a2: Cstring): Cint{.cdecl, importc: "rl_parse_and_bind", 
    dynlib: readlineDll.}

proc getKeymapName*(a2: PKeymap): Cstring{.cdecl, 
    importc: "rl_get_keymap_name", dynlib: readlineDll.}

proc setKeymapFromEditMode*(){.cdecl, 
                                   importc: "rl_set_keymap_from_edit_mode", 
                                   dynlib: readlineDll.}
proc getKeymapNameFromEditMode*(): Cstring{.cdecl, 
    importc: "rl_get_keymap_name_from_edit_mode", dynlib: readlineDll.}
# Functions for manipulating the funmap, which maps command names to functions. 

proc addFunmapEntry*(a2: Cstring, a3: TcommandFunc): Cint{.cdecl, 
    importc: "rl_add_funmap_entry", dynlib: readlineDll.}
proc funmapNames*(): CstringArray{.cdecl, importc: "rl_funmap_names", 
                                    dynlib: readlineDll.}
# Undocumented, only used internally -- there is only one funmap, and this
#   function may be called only once. 

proc initializeFunmap*(){.cdecl, importc: "rl_initialize_funmap", 
                           dynlib: readlineDll.}
# Utility functions for managing keyboard macros. 

proc pushMacroInput*(a2: Cstring){.cdecl, importc: "rl_push_macro_input", 
                                     dynlib: readlineDll.}
# Functions for undoing, from undo.c 

proc addUndo*(a2: TundoCode, a3: Cint, a4: Cint, a5: Cstring){.cdecl, 
    importc: "rl_add_undo", dynlib: readlineDll.}
proc freeUndoList*(){.cdecl, importc: "rl_free_undo_list", dynlib: readlineDll.}
proc doUndo*(): Cint{.cdecl, importc: "rl_do_undo", dynlib: readlineDll.}
proc beginUndoGroup*(): Cint{.cdecl, importc: "rl_begin_undo_group", 
                                dynlib: readlineDll.}
proc endUndoGroup*(): Cint{.cdecl, importc: "rl_end_undo_group", 
                              dynlib: readlineDll.}
proc modifying*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_modifying", 
    dynlib: readlineDll.}
# Functions for redisplay. 

proc redisplay*(){.cdecl, importc: "rl_redisplay", dynlib: readlineDll.}
proc onNewLine*(): Cint{.cdecl, importc: "rl_on_new_line", dynlib: readlineDll.}
proc onNewLineWithPrompt*(): Cint{.cdecl, 
                                       importc: "rl_on_new_line_with_prompt", 
                                       dynlib: readlineDll.}
proc forcedUpdateDisplay*(): Cint{.cdecl, importc: "rl_forced_update_display", 
                                     dynlib: readlineDll.}
proc clearMessage*(): Cint{.cdecl, importc: "rl_clear_message", 
                             dynlib: readlineDll.}
proc resetLineState*(): Cint{.cdecl, importc: "rl_reset_line_state", 
                                dynlib: readlineDll.}
proc crlf*(): Cint{.cdecl, importc: "rl_crlf", dynlib: readlineDll.}
proc message*(a2: Cstring): Cint{.varargs, cdecl, importc: "rl_message", 
                                  dynlib: readlineDll.}
proc showChar*(a2: Cint): Cint{.cdecl, importc: "rl_show_char", 
                                 dynlib: readlineDll.}
# Undocumented in texinfo manual. 

proc characterLen*(a2: Cint, a3: Cint): Cint{.cdecl, 
    importc: "rl_character_len", dynlib: readlineDll.}
# Save and restore internal prompt redisplay information. 

proc savePrompt*(){.cdecl, importc: "rl_save_prompt", dynlib: readlineDll.}
proc restorePrompt*(){.cdecl, importc: "rl_restore_prompt", dynlib: readlineDll.}
# Modifying text. 

proc replaceLine*(a2: Cstring, a3: Cint){.cdecl, importc: "rl_replace_line", 
    dynlib: readlineDll.}
proc insertText*(a2: Cstring): Cint{.cdecl, importc: "rl_insert_text", 
                                      dynlib: readlineDll.}
proc deleteText*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_delete_text", 
    dynlib: readlineDll.}
proc killText*(a2: Cint, a3: Cint): Cint{.cdecl, importc: "rl_kill_text", 
    dynlib: readlineDll.}
proc copyText*(a2: Cint, a3: Cint): Cstring{.cdecl, importc: "rl_copy_text", 
    dynlib: readlineDll.}
# Terminal and tty mode management. 

proc prepTerminal*(a2: Cint){.cdecl, importc: "rl_prep_terminal", 
                               dynlib: readlineDll.}
proc deprepTerminal*(){.cdecl, importc: "rl_deprep_terminal", 
                         dynlib: readlineDll.}
proc ttySetDefaultBindings*(a2: PKeymap){.cdecl, 
    importc: "rl_tty_set_default_bindings", dynlib: readlineDll.}
proc ttyUnsetDefaultBindings*(a2: PKeymap){.cdecl, 
    importc: "rl_tty_unset_default_bindings", dynlib: readlineDll.}
proc resetTerminal*(a2: Cstring): Cint{.cdecl, importc: "rl_reset_terminal", 
    dynlib: readlineDll.}
proc resizeTerminal*(){.cdecl, importc: "rl_resize_terminal", 
                         dynlib: readlineDll.}
proc setScreenSize*(a2: Cint, a3: Cint){.cdecl, importc: "rl_set_screen_size", 
    dynlib: readlineDll.}
proc getScreenSize*(a2: ptr Cint, a3: ptr Cint){.cdecl, 
    importc: "rl_get_screen_size", dynlib: readlineDll.}
proc resetScreenSize*(){.cdecl, importc: "rl_reset_screen_size", 
                           dynlib: readlineDll.}
proc getTermcap*(a2: Cstring): Cstring{.cdecl, importc: "rl_get_termcap", 
    dynlib: readlineDll.}
# Functions for character input. 

proc stuffChar*(a2: Cint): Cint{.cdecl, importc: "rl_stuff_char", 
                                  dynlib: readlineDll.}
proc executeNext*(a2: Cint): Cint{.cdecl, importc: "rl_execute_next", 
                                    dynlib: readlineDll.}
proc clearPendingInput*(): Cint{.cdecl, importc: "rl_clear_pending_input", 
                                   dynlib: readlineDll.}
proc readKey*(): Cint{.cdecl, importc: "rl_read_key", dynlib: readlineDll.}
proc getc*(a2: TFile): Cint{.cdecl, importc: "rl_getc", dynlib: readlineDll.}
proc setKeyboardInputTimeout*(a2: Cint): Cint{.cdecl, 
    importc: "rl_set_keyboard_input_timeout", dynlib: readlineDll.}
# `Public' utility functions . 

proc extendLineBuffer*(a2: Cint){.cdecl, importc: "rl_extend_line_buffer", 
                                    dynlib: readlineDll.}
proc ding*(): Cint{.cdecl, importc: "rl_ding", dynlib: readlineDll.}
proc alphabetic*(a2: Cint): Cint{.cdecl, importc: "rl_alphabetic", 
                                  dynlib: readlineDll.}
proc free*(a2: Pointer){.cdecl, importc: "rl_free", dynlib: readlineDll.}
# Readline signal handling, from signals.c 

proc setSignals*(): Cint{.cdecl, importc: "rl_set_signals", dynlib: readlineDll.}
proc clearSignals*(): Cint{.cdecl, importc: "rl_clear_signals", 
                             dynlib: readlineDll.}
proc cleanupAfterSignal*(){.cdecl, importc: "rl_cleanup_after_signal", 
                              dynlib: readlineDll.}
proc resetAfterSignal*(){.cdecl, importc: "rl_reset_after_signal", 
                            dynlib: readlineDll.}
proc freeLineState*(){.cdecl, importc: "rl_free_line_state", 
                         dynlib: readlineDll.}
proc echoSignalChar*(a2: Cint){.cdecl, importc: "rl_echo_signal_char", 
                                  dynlib: readlineDll.}
proc setParenBlinkTimeout*(a2: Cint): Cint{.cdecl, 
    importc: "rl_set_paren_blink_timeout", dynlib: readlineDll.}
# Undocumented. 

proc maybeSaveLine*(): Cint{.cdecl, importc: "rl_maybe_save_line", 
                               dynlib: readlineDll.}
proc maybeUnsaveLine*(): Cint{.cdecl, importc: "rl_maybe_unsave_line", 
                                 dynlib: readlineDll.}
proc maybeReplaceLine*(): Cint{.cdecl, importc: "rl_maybe_replace_line", 
                                  dynlib: readlineDll.}
# Completion functions. 

proc completeInternal*(a2: Cint): Cint{.cdecl, importc: "rl_complete_internal", 
    dynlib: readlineDll.}
proc displayMatchList*(a2: CstringArray, a3: Cint, a4: Cint){.cdecl, 
    importc: "rl_display_match_list", dynlib: readlineDll.}
proc completionMatches*(a2: Cstring, a3: TcompentryFunc): CstringArray{.
    cdecl, importc: "rl_completion_matches", dynlib: readlineDll.}
proc usernameCompletionFunction*(a2: Cstring, a3: Cint): Cstring{.cdecl, 
    importc: "rl_username_completion_function", dynlib: readlineDll.}
proc filenameCompletionFunction*(a2: Cstring, a3: Cint): Cstring{.cdecl, 
    importc: "rl_filename_completion_function", dynlib: readlineDll.}
proc completionMode*(a2: TcommandFunc): Cint{.cdecl, 
    importc: "rl_completion_mode", dynlib: readlineDll.}
# **************************************************************** 
#								    
#			Well Published Variables		    
#								    
# **************************************************************** 

when false: 
  # The version of this incarnation of the readline library. 
  var library_version*{.importc: "rl_library_version", dynlib: readlineDll.}: cstring
  # e.g., "4.2" 
  var readline_version*{.importc: "rl_readline_version", dynlib: readlineDll.}: cint
  # e.g., 0x0402 
  # True if this is real GNU readline. 
  var gnu_readline_p*{.importc: "rl_gnu_readline_p", dynlib: readlineDll.}: cint
  # Flags word encapsulating the current readline state. 
  var readline_state*{.importc: "rl_readline_state", dynlib: readlineDll.}: cint
  # Says which editing mode readline is currently using.  1 means emacs mode;
  #   0 means vi mode. 
  var editing_mode*{.importc: "rl_editing_mode", dynlib: readlineDll.}: cint
  # Insert or overwrite mode for emacs mode.  1 means insert mode; 0 means
  #   overwrite mode.  Reset to insert mode on each input line. 
  var insert_mode*{.importc: "rl_insert_mode", dynlib: readlineDll.}: cint
  # The name of the calling program.  You should initialize this to
  #   whatever was in argv[0].  It is used when parsing conditionals. 
  var readline_name*{.importc: "rl_readline_name", dynlib: readlineDll.}: cstring
  # The prompt readline uses.  This is set from the argument to
  #   readline (), and should not be assigned to directly. 
  var prompt*{.importc: "rl_prompt", dynlib: readlineDll.}: cstring
  # The prompt string that is actually displayed by rl_redisplay.  Public so
  #   applications can more easily supply their own redisplay functions. 
  var display_prompt*{.importc: "rl_display_prompt", dynlib: readlineDll.}: cstring
  # The line buffer that is in use. 
  var line_buffer*{.importc: "rl_line_buffer", dynlib: readlineDll.}: cstring
  # The location of point, and end. 
  var point*{.importc: "rl_point", dynlib: readlineDll.}: cint
  var theEnd*{.importc: "rl_end", dynlib: readlineDll.}: cint
  # The mark, or saved cursor position. 
  var mark*{.importc: "rl_mark", dynlib: readlineDll.}: cint
  # Flag to indicate that readline has finished with the current input
  #   line and should return it. 
  var done*{.importc: "rl_done", dynlib: readlineDll.}: cint
  # If set to a character value, that will be the next keystroke read. 
  var pending_input*{.importc: "rl_pending_input", dynlib: readlineDll.}: cint
  # Non-zero if we called this function from _rl_dispatch().  It's present
  #   so functions can find out whether they were called from a key binding
  #   or directly from an application. 
  var dispatching*{.importc: "rl_dispatching", dynlib: readlineDll.}: cint
  # Non-zero if the user typed a numeric argument before executing the
  #   current function. 
  var explicit_arg*{.importc: "rl_explicit_arg", dynlib: readlineDll.}: cint
  # The current value of the numeric argument specified by the user. 
  var numeric_arg*{.importc: "rl_numeric_arg", dynlib: readlineDll.}: cint
  # The address of the last command function Readline executed. 
  var last_func*{.importc: "rl_last_func", dynlib: readlineDll.}: TCommandFunc
  # The name of the terminal to use. 
  var terminal_name*{.importc: "rl_terminal_name", dynlib: readlineDll.}: cstring
  # The input and output streams. 
  var instream*{.importc: "rl_instream", dynlib: readlineDll.}: TFile
  var outstream*{.importc: "rl_outstream", dynlib: readlineDll.}: TFile
  # If non-zero, Readline gives values of LINES and COLUMNS from the environment
  #   greater precedence than values fetched from the kernel when computing the
  #   screen dimensions. 
  var prefer_env_winsize*{.importc: "rl_prefer_env_winsize", dynlib: readlineDll.}: cint
  # If non-zero, then this is the address of a function to call just
  #   before readline_internal () prints the first prompt. 
  var startup_hook*{.importc: "rl_startup_hook", dynlib: readlineDll.}:  hook_func
  # If non-zero, this is the address of a function to call just before
  #   readline_internal_setup () returns and readline_internal starts
  #   reading input characters. 
  var pre_input_hook*{.importc: "rl_pre_input_hook", dynlib: readlineDll.}: hook_func
  # The address of a function to call periodically while Readline is
  #   awaiting character input, or NULL, for no event handling. 
  var event_hook*{.importc: "rl_event_hook", dynlib: readlineDll.}: hook_func
  # The address of the function to call to fetch a character from the current
  #   Readline input stream 
  var getc_function*{.importc: "rl_getc_function", dynlib: readlineDll.}: getc_func
  var redisplay_function*{.importc: "rl_redisplay_function", dynlib: readlineDll.}: voidfunc
  var prep_term_function*{.importc: "rl_prep_term_function", dynlib: readlineDll.}: vintfunc
  var deprep_term_function*{.importc: "rl_deprep_term_function", 
                             dynlib: readlineDll.}: voidfunc
  # Dispatch variables. 
  var executing_keymap*{.importc: "rl_executing_keymap", dynlib: readlineDll.}: PKeymap
  var binding_keymap*{.importc: "rl_binding_keymap", dynlib: readlineDll.}: PKeymap
  # Display variables. 
  # If non-zero, readline will erase the entire line, including any prompt,
  #   if the only thing typed on an otherwise-blank line is something bound to
  #   rl_newline. 
  var erase_empty_line*{.importc: "rl_erase_empty_line", dynlib: readlineDll.}: cint
  # If non-zero, the application has already printed the prompt (rl_prompt)
  #   before calling readline, so readline should not output it the first time
  #   redisplay is done. 
  var already_prompted*{.importc: "rl_already_prompted", dynlib: readlineDll.}: cint
  # A non-zero value means to read only this many characters rather than
  #   up to a character bound to accept-line. 
  var num_chars_to_read*{.importc: "rl_num_chars_to_read", dynlib: readlineDll.}: cint
  # The text of a currently-executing keyboard macro. 
  var executing_macro*{.importc: "rl_executing_macro", dynlib: readlineDll.}: cstring
  # Variables to control readline signal handling. 
  # If non-zero, readline will install its own signal handlers for
  #   SIGINT, SIGTERM, SIGQUIT, SIGALRM, SIGTSTP, SIGTTIN, and SIGTTOU. 
  var catch_signals*{.importc: "rl_catch_signals", dynlib: readlineDll.}: cint
  # If non-zero, readline will install a signal handler for SIGWINCH
  #   that also attempts to call any calling application's SIGWINCH signal
  #   handler.  Note that the terminal is not cleaned up before the
  #   application's signal handler is called; use rl_cleanup_after_signal()
  #   to do that. 
  var catch_sigwinch*{.importc: "rl_catch_sigwinch", dynlib: readlineDll.}: cint
  # Completion variables. 
  # Pointer to the generator function for completion_matches ().
  #   NULL means to use rl_filename_completion_function (), the default
  #   filename completer. 
  var completion_entry_function*{.importc: "rl_completion_entry_function", 
                                  dynlib: readlineDll.}: compentry_func
  # Optional generator for menu completion.  Default is
  #   rl_completion_entry_function (rl_filename_completion_function). 
  var menu_completion_entry_function*{.importc: "rl_menu_completion_entry_function", 
                                       dynlib: readlineDll.}: compentry_func
  # If rl_ignore_some_completions_function is non-NULL it is the address
  #   of a function to call after all of the possible matches have been
  #   generated, but before the actual completion is done to the input line.
  #   The function is called with one argument; a NULL terminated array
  #   of (char *).  If your function removes any of the elements, they
  #   must be free()'ed. 
  var ignore_some_completions_function*{.
      importc: "rl_ignore_some_completions_function", dynlib: readlineDll.}: compignore_func
  # Pointer to alternative function to create matches.
  #   Function is called with TEXT, START, and END.
  #   START and END are indices in RL_LINE_BUFFER saying what the boundaries
  #   of TEXT are.
  #   If this function exists and returns NULL then call the value of
  #   rl_completion_entry_function to try to match, otherwise use the
  #   array of strings returned. 
  var attempted_completion_function*{.importc: "rl_attempted_completion_function", 
                                      dynlib: readlineDll.}: completion_func
  # The basic list of characters that signal a break between words for the
  #   completer routine.  The initial contents of this variable is what
  #   breaks words in the shell, i.e. "n\"\\'`@$>". 
  var basic_word_break_characters*{.importc: "rl_basic_word_break_characters", 
                                    dynlib: readlineDll.}: cstring
  # The list of characters that signal a break between words for
  #   rl_complete_internal.  The default list is the contents of
  #   rl_basic_word_break_characters.  
  var completer_word_break_characters*{.importc: "rl_completer_word_break_characters", 
                                        dynlib: readlineDll.}: cstring
  # Hook function to allow an application to set the completion word
  #   break characters before readline breaks up the line.  Allows
  #   position-dependent word break characters. 
  var completion_word_break_hook*{.importc: "rl_completion_word_break_hook", 
                                   dynlib: readlineDll.}: cpvfunc
  # List of characters which can be used to quote a substring of the line.
  #   Completion occurs on the entire substring, and within the substring   
  #   rl_completer_word_break_characters are treated as any other character,
  #   unless they also appear within this list. 
  var completer_quote_characters*{.importc: "rl_completer_quote_characters", 
                                   dynlib: readlineDll.}: cstring
  # List of quote characters which cause a word break. 
  var basic_quote_characters*{.importc: "rl_basic_quote_characters", 
                               dynlib: readlineDll.}: cstring
  # List of characters that need to be quoted in filenames by the completer. 
  var filename_quote_characters*{.importc: "rl_filename_quote_characters", 
                                  dynlib: readlineDll.}: cstring
  # List of characters that are word break characters, but should be left
  #   in TEXT when it is passed to the completion function.  The shell uses
  #   this to help determine what kind of completing to do. 
  var special_prefixes*{.importc: "rl_special_prefixes", dynlib: readlineDll.}: cstring
  # If non-zero, then this is the address of a function to call when
  #   completing on a directory name.  The function is called with
  #   the address of a string (the current directory name) as an arg.  It
  #   changes what is displayed when the possible completions are printed
  #   or inserted. 
  var directory_completion_hook*{.importc: "rl_directory_completion_hook", 
                                  dynlib: readlineDll.}: icppfunc
  # If non-zero, this is the address of a function to call when completing
  #   a directory name.  This function takes the address of the directory name
  #   to be modified as an argument.  Unlike rl_directory_completion_hook, it
  #   only modifies the directory name used in opendir(2), not what is displayed
  #   when the possible completions are printed or inserted.  It is called
  #   before rl_directory_completion_hook.  I'm not happy with how this works
  #   yet, so it's undocumented. 
  var directory_rewrite_hook*{.importc: "rl_directory_rewrite_hook", 
                               dynlib: readlineDll.}: icppfunc
  # If non-zero, this is the address of a function to call when reading
  #   directory entries from the filesystem for completion and comparing
  #   them to the partial word to be completed.  The function should
  #   either return its first argument (if no conversion takes place) or
  #   newly-allocated memory.  This can, for instance, convert filenames
  #   between character sets for comparison against what's typed at the
  #   keyboard.  The returned value is what is added to the list of
  #   matches.  The second argument is the length of the filename to be
  #   converted. 
  var filename_rewrite_hook*{.importc: "rl_filename_rewrite_hook", 
                              dynlib: readlineDll.}: dequote_func
  # If non-zero, then this is the address of a function to call when
  #   completing a word would normally display the list of possible matches.
  #   This function is called instead of actually doing the display.
  #   It takes three arguments: (char **matches, int num_matches, int max_length)
  #   where MATCHES is the array of strings that matched, NUM_MATCHES is the
  #   number of strings in that array, and MAX_LENGTH is the length of the
  #   longest string in that array. 
  var completion_display_matches_hook*{.importc: "rl_completion_display_matches_hook", 
                                        dynlib: readlineDll.}: compdisp_func
  # Non-zero means that the results of the matches are to be treated
  #   as filenames.  This is ALWAYS zero on entry, and can only be changed
  #   within a completion entry finder function. 
  var filename_completion_desired*{.importc: "rl_filename_completion_desired", 
                                    dynlib: readlineDll.}: cint
  # Non-zero means that the results of the matches are to be quoted using
  #   double quotes (or an application-specific quoting mechanism) if the
  #   filename contains any characters in rl_word_break_chars.  This is
  #   ALWAYS non-zero on entry, and can only be changed within a completion
  #   entry finder function. 
  var filename_quoting_desired*{.importc: "rl_filename_quoting_desired", 
                                 dynlib: readlineDll.}: cint
  # Set to a function to quote a filename in an application-specific fashion.
  #   Called with the text to quote, the type of match found (single or multiple)
  #   and a pointer to the quoting character to be used, which the function can
  #   reset if desired. 
  var filename_quoting_function*{.importc: "rl_filename_quoting_function", 
                                  dynlib: readlineDll.}: quote_func
  # Function to call to remove quoting characters from a filename.  Called
  #   before completion is attempted, so the embedded quotes do not interfere
  #   with matching names in the file system. 
  var filename_dequoting_function*{.importc: "rl_filename_dequoting_function", 
                                    dynlib: readlineDll.}: dequote_func
  # Function to call to decide whether or not a word break character is
  #   quoted.  If a character is quoted, it does not break words for the
  #   completer. 
  var char_is_quoted_p*{.importc: "rl_char_is_quoted_p", dynlib: readlineDll.}: linebuf_func
  # Non-zero means to suppress normal filename completion after the
  #   user-specified completion function has been called. 
  var attempted_completion_over*{.importc: "rl_attempted_completion_over", 
                                  dynlib: readlineDll.}: cint
  # Set to a character describing the type of completion being attempted by
  #   rl_complete_internal; available for use by application completion
  #   functions. 
  var completion_type*{.importc: "rl_completion_type", dynlib: readlineDll.}: cint
  # Set to the last key used to invoke one of the completion functions 
  var completion_invoking_key*{.importc: "rl_completion_invoking_key", 
                                dynlib: readlineDll.}: cint
  # Up to this many items will be displayed in response to a
  #   possible-completions call.  After that, we ask the user if she
  #   is sure she wants to see them all.  The default value is 100. 
  var completion_query_items*{.importc: "rl_completion_query_items", 
                               dynlib: readlineDll.}: cint
  # Character appended to completed words when at the end of the line.  The
  #   default is a space.  Nothing is added if this is '\0'. 
  var completion_append_character*{.importc: "rl_completion_append_character", 
                                    dynlib: readlineDll.}: cint
  # If set to non-zero by an application completion function,
  #   rl_completion_append_character will not be appended. 
  var completion_suppress_append*{.importc: "rl_completion_suppress_append", 
                                   dynlib: readlineDll.}: cint
  # Set to any quote character readline thinks it finds before any application
  #   completion function is called. 
  var completion_quote_character*{.importc: "rl_completion_quote_character", 
                                   dynlib: readlineDll.}: cint
  # Set to a non-zero value if readline found quoting anywhere in the word to
  #   be completed; set before any application completion function is called. 
  var completion_found_quote*{.importc: "rl_completion_found_quote", 
                               dynlib: readlineDll.}: cint
  # If non-zero, the completion functions don't append any closing quote.
  #   This is set to 0 by rl_complete_internal and may be changed by an
  #   application-specific completion function. 
  var completion_suppress_quote*{.importc: "rl_completion_suppress_quote", 
                                  dynlib: readlineDll.}: cint
  # If non-zero, readline will sort the completion matches.  On by default. 
  var sort_completion_matches*{.importc: "rl_sort_completion_matches", 
                                dynlib: readlineDll.}: cint
  # If non-zero, a slash will be appended to completed filenames that are
  #   symbolic links to directory names, subject to the value of the
  #   mark-directories variable (which is user-settable).  This exists so
  #   that application completion functions can override the user's preference
  #   (set via the mark-symlinked-directories variable) if appropriate.
  #   It's set to the value of _rl_complete_mark_symlink_dirs in
  #   rl_complete_internal before any application-specific completion
  #   function is called, so without that function doing anything, the user's
  #   preferences are honored. 
  var completion_mark_symlink_dirs*{.importc: "rl_completion_mark_symlink_dirs", 
                                     dynlib: readlineDll.}: cint
  # If non-zero, then disallow duplicates in the matches. 
  var ignore_completion_duplicates*{.importc: "rl_ignore_completion_duplicates", 
                                     dynlib: readlineDll.}: cint
  # If this is non-zero, completion is (temporarily) inhibited, and the
  #   completion character will be inserted as any other. 
  var inhibit_completion*{.importc: "rl_inhibit_completion", dynlib: readlineDll.}: cint
# Input error; can be returned by (*rl_getc_function) if readline is reading
#   a top-level command (RL_ISSTATE (RL_STATE_READCMD)). 

const 
  Readerr* = (- 2)

# Definitions available for use by readline clients. 

const 
  PromptStartIgnore* = '\x01'
  PromptEndIgnore* = '\x02'

# Possible values for do_replace argument to rl_filename_quoting_function,
#   called by rl_complete_internal. 

const 
  NoMatch* = 0
  SingleMatch* = 1
  MultMatch* = 2

# Possible state values for rl_readline_state 

const 
  StateNone* = 0x00000000    # no state; before first call 
  StateInitializing* = 0x00000001 # initializing 
  StateInitialized* = 0x00000002 # initialization done 
  StateTermprepped* = 0x00000004 # terminal is prepped 
  StateReadcmd* = 0x00000008 # reading a command key 
  StateMetanext* = 0x00000010 # reading input after ESC 
  StateDispatching* = 0x00000020 # dispatching to a command 
  StateMoreinput* = 0x00000040 # reading more input in a command function 
  StateIsearch* = 0x00000080 # doing incremental search 
  StateNsearch* = 0x00000100 # doing non-inc search 
  StateSearch* = 0x00000200  # doing a history search 
  StateNumericarg* = 0x00000400 # reading numeric argument 
  StateMacroinput* = 0x00000800 # getting input from a macro 
  StateMacrodef* = 0x00001000 # defining keyboard macro 
  StateOverwrite* = 0x00002000 # overwrite mode 
  StateCompleting* = 0x00004000 # doing completion 
  StateSighandler* = 0x00008000 # in readline sighandler 
  StateUndoing* = 0x00010000 # doing an undo 
  StateInputpending* = 0x00020000 # rl_execute_next called 
  StateTtycsaved* = 0x00040000 # tty special chars saved 
  StateCallback* = 0x00080000 # using the callback interface 
  StateVimotion* = 0x00100000 # reading vi motion arg 
  StateMultikey* = 0x00200000 # reading multiple-key command 
  StateVicmdonce* = 0x00400000 # entered vi command mode at least once 
  StateRedisplaying* = 0x00800000 # updating terminal display 
  StateDone* = 0x01000000    # done; accepted line 

template setstate*(x: Expr): Stmt = 
  readline_state = readline_state or (x)

template unsetstate*(x: Expr): Stmt = 
  readline_state = readline_state and not (x)

template isstate*(x: Expr): Expr = 
  (readline_state and x) != 0

type 
  TreadlineState*{.pure, final.} = object 
    point*: Cint              # line state 
    theEnd*: Cint
    mark*: Cint
    buffer*: Cstring
    buflen*: Cint
    ul*: ptr TUNDO_LIST
    prompt*: Cstring          # global state 
    rlstate*: Cint
    done*: Cint
    kmap*: PKeymap            # input state 
    lastfunc*: TcommandFunc
    insmode*: Cint
    edmode*: Cint
    kseqlen*: Cint
    inf*: TFile
    outf*: TFile
    pendingin*: Cint
    theMacro*: Cstring        # signal state 
    catchsigs*: Cint
    catchsigwinch*: Cint      # search state 
                              # completion state 
                              # options state 
                              # reserved for future expansion, so the struct size doesn't change 
    reserved*: Array[0..64 - 1, Char]


proc saveState*(a2: ptr TreadlineState): Cint{.cdecl, 
    importc: "rl_save_state", dynlib: readlineDll.}
proc restoreState*(a2: ptr TreadlineState): Cint{.cdecl, 
    importc: "rl_restore_state", dynlib: readlineDll.}
