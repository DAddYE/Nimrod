proc quickSort(list: Seq[Int]): Seq[Int] =
    if len(list) == 0:
        return @[]
    var pivot = list[0]
    var left: Seq[Int] = @[]
    var right: Seq[Int] = @[]
    for i in low(list)..high(list):
        if list[i] < pivot:
            left.add(list[i])
        elif list[i] > pivot:
            right.add(list[i])
    result = quickSort(left) & 
      pivot & 
      quickSort(right)
    
proc echoSeq(a: Seq[Int]) =
    for i in low(a)..high(a):
        echo(a[i])

var
    list: Seq[Int]
        
list = quickSort(@[89,23,15,23,56,123,356,12,7,1,6,2,9,4,3])
echoSeq(list)


