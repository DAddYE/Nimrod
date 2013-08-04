# Test for a hard to fix internal error
# occured in the SDL library

{.push dynlib: "SDL.dll", callconv: cdecl.}

type
  PSDLSemaphore = ptr TSDL_semaphore
  TSDL_semaphore {.final.} = object
    sem: Pointer             #PSem_t;
    when not defined(USE_NAMED_SEMAPHORES):
      sem_data: Int
    when defined(BROKEN_SEMGETVALUE):
      # This is a little hack for MacOS X -
      # It's not thread-safe, but it's better than nothing
      sem_value: cint

type
  PSDLSem = ptr TSDL_Sem
  TSDL_Sem = TSDL_Semaphore

proc sDLCreateSemaphore(initial_value: Int32): PSDLSem {.
  importc: "SDL_CreateSemaphore".}
