#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#


# simple integer arithmetic with overflow checking

proc raiseOverflow {.compilerproc, noinline, noreturn.} =
  # a single proc to reduce code size to a minimum
  sysFatal(EOverflow, "over- or underflow")

proc raiseDivByZero {.compilerproc, noinline, noreturn.} =
  sysFatal(EDivByZero, "divison by zero")

proc addInt64(a, b: Int64): Int64 {.compilerProc, inline.} =
  result = a +% b
  if (result xor a) >= Int64(0) or (result xor b) >= Int64(0):
    return result
  raiseOverflow()

proc subInt64(a, b: Int64): Int64 {.compilerProc, inline.} =
  result = a -% b
  if (result xor a) >= Int64(0) or (result xor not b) >= Int64(0):
    return result
  raiseOverflow()

proc negInt64(a: Int64): Int64 {.compilerProc, inline.} =
  if a != low(Int64): return -a
  raiseOverflow()

proc absInt64(a: Int64): Int64 {.compilerProc, inline.} =
  if a != low(Int64):
    if a >= 0: return a
    else: return -a
  raiseOverflow()

proc divInt64(a, b: Int64): Int64 {.compilerProc, inline.} =
  if b == Int64(0):
    raiseDivByZero()
  if a == low(Int64) and b == Int64(-1):
    raiseOverflow()
  return a div b

proc modInt64(a, b: Int64): Int64 {.compilerProc, inline.} =
  if b == Int64(0):
    raiseDivByZero()
  return a mod b

#
# This code has been inspired by Python's source code.
# The native int product x*y is either exactly right or *way* off, being
# just the last n bits of the true product, where n is the number of bits
# in an int (the delivered product is the true product plus i*2**n for
# some integer i).
#
# The native float64 product x*y is subject to three
# rounding errors: on a sizeof(int)==8 box, each cast to double can lose
# info, and even on a sizeof(int)==4 box, the multiplication can lose info.
# But, unlike the native int product, it's not in *range* trouble:  even
# if sizeof(int)==32 (256-bit ints), the product easily fits in the
# dynamic range of a float64. So the leading 50 (or so) bits of the float64
# product are correct.
#
# We check these two ways against each other, and declare victory if they're
# approximately the same. Else, because the native int product is the only
# one that can lose catastrophic amounts of information, it's the native int
# product that must have overflowed.
#
proc mulInt64(a, b: Int64): Int64 {.compilerproc.} =
  var
    resAsFloat, floatProd: Float64
  result = a *% b
  floatProd = toBiggestFloat(a) # conversion
  floatProd = floatProd * toBiggestFloat(b)
  resAsFloat = toBiggestFloat(result)

  # Fast path for normal case: small multiplicands, and no info
  # is lost in either method.
  if resAsFloat == floatProd: return result

  # Somebody somewhere lost info. Close enough, or way off? Note
  # that a != 0 and b != 0 (else resAsFloat == floatProd == 0).
  # The difference either is or isn't significant compared to the
  # true value (of which floatProd is a good approximation).

  # abs(diff)/abs(prod) <= 1/32 iff
  #   32 * abs(diff) <= abs(prod) -- 5 good bits is "close enough"
  if 32.0 * abs(resAsFloat - floatProd) <= abs(floatProd):
    return result
  raiseOverflow()


proc absInt(a: Int): Int {.compilerProc, inline.} =
  if a != low(Int):
    if a >= 0: return a
    else: return -a
  raiseOverflow()

const
  asmVersion = defined(I386) and (defined(vcc) or defined(wcc) or
               defined(dmc) or defined(gcc) or defined(llvm_gcc))
    # my Version of Borland C++Builder does not have
    # tasm32, which is needed for assembler blocks
    # this is why Borland is not included in the 'when'

when asmVersion and not defined(gcc) and not defined(llvm_gcc):
  # assembler optimized versions for compilers that
  # have an intel syntax assembler:
  proc addInt(a, b: int): int {.compilerProc, noStackFrame.} =
    # a in eax, and b in edx
    asm """
        mov eax, `a`
        add eax, `b`
        jno theEnd
        call `raiseOverflow`
      theEnd:
    """

  proc subInt(a, b: int): int {.compilerProc, noStackFrame.} =
    asm """
        mov eax, `a`
        sub eax, `b`
        jno theEnd
        call `raiseOverflow`
      theEnd:
    """

  proc negInt(a: int): int {.compilerProc, noStackFrame.} =
    asm """
        mov eax, `a`
        neg eax
        jno theEnd
        call `raiseOverflow`
      theEnd:
    """

  proc divInt(a, b: int): int {.compilerProc, noStackFrame.} =
    asm """
        mov eax, `a`
        mov ecx, `b`
        xor edx, edx
        idiv ecx
        jno  theEnd
        call `raiseOverflow`
      theEnd:
    """

  proc modInt(a, b: int): int {.compilerProc, noStackFrame.} =
    asm """
        mov eax, `a`
        mov ecx, `b`
        xor edx, edx
        idiv ecx
        jno theEnd
        call `raiseOverflow`
      theEnd:
        mov eax, edx
    """

  proc mulInt(a, b: int): int {.compilerProc, noStackFrame.} =
    asm """
        mov eax, `a`
        mov ecx, `b`
        xor edx, edx
        imul ecx
        jno theEnd
        call `raiseOverflow`
      theEnd:
    """

elif false: # asmVersion and (defined(gcc) or defined(llvm_gcc)):
  proc addInt(a, b: int): int {.compilerProc, inline.} =
    # don't use a pure proc here!
    asm """
      "addl %%ecx, %%eax\n"
      "jno 1\n"
      "call _raiseOverflow\n"
      "1: \n"
      :"=a"(`result`)
      :"a"(`a`), "c"(`b`)
    """
    #".intel_syntax noprefix"
    #/* Intel syntax here */
    #".att_syntax"

  proc subInt(a, b: int): int {.compilerProc, inline.} =
    asm """ "subl %%ecx,%%eax\n"
            "jno 1\n"
            "call _raiseOverflow\n"
            "1: \n"
           :"=a"(`result`)
           :"a"(`a`), "c"(`b`)
    """

  proc mulInt(a, b: int): int {.compilerProc, inline.} =
    asm """  "xorl %%edx, %%edx\n"
             "imull %%ecx\n"
             "jno 1\n"
             "call _raiseOverflow\n"
             "1: \n"
            :"=a"(`result`)
            :"a"(`a`), "c"(`b`)
            :"%edx"
    """

  proc negInt(a: int): int {.compilerProc, inline.} =
    asm """ "negl %%eax\n"
            "jno 1\n"
            "call _raiseOverflow\n"
            "1: \n"
           :"=a"(`result`)
           :"a"(`a`)
    """

  proc divInt(a, b: int): int {.compilerProc, inline.} =
    asm """  "xorl %%edx, %%edx\n"
             "idivl %%ecx\n"
             "jno 1\n"
             "call _raiseOverflow\n"
             "1: \n"
            :"=a"(`result`)
            :"a"(`a`), "c"(`b`)
            :"%edx"
    """

  proc modInt(a, b: int): int {.compilerProc, inline.} =
    asm """  "xorl %%edx, %%edx\n"
             "idivl %%ecx\n"
             "jno 1\n"
             "call _raiseOverflow\n"
             "1: \n"
             "movl %%edx, %%eax"
            :"=a"(`result`)
            :"a"(`a`), "c"(`b`)
            :"%edx"
    """

# Platform independent versions of the above (slower!)
when not defined(addInt):
  proc addInt(a, b: Int): Int {.compilerProc, inline.} =
    result = a +% b
    if (result xor a) >= 0 or (result xor b) >= 0:
      return result
    raiseOverflow()

when not defined(subInt):
  proc subInt(a, b: Int): Int {.compilerProc, inline.} =
    result = a -% b
    if (result xor a) >= 0 or (result xor not b) >= 0:
      return result
    raiseOverflow()

when not defined(negInt):
  proc negInt(a: Int): Int {.compilerProc, inline.} =
    if a != low(Int): return -a
    raiseOverflow()

when not defined(divInt):
  proc divInt(a, b: Int): Int {.compilerProc, inline.} =
    if b == 0:
      raiseDivByZero()
    if a == low(Int) and b == -1:
      raiseOverflow()
    return a div b

when not defined(modInt):
  proc modInt(a, b: Int): Int {.compilerProc, inline.} =
    if b == 0:
      raiseDivByZero()
    return a mod b

when not defined(mulInt):
  #
  # This code has been inspired by Python's source code.
  # The native int product x*y is either exactly right or *way* off, being
  # just the last n bits of the true product, where n is the number of bits
  # in an int (the delivered product is the true product plus i*2**n for
  # some integer i).
  #
  # The native float64 product x*y is subject to three
  # rounding errors: on a sizeof(int)==8 box, each cast to double can lose
  # info, and even on a sizeof(int)==4 box, the multiplication can lose info.
  # But, unlike the native int product, it's not in *range* trouble:  even
  # if sizeof(int)==32 (256-bit ints), the product easily fits in the
  # dynamic range of a float64. So the leading 50 (or so) bits of the float64
  # product are correct.
  #
  # We check these two ways against each other, and declare victory if
  # they're approximately the same. Else, because the native int product is
  # the only one that can lose catastrophic amounts of information, it's the
  # native int product that must have overflowed.
  #
  proc mulInt(a, b: Int): Int {.compilerProc.} =
    var
      resAsFloat, floatProd: Float

    result = a *% b
    floatProd = toFloat(a) * toFloat(b)
    resAsFloat = toFloat(result)

    # Fast path for normal case: small multiplicands, and no info
    # is lost in either method.
    if resAsFloat == floatProd: return result

    # Somebody somewhere lost info. Close enough, or way off? Note
    # that a != 0 and b != 0 (else resAsFloat == floatProd == 0).
    # The difference either is or isn't significant compared to the
    # true value (of which floatProd is a good approximation).

    # abs(diff)/abs(prod) <= 1/32 iff
    #   32 * abs(diff) <= abs(prod) -- 5 good bits is "close enough"
    if 32.0 * abs(resAsFloat - floatProd) <= abs(floatProd):
      return result
    raiseOverflow()

# We avoid setting the FPU control word here for compatibility with libraries
# written in other languages.

proc raiseFloatInvalidOp {.noinline, noreturn.} =
  sysFatal(EFloatInvalidOp, "FPU operation caused a NaN result")

proc nanCheck(x: Float64) {.compilerProc, inline.} =
  if x != x: raiseFloatInvalidOp()

proc raiseFloatOverflow(x: Float64) {.noinline, noreturn.} =
  if x > 0.0:
    sysFatal(EFloatOverflow, "FPU operation caused an overflow")
  else:
    sysFatal(EFloatUnderflow, "FPU operations caused an underflow")

proc infCheck(x: Float64) {.compilerProc, inline.} =
  if x != 0.0 and x*0.5 == x: raiseFloatOverflow(x)
