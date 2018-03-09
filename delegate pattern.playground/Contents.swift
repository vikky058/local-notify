//: Playground - noun: a place where people can play

import UIKit

protocol passdatadelegate{
    func passdata(data:String)
}

class firstvc{
    var delegate:passdatadelegate?
}
firstvc().delegate?.passdata(data: "hello i am vikky")

class secondvc:passdatadelegate{
    func passdata(data: String) {
        print("welcome here\(data)")
    }
}

let first = firstvc()
let second = secondvc()

first.delegate = second
first.delegate?.passdata(data: " hey")

