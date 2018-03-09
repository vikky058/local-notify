import UIKit
print("hello")
func numberFactorial(value:Int) -> Int{
    if value == 0{
        return 1
    }
    print(value)
    return value * numberFactorial(value:value - 1)
}

numberFactorial(value: 5)


//let array = [1...5]
//for  i in (1...10).reversed(){
//    print(i)
//}

//for j in (1...5).reversed(){
//    for k in (1...j).reversed()
//    {
//        print("*",terminator:"")
//    }
//    print("\n")
// }

//for i in 1...5{
//    for j in 1...i{
//        print(" ",terminator:"")
//    }
//    for k in 1...6-i {
//        print("* ",terminator:"")
//    }
//    print("\n")
//}

//for j in stride(from: 5, to: 0, by: -1){
//    for k in (1...j).reversed()
//    {
//        print("*",terminator:"")
//    }
//    print("\n")
// }













