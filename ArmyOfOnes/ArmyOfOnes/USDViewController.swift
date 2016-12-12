//
//  USDViewController.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/4/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import UIKit

let notificationKey = "com.AppRising"
let reloadNotification = "com.AppR1sing"

class USDViewController: UIViewController {
    
    @IBOutlet weak var dollarTextField: UITextField!
    var amount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sendNoti), name: NSNotification.Name(rawValue: notificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.sendNotiToReloadData), name: NSNotification.Name(rawValue: reloadNotification), object: nil)
        
        
    }
    
    @IBAction func reloadBtnTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: reloadNotification), object: nil)
    }
    
    func sendNoti(notification: NSNotification) {
        let receivedDefaultAmount = notification.object as! String
        dollarTextField.text = receivedDefaultAmount
    }
    func sendNotiToReloadData(notification: Notification) {}
}

extension USDViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if validateContentsOf(dollars: dollarTextField.text!) {
            amount = dollarTextField.text!
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationKey), object: amount)
        }
        
        dollarTextField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dollarTextField.endEditing(true)
    }
    
    func textField(_ shouldChangeCharactersIntextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText: NSString = dollarTextField.text! as NSString
        let newText: String = oldText.replacingCharacters(in: range, with: string)
        let arrayOfNewText = newText.characters.map({ String($0) })
        
        if arrayOfNewText.contains(".") {
            
            let arraySlice = Int(arrayOfNewText.index(of: ".")!)
            if ((arrayOfNewText.count - 1) - arraySlice) == 3 { return false }
            
        }
        
        return true
  
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" && validateContentsOf(dollars: textField.text!) {
            //Animate result
            amount = dollarTextField.text!
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationKey), object: amount)
        } else {
            //Animate result
            textField.shake()
        }
        
    }
    
    func validateContentsOf(dollars text: String) -> Bool {
        
        let regex = "[+-]?[0-9]{1,3}(?:,?[0-9]{3})*(?:\\.[0-9]{1,2})?"
        let currencyTestOne = NSPredicate(format: "SELF MATCHES %@", regex)
        if currencyTestOne.evaluate(with: text) { return true }
        return false
        
    }
    
    
    
    
}


