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
    
    var currencyLabels : [String] {
        
        var moneyLabel = [String]()
        for currency in currencies {
            moneyLabel.append(currency.name)
        }
        return moneyLabel
    }
    
    var testView : UIView!
    var eurBar : UIView!
    var gbpBar : UIView!
    var brlBar : UIView!
    var jpyBar : UIView!
    var bars : [UIView] {
        return [eurBar, gbpBar, brlBar, jpyBar]
    }
    
    var currencyTitle : UILabel!
    var eurLabel : UILabel!
    var gbpLabel : UILabel!
    var brlLabel : UILabel!
    var jpyLabel : UILabel!
    var labels : [UILabel] {
        return [eurLabel, gbpLabel, brlLabel, jpyLabel]
    }
    
    var eurTitle : UILabel!
    var gbpTitle : UILabel!
    var brlTitle : UILabel!
    var jpyTitle : UILabel!
    var titles : [UILabel] {
        return [eurTitle, gbpTitle, brlTitle, jpyTitle]
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
        
        for (index, title) in titles.enumerated() {
            animateTitle(title, title: currencyLabels[index])
        }
        
    }
    
    private func setupBar() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissVC))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
        
        testView = UIView(frame: CGRect(x: 0.0, y: view.center.y * 0.5, width: view.frame.width, height: view.frame.height * 0.6))
        view.addSubview(testView)
        
        eurBar = UIView(frame: CGRect(x: 0.0, y: testView.frame.minY + (testView.frame.height * 0.0625), width: 0.0, height: testView.frame.height / 4 * 0.5))
        eurBar.backgroundColor = UIColor(red: 0/255.0, green: 51/255.0, blue: 102/255.0, alpha: 1.0)
        view.addSubview(eurBar)
        
        gbpBar = UIView(frame: CGRect(x: 0.0, y: testView.frame.minY + (testView.frame.height * 0.3125), width: 0.0, height: testView.frame.height / 4 * 0.5 ))
        gbpBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 204/255.0, alpha: 1.0)
        view.addSubview(gbpBar)
        
        brlBar = UIView(frame: CGRect(x: 0.0, y: testView.frame.minY + (testView.frame.height * 0.5625), width: 0.0, height: testView.frame.height / 4 * 0.5 ))
        brlBar.backgroundColor = UIColor(red: 0.0, green: 153/255.0, blue: 0.0, alpha: 1.0)
        view.addSubview(brlBar)
        
        jpyBar = UIView(frame: CGRect(x: 0.0, y: testView.frame.minY + (testView.frame.height * 0.8125), width: 0.0, height: testView.frame.height / 4 * 0.5))
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
        
        let testLabel = UILabel(frame: CGRect(x: view.frame.maxX * 0.85, y: animatedView.frame.maxY, width: view.frame.width * 0.2, height: animatedView.frame.height * 0.4))
        testLabel.text = String( describing: (1.0 / CGFloat(divisor)) / offset )
        testLabel.font = UIFont(name: "GillSans-Light", size: 12)
        testLabel.textColor = UIColor.white
        testLabel.textAlignment = .center
        view.addSubview(testLabel)
        
        let testLabel2 = UILabel(frame: CGRect(x: view.frame.maxX * 0.5, y: animatedView.frame.maxY, width: view.frame.width * 0.1, height: animatedView.frame.height * 0.4))
        testLabel2.center.x = view.center.x
        testLabel2.text = String( describing: (1.0 / CGFloat(divisor)) / offset * 0.5)
        testLabel2.font = UIFont(name: "GillSans-Light", size: 12)
        testLabel2.textColor = UIColor.white
        testLabel2.textAlignment = .center
        view.addSubview(testLabel2)
        
        let testLabel3 = UILabel(frame: CGRect(x: 0.0, y: animatedView.frame.maxY, width: view.frame.width * 0.1, height: animatedView.frame.height * 0.4))
        testLabel3.text = "0.0"
        testLabel3.font = UIFont(name: "GillSans-Light", size: 12)
        testLabel3.textColor = UIColor.white
        testLabel3.textAlignment = .center
        view.addSubview(testLabel3)
        
        
        
    }
    
    private func layoutLabels() {
        
        currencyTitle = UILabel(frame: CGRect(x: 0.0, y: testView.frame.minY - (testView.frame.height / 4 * 0.5) , width: view.frame.width, height: view.frame.height * 0.1))
        currencyTitle.center.x = view.center.x
        let message = "CURRENCY BAR CHART"
        currencyTitle.font = UIFont(name: "GillSans-SemiBold", size: 20)
        currencyTitle.text = message
        currencyTitle.textColor = UIColor.white
        currencyTitle.textAlignment = .center
        currencyTitle.numberOfLines = 0
        view.addSubview(currencyTitle)
        
        
        // SETUP CURRENCY RATE LABELS
        
        eurLabel = UILabel(frame: CGRect(x: eurBar.frame.maxX * 0.9, y: eurBar.frame.minY, width: eurBar.frame.width * 0.2, height: eurBar.frame.height * 0.3))
        eurLabel.center.y = eurBar.center.y
        view.addSubview(eurLabel)
        
        gbpLabel = UILabel(frame: CGRect(x: gbpBar.frame.maxX * 0.9, y: gbpBar.frame.minY, width: eurBar.frame.width * 0.2, height: gbpBar.frame.height * 0.3))
        gbpLabel.center.y = gbpBar.center.y
        view.addSubview(gbpLabel)
        
        brlLabel = UILabel(frame: CGRect(x: brlBar.frame.maxX * 0.85, y: brlBar.frame.minY, width: eurBar.frame.width * 0.2, height: brlBar.frame.height * 0.3))
        brlLabel.center.y = brlBar.center.y
        view.addSubview(brlLabel)
        
        jpyLabel = UILabel(frame: CGRect(x: jpyBar.frame.maxX * 0.7, y: jpyBar.frame.minY, width: eurBar.frame.width * 0.2, height: jpyBar.frame.height * 0.3))
        jpyLabel.center.y = jpyBar.center.y
        view.addSubview(jpyLabel)
        
        // SETUP CURRENCY TITLES
        
        eurTitle = UILabel(frame: CGRect(x: eurBar.frame.maxX * 0.1, y: eurBar.frame.minY, width: eurBar.frame.width * 0.2, height: eurBar.frame.height * 0.3))
        eurTitle.center.y = eurBar.center.y
        view.addSubview(eurTitle)
        
        gbpTitle = UILabel(frame: CGRect(x: eurBar.frame.maxX * 0.1, y: eurBar.frame.minY, width: eurBar.frame.width * 0.2, height: eurBar.frame.height * 0.3))
        gbpTitle.center.y = gbpBar.center.y
        view.addSubview(gbpTitle)
        
        brlTitle = UILabel(frame: CGRect(x: eurBar.frame.maxX * 0.1, y: eurBar.frame.minY, width: eurBar.frame.width * 0.2, height: eurBar.frame.height * 0.3))
        brlTitle.center.y = brlBar.center.y
        view.addSubview(brlTitle)
        
        jpyTitle = UILabel(frame: CGRect(x: eurBar.frame.maxX * 0.1, y: eurBar.frame.minY, width: eurBar.frame.width * 0.2, height: eurBar.frame.height * 0.3))
        jpyTitle.center.y = jpyBar.center.y
        view.addSubview(jpyTitle)
        
        for label in labels {
            label.textColor = UIColor.white
            label.font = UIFont(name: "GillSans-Light", size: 15)
            label.alpha = 0.0
            label.textAlignment = .left
        }
        
        for title in titles {
            title.textColor = UIColor.white
            title.font = UIFont(name: "GillSans-Regular", size: 15)
            title.alpha = 0.0
            title.textAlignment = .left
        }
        
        
    }
    
    private func animateLabel(_ label: UILabel, rate: Double) {
        
        UIView.animate(withDuration: 1.2, delay: 0.5, options: .curveEaseInOut, animations: {
            
            label.alpha = 1.0
            label.text = String(rate.roundTo(places: 2))
            
        }, completion: nil)
        
    }
    
    private func animateTitle(_ label: UILabel, title: String) {
        
        UIView.animate(withDuration: 1.2, delay: 0.5, options: .curveEaseInOut, animations: {
            
            label.alpha = 1.0
            label.text = title
            
        }, completion: nil)
        
        
    }
    
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
}
