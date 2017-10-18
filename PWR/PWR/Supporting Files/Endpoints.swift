//
//  Endpoints.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/07/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

struct Endpoints {
    static let abortionBills = URL(string: "https://api.propublica.org/congress/v1/bills/subjects/abortion.json")
    
    static func getMemberEndPoint(chamber: Chamber) -> URL? {
        return URL(string: "https://api.propublica.org/congress/v1/115/\(chamber.rawValue)/members.json")
    }
}

struct HR36Endpoints {
    /*
     Note! The bill has not been assigned a senate bill id yet. The endpoints
     below will work for querying the House of Representaives on their version
     of the Pain-Capable Unborn Child Protection Act.
     
     See https://projects.propublica.org/api-docs/congress-api/bills/#get-a-specific-bill
     */
    
    static let billDetails = URL(string: "https://api.propublica.org/congress/v1/115/bills/hr36.json")
    static let billCoSponsors = URL(string: "https://api.propublica.org/congress/v1/115/bills/hr36/cosponsors.json")
    static let congressionalStatements = URL(string: "https://api.propublica.org/congress/v1/statements/subject/abortion.json")
    static let floorActions = URL(string: "https://api.propublica.org/congress/v1/115/senate/floor_updates.json")
}
