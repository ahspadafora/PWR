//
//  Representative+CoreDataProperties.swift
//  PWR
//
//  Created by Amber Spadafora on 10/18/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//
//

import Foundation
import CoreData


extension Representative {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Representative> {
        return NSFetchRequest<Representative>(entityName: "Representative")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var id: String?
    @NSManaged public var party: String?
    @NSManaged public var contactUrl: String?
    @NSManaged public var state: State?

}
