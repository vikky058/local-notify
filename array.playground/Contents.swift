import UIKit

let array = [35,32,14,37,32,99,67,54,34,0,99,100,35]
array.sorted()
let nsarray = NSArray(array: array)
let set = Set(nsarray as! [Int]).sorted()
set[set.count - 3]


let j = 2
for j in 0...10{
    print(j)
}

var primeArray = [Int]()
primeArray.append(2)
var number = 3
var count = primeArray.count
//var i = 2
while(count != 100){
    var isprime = true
    for i in 0..<primeArray.count{
        if (number % primeArray[i] == 0) {
            isprime = false
        }
    }
    if isprime{
        primeArray.append(number)
        
    }
    count = primeArray.count
    number += 1
}
print(primeArray)




















