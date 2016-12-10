//
//  CurrencyAPIClient.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/2/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import Foundation
typealias JSON = [ String : Any ]

struct CurrencyAPIClient {
    
    static let shared = CurrencyAPIClient()
    
    private init() {}
    
    func requestCurrentConversion(_ completion: @escaping (JSON) -> ()) {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = URL(string: "http://api.fixer.io/latest?base=USD")
        let task = session.dataTask(with: url!) { data, response, error in
            
            guard let data = data else { fatalError() }
            guard let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as! JSON else { return }
            
            OperationQueue.main.addOperation {
                completion(responseJSON)
            }
            
        }
        task.resume()
        
    }
    
}

