//
//  BarChartButtonView.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/11/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import Foundation
import UIKit

public class BarChartButtonView : NSObject {
    
    //// Drawing Methods
    
    public dynamic class func drawBarChartBtn(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 153, height: 153), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 153, height: 153), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 153, y: resizedFrame.height / 153)
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 33.5, y: 29.5, width: 90, height: 91))
        UIColor.white.setStroke()
        ovalPath.lineWidth = 5
        ovalPath.stroke()
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 53.5, y: 53.5, width: 50, height: 8))
        UIColor.white.setFill()
        rectanglePath.fill()
        UIColor.white.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()
        
        
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 53.5, y: 71.5, width: 50, height: 8))
        UIColor.white.setFill()
        rectangle2Path.fill()
        UIColor.white.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()
        
        
        //// Rectangle 3 Drawing
        let rectangle3Path = UIBezierPath(rect: CGRect(x: 53.5, y: 89.5, width: 50, height: 8))
        UIColor.white.setFill()
        rectangle3Path.fill()
        UIColor.white.setStroke()
        rectangle3Path.lineWidth = 1
        rectangle3Path.stroke()
        
        context.restoreGState()
        
    }
    
    
    
    
    @objc public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
