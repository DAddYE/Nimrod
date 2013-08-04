discard """
  output: '''--- evens
2
4
6
8
--- squares
1
4
9
16
25
36
49
64
81
--- squares of evens, only
4
16
36
64'''
"""

iterator `/`[T](sequence: Seq[T],
                filter: proc(e:T):Bool {.closure.}) : T =
    for element in sequence:
        if (filter(element)):
            yield element

iterator `>>`[I,O](sequence: Seq[I],
                   map: proc(e:I):O {.closure.}) : O =
    for element in sequence:
        yield map(element)

iterator `/>>`[I,O](sequence: Seq[I],
                    filtermap:tuple[
                        f:proc(e:I):Bool {.closure.},
                        m:proc(e:I):O {.closure.}]) : O =
    for element in sequence:
        if (filtermap.f(element)):
            yield filtermap.m(element)

proc isEven(x:Int): Bool {.closure.} = result =
    (x and 1) == 0

proc square(x:Int): Int {.closure.} = result =
    x * x

let list = @[1,2,3,4,5,6,7,8,9]

echo ("--- evens")
for item in list / isEven : echo(item)
echo ("--- squares")
for item in list >> square : echo(item)
echo ("--- squares of evens, only")
# next line doesn't compile. Generic types are not inferred
for item in list />> (isEven, square) : echo(item)
