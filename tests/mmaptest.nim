# Small test program to test for mmap() weirdnesses

include "lib/system/ansi_c"

const
  PageSize = 4096
  ProtRead  = 1             # page can be read 
  ProtWrite = 2             # page can be written 
  MapPrivate = 2            # Changes are private 

when defined(macosx) or defined(bsd):
  const MapAnonymous = 0x1000
elif defined(solaris): 
  const MAP_ANONYMOUS = 0x100
else:
  var
    MAP_ANONYMOUS {.importc: "MAP_ANONYMOUS", header: "<sys/mman.h>".}: cint
  
proc mmap(adr: Pointer, len: Int, prot, flags, fildes: Cint,
          off: Int): Pointer {.header: "<sys/mman.h>".}

proc munmap(adr: Pointer, len: Int) {.header: "<sys/mman.h>".}

proc osAllocPages(size: Int): Pointer {.inline.} = 
  result = mmap(nil, size, PROT_READ or PROT_WRITE, 
                         MAP_PRIVATE or MAP_ANONYMOUS, -1, 0)
  if result == nil or result == cast[Pointer](-1):
    quit 1
  cfprintf(c_stdout, "allocated pages %p..%p\n", result, 
                     cast[int](result) + size)
    
proc osDeallocPages(p: Pointer, size: Int) {.inline} =
  cfprintf(c_stdout, "freed pages %p..%p\n", p, cast[int](p) + size)
  munmap(p, size-1)

proc `+!!`(p: Pointer, size: Int): Pointer {.inline.} =
  result = cast[Pointer](cast[Int](p) + size)

var p = osAllocPages(3 * PageSize)

osDeallocPages(p, PageSize)
# If this fails the OS has freed the whole block starting at 'p':
echo(cast[ptr Int](p +!! (pageSize*2))[])

osDeallocPages(p +!! PageSize*2, PageSize)
osDeallocPages(p +!! PageSize, PageSize)


