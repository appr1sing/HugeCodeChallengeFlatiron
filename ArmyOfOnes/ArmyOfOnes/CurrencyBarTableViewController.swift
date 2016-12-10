//
//  CurrencyBarTableViewController.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/8/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import UIKit

class CurrencyBarTableViewController: CurrencyTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VIEW DID")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return super.currencies.selectedCurrency.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bar", for: indexPath) as! CurrencyBarTableViewCell
        cell.currencyLabel.text = currencies.selectedCurrency[indexPath.row].name
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(currencies.selectedCurrency.count)
    }
    
    
}


