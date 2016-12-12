//
//  GraphViewController.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/12/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    var currencies = [Currency]()
    var rates : [Double] {
        
        var newRates = [Double]()
        for currency in currencies {
            newRates.append(currency.roundedRate)
        }
        return newRates
    }
    
    var testView : UIView!
    var eurBar : UIView!
    var gbpBar : UIView!
    var brlBar : UIView!
    var jpyBar : UIView!
    var bars : [UIView] {
        return [eurBar, gbpBar, brlBar, jpyBar]
    }
    
    var eurLabel : UILabel!
    var gbpLabel : UILabel!
    var brlLabel : UILabel!
    var jpyLabel : UILabel!
    var labels : [UILabel] {
        return [eurLabel, gbpLabel, brlLabel, jpyLabel]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBar()
        animateAllBar()
        layoutLabels()
    }

    private func animateAllBar() {
        
        for (index,bar) in bars.enumerated() {
            
            animateBar(bar, multiplier: rates[index])
        }
        
    }
    
    
    private func setupBar() {
        
        testView = UIView(frame: CGRect(x: 0.0, y: view.center.y * 0.5, width: view.frame.width, height: view.frame.height * 0.6))
        view.addSubview(testView)
        
        eurBar = UIView(frame: CGRect(x: 0.0, y: testView.frame.minY, width: 0.0, height: testView.frame.height / 4 ))
        eurBar.backgroundColor = UIColor.red
        view.addSubview(eurBar)
        
        gbpBar = UIView(frame: CGRect(x: 0.0, y: eurBar.frame.maxY, width: 0.0, height: testView.frame.height / 4 ))
        gbpBar.backgroundColor = UIColor.blue
        view.addSubview(gbpBar)
        
        brlBar = UIView(frame: CGRect(x: 0.0, y: gbpBar.frame.maxY, width: 0.0, height: testView.frame.height / 4 ))
        brlBar.backgroundColor = UIColor.green
        view.addSubview(brlBar)
        
        jpyBar = UIView(frame: CGRect(x: 0.0, y: brlBar.frame.maxY, width: 0.0, height: testView.frame.height / 4 ))
        jpyBar.backgroundColor = UIColor.cyan
        view.addSubview(jpyBar)
        
        
    }
    
    private func animateBar(_ animatedView: UIView, multiplier: Double) {
        
        var offset : CGFloat = 1.0
        var divisor = 1.0
        
        switch multiplier {
            
        case 0...1 : divisor = 1.0
        case 2...10 : divisor = 0.1 ; offset = 2.0
        case 11...100 : divisor = 0.01 ; offset = 3.0
        case 101...1000 : divisor = 0.001 ; offset = 4.0
        default : divisor = 0.0001 ; offset = 5.0
            
        }
        
        UIView.animate(withDuration: 1.2, delay: 0.2, options: .curveEaseInOut, animations: {
            
            animatedView.frame = CGRect(x: 0.0, y: animatedView.frame.origin.y, width: self.view.frame.width * CGFloat(multiplier * divisor) * offset, height: animatedView.frame.height)
            
            
        }, completion: nil)
        
        
    }
    
    private func layoutLabels() {
        
        eurLabel = UILabel(frame: CGRect(x: 0.0, y: view.center.y * 0.5, width: eurLabel.frame.width * 0.2, height: eurLabel.frame.height * 0.2))
        eurLabel.backgroundColor = UIColor.cyan
        view.addSubview(eurLabel)
        
        
        
        
        
        
    }
    
    
    
    
}
