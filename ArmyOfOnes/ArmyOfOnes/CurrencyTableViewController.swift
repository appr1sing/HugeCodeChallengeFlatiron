//
//  CurrencyTableViewController.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/3/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import UIKit


class CurrencyTableViewController: UITableViewController {

    var currencies = Currencies()
    var multiplier : Double = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAPI()
        setupNotifications()
        
    }
    
    func setupAPI() {
        
        currencies.getCurrencies({ success in self.tableView.reloadData() })
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currencies.selectedCurrency.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        let interval = Double(indexPath.row)
        cell.selectionStyle = .none
        cell.countryLabel.text = String(currencies.selectedCurrency[indexPath.row].displayName.uppercased())
        cell.currencyLabel.text = String(currencies.selectedCurrency[indexPath.row].name)
        animateRateLabel(cell.rateLabel, withInterval: interval)
        cell.rateLabel.text = String((currencies.selectedCurrency[indexPath.row].roundedRate * multiplier).roundTo(places: 2))
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(currencies.selectedCurrency.count)
    }
    
}

extension CurrencyTableViewController {
    
    func setupNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveNoti), name: NSNotification.Name(rawValue: notificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableView), name: NSNotification.Name(rawValue: reloadNotification), object: nil)
    }
    
    func receiveNoti(notification: NSNotification) {
        
        let receivedMultiplier = notification.object as! String
        multiplier = Double(receivedMultiplier)!
        self.tableView.reloadData()
        
    }
    
    func reloadTableView() {
        
        print("RELOAD")
        currencies.currency = []
        currencies.selectedCurrency = []
        setupAPI()
        
        //reload the USD text label
        let defaultAmount = "1.00"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationKey), object: defaultAmount)
        
    }
    
    func animateRateLabel(_ label: UILabel, withInterval interval: Double) {
        
        label.alpha = 0.0
        UIView.animate(withDuration: 0.7 + (interval * 0.5), animations: {
            
            label.alpha = 1.0
            
        })
        
    }
        
}



