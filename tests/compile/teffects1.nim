
type
  PMenu = ref object
  PMenuItem = ref object

proc createMenuItem*(menu: PMenu, label: String, 
                     action: proc (i: PMenuItem, p: Pointer) {.cdecl.}) = nil

var s: PMenu
createMenuItem(s, "Go to definition...",
      proc (i: PMenuItem, p: Pointer) {.cdecl.} =
        try:
          echo(i.repr)
        except EInvalidValue:
          echo("blah")
)


proc noRaise(x: proc()) {.raises: [].} =
  # unknown call that might raise anything, but valid:
  x()
  
proc doRaise() {.raises: [Eio].} =
  raise newException(Eio, "IO")

proc use*() =
  noRaise(doRaise)
  # Here the compiler inferes that EIO can be raised.


use()
