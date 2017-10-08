//
//  APIManager.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/07/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

class APIManager {
    private init() {}
    static let manager = APIManager()
    
    private let dummyAPIKey = "000"
    
    func getData(on endpoint: URL, callback: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: endpoint)
        
        request.setValue(dummyAPIKey, forHTTPHeaderField: "X-API-Key")
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
