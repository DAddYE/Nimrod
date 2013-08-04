type 
  Pa[T] = ref TA[T]
  TA[T] = object
    field: T
var a: Pa[String]
new(a)
a.field = "some string"

when false:
  # Compiles unless you use var a: PA[string]
  type 
    PA = ref TA
    TA[T] = object


  # Cannot instantiate:
  type 
    TA[T] = object
      a: PA[T]
    PA[T] = ref TA[T]

  type 
    PA[T] = ref TA[T]
    TA[T] = object


