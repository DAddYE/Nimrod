import
  pure/os,
  tri_engine/gfx/gl/gl

type
  TShader* = object
    id*: GL_handle
  TShaderType* {.pure.} = enum
    frag = GL_FRAGMENT_SHADER,
    vert   = GL_VERTEX_SHADER
  EShader* = object of E_Base
  EUnknownShaderType* = object of EShader

converter pathToShaderType*(s: String): TShaderType =
  case s.splitFile().ext:
  of ".vs":
    return TShaderType.vert
  of ".fs":
    return TShaderType.frag
  else:
    raise newException(EUnknownShaderType, "Can't determine shader type from file extension: " & s)

proc setSrc*(shader: TShader, src: String) =
  var s = src.Cstring
  ?glShaderSource(shader.id, 1, cast[cstringarray](s.addr), nil)

proc newShader*(id: GL_handle): TShader =
  if id != 0 and not (?glIsShader(id)).Bool:
    raise newException(eGl, "Invalid shader ID: " & $id)

  result.id = id

proc shaderInfoLog*(o: TShader): String =
  var log {.global.}: Array[0..1024, Char]
  var logLen: GLsizei
  ?glGetShaderInfoLog(o.id, log.len.GLsizei, logLen, cast[PGLchar](log.addr))
  cast[String](log.addr).substr(0, logLen)

proc compile*(shader: TShader, path="") =
  ?glCompileShader(shader.id)
  var compileStatus = 0.GLint
  ?glGetShaderIv(shader.id, GL_COMPILE_STATUS, compileStatus.addr)

  if compileStatus == 0:
    raise newException(eGl, if path.len == 0:
        shaderInfoLog(shader)
      else:
        path & ":\n" & shaderInfoLog(shader)
    )

proc newShaderFromSrc*(src: String, `type`: TShaderType): TShader =
  result.id = ?glCreateShader(`type`.GLenum)
  result.setSrc(src)
  result.compile()

proc newShaderFromFile*(path: String): TShader =
  newShaderFromSrc(readFile(path), path)

type
  TProgram* = object
    id*: GL_handle
    shaders: Seq[TShader]

proc attach*(o: TProgram, shader: TShader) =
  ?glAttachShader(o.id, shader.id)

proc infoLog*(o: TProgram): String =
  var log {.global.}: Array[0..1024, Char]
  var logLen: GLsizei
  ?glGetProgramInfoLog(o.id, log.len.GLsizei, logLen, cast[PGLchar](log.addr))
  cast[String](log.addr).substr(0, logLen)

proc link*(o: TProgram) =
  ?glLinkProgram(o.id)
  var linkStatus = 0.GLint
  ?glGetProgramIv(o.id, GL_LINK_STATUS, linkStatus.addr)
  if linkStatus == 0:
    raise newException(eGl, o.infoLog())

proc validate*(o: TProgram) =
  ?glValidateProgram(o.id)
  var validateStatus = 0.GLint
  ?glGetProgramIv(o.id, GL_VALIDATE_STATUS, validateStatus.addr)
  if validateStatus == 0:
    raise newException(eGl, o.infoLog())

proc newProgram*(shaders: Seq[TShader]): TProgram =
  result.id = ?glCreateProgram()
  if result.id == 0:
    return

  for shader in shaders:
    if shader.id == 0:
      return

    ?result.attach(shader)

  result.shaders = shaders
  result.link()
  result.validate()

proc use*(o: TProgram) =
  ?glUseProgram(o.id)
