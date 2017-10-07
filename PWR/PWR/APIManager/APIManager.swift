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
    
    func getData(for endpoint: URL, callback: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: endpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error during session: \(String(describing: error))")
            }
            
            guard let validData = data else { return }
            
            callback(validData)
            }.resume()
    }
}
