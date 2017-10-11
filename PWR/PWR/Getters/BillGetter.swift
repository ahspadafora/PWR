//
//  BillGetter.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/11/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

struct BillGetter {
    var bills: [Bill] {
        if let bills = getBills() {
            return bills
        } else {
            return []
        }
    }
    
    func getBills() -> [Bill]? {
        let dummyBill = Bill(name: "", number: "h.r.116", lastAction: "")
        let manager = APIManager.instance
        if let recentAbortionLegislation = Endpoints.abortionBills {
        
        manager.getData(on: recentAbortionLegislation, callback:
            { (data: Data?) in
                if let validData = data {
                    dump(validData)
                }
        })}
        
        return [dummyBill]
    }
}
