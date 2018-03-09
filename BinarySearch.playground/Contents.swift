//: Playground - noun: a place where people can play

import UIKit

func binarySearch(array:[Int],number:Int) -> Bool{
    var leftindex = 0
    var rightIndex = array.count - 1
    while leftindex <= rightIndex{
        let middleindex = (rightIndex + leftindex)/2
        let midlevalue = array[middleindex]
        print("left Index:\(leftindex)        right index:\(rightIndex)     leftvalue:\(array[leftindex])       right value:\(array[rightIndex])        middle index:\(middleindex)          middle value:\(array[middleindex])")
        if midlevalue == number{
            return true
        }
        if number < midlevalue{
            rightIndex = middleindex - 1
        }
        if number > midlevalue
        {
            leftindex = middleindex + 1
        }
    }
    return false
}

binarySearch(array: [1,4,7,8,12,14,16,17,19,25,35], number: 2)
