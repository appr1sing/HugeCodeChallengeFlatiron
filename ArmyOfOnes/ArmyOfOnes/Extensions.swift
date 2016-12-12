//
//  Extensions.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/12/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func roundTo(places num: Int) -> Double {
        let divisor = pow(10.0, Double(num))
        return (self * divisor).rounded() / divisor
    }
}

extension UITextField {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.5
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
    }

}
