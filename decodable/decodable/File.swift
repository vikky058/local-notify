//
//  File.swift
//  decodable
//
//  Created by Vikky Chaudhary on 16/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import Foundation
import UIKit

struct Becon {
    let name:String
    let becontype:String
    let id:Int
}
let forklift = Becon(name: "store", becontype: "retail", id: 1)
let drill = Becon(name: "forklift", becontype: "equipment", id: 2)
let hello = Becon(name: "dknlehdie", becontype: "abcde", id: 3)
let hey = Becon(name: "jefguegf78e", becontype: "hgdjadj", id: 4)

let becon:[Becon] = [forklift,drill,hello,hey]



func start(){
    do{
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(becon)
    }catch{
        print("error")
    }
}






