//
//  DataService.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 08/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseDatabase

let DB_BASE = Database.database().reference()

class DataService{
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_DRIVERS = DB_BASE.child("drivers")
    private var _REF_TRIPS = DB_BASE.child("trips")
    
    var REF_BASE : DatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS:DatabaseReference{
        return _REF_USERS
    }
    
    var REF_DRIVERS:DatabaseReference{
        return _REF_DRIVERS
    }
    
    var REF_TRIPS:DatabaseReference{
        return _REF_TRIPS
    }
    
    func createFirebaseDBUser(uid:String, userData:Dictionary<String, Any>, isdriver:Bool){
        if isdriver{
            REF_DRIVERS.child(uid).updateChildValues(userData)
        }else{
            REF_USERS.child(uid).updateChildValues(userData)
        }
    }
    
    
}





















