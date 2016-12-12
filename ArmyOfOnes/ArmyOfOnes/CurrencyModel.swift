//
//  Currency.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/2/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import Foundation

class CurrencyModel {
    
    var date : String?
    var currencies = [ String : Double ]()
    var store = CurrencyAPIClient.shared
    var currency : [Currency] = []
    var selectedCurrency : [Currency] = []
    
    
    func getCurrencies(_ completion: @escaping (Bool) -> ()) {
        
        store.requestCurrentConversion({ json in
           
            guard let date = json["date"] as? String else { fatalError() }
            guard let responseCurrencies = json["rates"] as? [String : Double] else { fatalError() }
            
            for (key, value) in responseCurrencies {

                OperationQueue.main.addOperation {
                    
                    if key == "GBP" || key == "EUR" || key == "JPY" || key == "BRL" {
                        self.selectedCurrency.append(Currency(name: key, rate: value))
                    } else {
                        self.currency.append(Currency(name: key, rate: value))
                    }
                    self.date = date
                    completion(true)
                    
                }
            }
            
        })
        
    }
    
}



