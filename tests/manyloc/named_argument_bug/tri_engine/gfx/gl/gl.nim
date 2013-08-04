import
  opengl,
  tri_engine/math/vec

export
  opengl

type
  Egl* = object of E_Base
  EGLCode* = object of Egl
    code*: EGLErr
  EGLErr {.pure.} = enum
    none                 = GL_NO_ERROR
    invalidEnum          = GL_INVALID_ENUM
    invalidVal           = GL_INVALID_VALUE
    invalidOp            = GL_INVALID_OPERATION
    stackOverflow        = GL_STACK_OVERFLOW
    stackUnderflow       = GL_STACK_UNDERFLOW
    outOfMem             = GL_OUT_OF_MEMORY
    invalidFramebufferOp = GL_INVALID_FRAMEBUFFER_OPERATION
    unknown

proc newGLCodeException*(msg: String, code: EGLErr): ref EGLCode =
  result      = newException(EGLCode, $code)
  result.code = code

proc getErr*(): EGLErr =
  result = glGetError().EGLErr
  if result notin {EGL_err.none,
                   EGL_err.invalidEnum,
                   EGL_err.invalidVal,
                   EGL_err.invalidOp,
                   EGL_err.invalidFramebufferOp,
                   EGL_err.outOfMem,
                   EGL_err.stackUnderflow,
                   EGL_err.stackOverflow}:
    return EGL_err.unknown

proc errCheck*() =
  let err = getErr()
  if err != EGL_err.none:
    raise newGLCodeException($err, err)

macro `?`*(call: Expr{nkCall}): Expr =
  result = call
  # Can't yet reference foreign symbols in macros.
  #errCheck()

when defined(doublePrecision):
  const
    glRealType* = cGLdouble
else:
  const
    glRealType* = cGLfloat

proc setUniformV4*[T](loc: GLint, vecs: var Openarray[TV4[T]]) =
  glUniform4fv(loc, vecs.len.GLsizei, cast[PGLfloat](vecs[0].addr))

proc setUniformV4*[T](loc: GLint, vec: TV4[T]) =
  var vecs = [vec]
  setUniformV4(loc, vecs)
