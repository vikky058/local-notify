//
//  Form+CoreDataProperties.swift
//  form coredata
//
//  Created by Vikky Chaudhary on 19/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//
//

import Foundation
import CoreData


extension Form {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Form> {
        return NSFetchRequest<Form>(entityName: "Form")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: Int64
    @NSManaged public var ava: NSData?

}
