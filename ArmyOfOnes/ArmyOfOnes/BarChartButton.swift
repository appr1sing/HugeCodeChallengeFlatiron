//
//  BarChartButton.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/11/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import UIKit

class BarChartButton: UIButton {

    override func draw(_ rect: CGRect) {
        BarChartButtonView.drawBarChartBtn(frame: bounds, resizing: .aspectFill)
    }

}
