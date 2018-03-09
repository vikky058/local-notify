import UIKit

let twoIntizer:(num1:Int,num2:Int) = (10,20)
twoIntizer.num1
twoIntizer.num2

let(a1,a2) = twoIntizer
a1
a2

let (p1,_) = twoIntizer
p1


firstloop: for i in 0...15{
    
    print("firstloop \(i)")
   
    secondloop: for j in 0...10{
        print("second loop \(j)")
    }
}

Newloop: for i in 0...15{
    
    print("firstloop \(i)")
    
    oldloop: for j in 0...10{
        if j == 5{
            //continue Newloop
            break
        }
        print("old loop \(j)")
    }
}


func number(num1:Int ,num2:Int) -> (sum:Int,sub:Int){
    return (num1+num2 , num1-num2)
}

let b = number(num1: 20, num2: 40)

let sum = b.sum
let sub = b.sub





























