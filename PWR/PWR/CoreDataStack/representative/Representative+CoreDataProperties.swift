//
//  Representative+CoreDataProperties.swift
//  
//
//  Created by Amber Spadafora on 10/17/17.
//
//

import Foundation
import CoreData


extension Representative {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Representative> {
        return NSFetchRequest<Representative>(entityName: "Representative")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var party: String?
    @NSManaged public var state: State?

}
