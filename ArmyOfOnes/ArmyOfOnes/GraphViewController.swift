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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBar()
        animateAllBar()
        layoutLabels()
        animateAllLabels()
    }

    private func animateAllBar() {
        
        for (index,bar) in bars.enumerated() {
            
            animateBar(bar, multiplier: rates[index])
        }
        
    }
    
    private func animateAllLabels() {
        
        for (index,label) in labels.enumerated() {
            animateLabel(label, rate: rates[index])
        }
        
    }
    
    
    private func setupBar() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissVC))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
        
        testView = UIView(frame: CGRect(x: 0.0, y: view.center.y * 0.5, width: view.frame.width, height: view.frame.height * 0.6))
        view.addSubview(testView)
        
        eurBar = UIView(frame: CGRect(x: 0.0, y: testView.frame.minY, width: 0.0, height: testView.frame.height / 4 ))
        eurBar.backgroundColor = UIColor(red: 0/255.0, green: 51/255.0, blue: 102/255.0, alpha: 1.0)
        view.addSubview(eurBar)
        
        gbpBar = UIView(frame: CGRect(x: 0.0, y: eurBar.frame.maxY, width: 0.0, height: testView.frame.height / 4 ))
        gbpBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 204/255.0, alpha: 1.0)
        view.addSubview(gbpBar)
        
        brlBar = UIView(frame: CGRect(x: 0.0, y: gbpBar.frame.maxY, width: 0.0, height: testView.frame.height / 4 ))
        brlBar.backgroundColor = UIColor(red: 0.0, green: 153/255.0, blue: 0.0, alpha: 1.0)
        view.addSubview(brlBar)
        
        jpyBar = UIView(frame: CGRect(x: 0.0, y: brlBar.frame.maxY, width: 0.0, height: testView.frame.height / 4 ))
        jpyBar.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
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
        
        let testLabel = UILabel(frame: CGRect(x: view.frame.maxX * 0.9, y: animatedView.frame.maxY, width: animatedView.frame.width * 0.2, height: animatedView.frame.height * 0.2))
        testLabel.text = String( describing: (1.0 / CGFloat(divisor)) / offset )
        testLabel.font = UIFont(name: "GillSans-Light", size: 12)
        testLabel.textColor = UIColor.white
        testLabel.textAlignment = .left
        view.addSubview(testLabel)
        
        
    }
    
    private func layoutLabels() {
        
        eurLabel = UILabel(frame: CGRect(x: eurBar.frame.maxX * 0.9, y: eurBar.frame.minY, width: eurBar.frame.width * 0.2, height: eurBar.frame.height * 0.2))
        view.addSubview(eurLabel)
        
        gbpLabel = UILabel(frame: CGRect(x: gbpBar.frame.maxX * 0.9, y: gbpBar.frame.minY, width: eurBar.frame.width * 0.2, height: gbpBar.frame.height * 0.2))
        view.addSubview(gbpLabel)
        
        brlLabel = UILabel(frame: CGRect(x: brlBar.frame.maxX * 0.9, y: brlBar.frame.minY, width: eurBar.frame.width * 0.2, height: brlBar.frame.height * 0.2))
        view.addSubview(brlLabel)
        
        jpyLabel = UILabel(frame: CGRect(x: jpyBar.frame.maxX * 0.9, y: jpyBar.frame.minY, width: eurBar.frame.width * 0.2, height: jpyBar.frame.height * 0.2))
        view.addSubview(jpyLabel)
       
        for label in labels {
            label.textColor = UIColor.white
            label.font = UIFont(name: "GillSans-Light", size: 15)
            label.alpha = 0.0
        }
        
        
    }
    
    private func animateLabel(_ label: UILabel, rate: Double) {
        
        UIView.animate(withDuration: 1.2, delay: 0.5, options: .curveEaseInOut, animations: {
            
            label.alpha = 1.0
            label.text = String(rate.roundTo(places: 2))
            
        }, completion: nil)
        
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
