//
//  APIManager.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/07/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

func retrieveKey(forAPI keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "AdditionalInfo", ofType: "plist")
    
    let plist = NSDictionary(contentsOfFile: filePath!)
    
    let value: String = plist?.object(forKey: keyname) as! String
    
    return value
}

class APIManager {
    private init() {}
    static let manager = APIManager()
    
    private let key = retrieveKey(forAPI: "Propublica")
    
    func getData(on endpoint: URL, callback: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: endpoint)
        
        request.setValue(key, forHTTPHeaderField: "X-API-Key")
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error during session: \(String(describing: error))")
            }
            
            guard let validData = data else { return }
            
            callback(validData)
            }.resume()
    }
}
