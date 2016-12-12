//
//  Currency.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/3/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import Foundation

struct Currency {
    
    var name : String
    var rate : Double
    var roundedRate : Double { return rate.roundTo(places: 2) }
    var displayName : String { return CurrencytoCountry.countryCode[name]! }
    
    init(name: String, rate: Double) {
        self.name = name
        self.rate = rate
    }
    
}


