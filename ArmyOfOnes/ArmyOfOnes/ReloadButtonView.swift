//
//  ReloadButton.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/11/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import Foundation
import UIKit

public class ReloadButtonView : NSObject {
    
    //// Drawing Methods
    
    public dynamic class func drawReloadBtn(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 153, height: 153), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 153, height: 153), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 153, y: resizedFrame.height / 153)
        
        
        //// Group
        //// Oval Drawing
        context.saveGState()
        context.translateBy(x: 76.27, y: 25.1)
        context.rotate(by: 45.65 * CGFloat.pi/180)
        
        let ovalPath = UIBezierPath()
        ovalPath.move(to: CGPoint(x: 35.5, y: 71))
        ovalPath.addCurve(to: CGPoint(x: 0, y: 35.5), controlPoint1: CGPoint(x: 15.89, y: 71), controlPoint2: CGPoint(x: 0, y: 55.11))
        ovalPath.addCurve(to: CGPoint(x: 35.5, y: 0), controlPoint1: CGPoint(x: 0, y: 15.89), controlPoint2: CGPoint(x: 15.89, y: 0))
        ovalPath.addCurve(to: CGPoint(x: 71, y: 35.5), controlPoint1: CGPoint(x: 55.11, y: 0), controlPoint2: CGPoint(x: 71, y: 15.89))
        UIColor.white.setStroke()
        ovalPath.lineWidth = 5
        ovalPath.stroke()
        
        context.restoreGState()
        
        
        //// Bezier Drawing
        context.saveGState()
        context.translateBy(x: 98.5, y: 84.5)
        context.rotate(by: -8.77 * CGFloat.pi/180)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 18))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        UIColor.white.setStroke()
        bezierPath.lineWidth = 5
        bezierPath.stroke()
        
        context.restoreGState()
        
        
        //// Bezier 2 Drawing
        context.saveGState()
        context.translateBy(x: 101.5, y: 99.5)
        context.rotate(by: -9.88 * CGFloat.pi/180)
        
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 0, y: 0))
        bezier2Path.addLine(to: CGPoint(x: 16, y: 0))
        UIColor.white.setStroke()
        bezier2Path.lineWidth = 5
        bezier2Path.stroke()
        
        context.restoreGState()
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
