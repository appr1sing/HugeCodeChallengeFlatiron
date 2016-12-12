//
//  Extensions.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/12/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(places num: Int) -> Double {
        let divisor = pow(10.0, Double(num))
        return (self * divisor).rounded() / divisor
        
    }
    
}
