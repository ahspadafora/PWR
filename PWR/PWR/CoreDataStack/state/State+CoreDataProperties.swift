//
//  State+CoreDataProperties.swift
//  PWR
//
//  Created by Amber Spadafora on 10/18/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//
//

import Foundation
import CoreData


extension State {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<State> {
        return NSFetchRequest<State>(entityName: "State")
    }

    @NSManaged public var fullname: String?
    @NSManaged public var abbreviation: String?
    @NSManaged public var senators: NSSet?
    @NSManaged public var representatives: NSSet?

}

// MARK: Generated accessors for senators
extension State {

    @objc(addSenatorsObject:)
    @NSManaged public func addToSenators(_ value: Senator)

    @objc(removeSenatorsObject:)
    @NSManaged public func removeFromSenators(_ value: Senator)

    @objc(addSenators:)
    @NSManaged public func addToSenators(_ values: NSSet)

    @objc(removeSenators:)
    @NSManaged public func removeFromSenators(_ values: NSSet)

}

// MARK: Generated accessors for representatives
extension State {

    @objc(addRepresentativesObject:)
    @NSManaged public func addToRepresentatives(_ value: Representative)

    @objc(removeRepresentativesObject:)
    @NSManaged public func removeFromRepresentatives(_ value: Representative)

    @objc(addRepresentatives:)
    @NSManaged public func addToRepresentatives(_ values: NSSet)

    @objc(removeRepresentatives:)
    @NSManaged public func removeFromRepresentatives(_ values: NSSet)

}
