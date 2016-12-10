//
//  ViewController.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/2/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    //var multiplier : Double?
    
    
    @IBOutlet weak var containerView: UIView!
    var isSwitched = true
    
    var testView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(asChildViewController: currencyTableVC)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    private lazy var currencyBarVC : CurrencyBarTableViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "CurrencyBarVC") as! CurrencyBarTableViewController
        self.add(asChildViewController: vc)
        return vc
        
    }()
    
    private lazy var currencyTableVC : CurrencyTableViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "CurrencyTableVC") as! CurrencyTableViewController
        self.add(asChildViewController: vc)
        return vc
        
    }()
    
    
    
    private func add(asChildViewController viewController: UIViewController) {
        
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.backgroundColor = UIColor.clear
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParentViewController: self)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
        
    }
    
    @IBAction func testButton(_ sender: Any) {
        
        if isSwitched {
            
            remove(asChildViewController: currencyTableVC)
            add(asChildViewController: currencyBarVC)
            isSwitched = false
            
        } else {
            
            remove(asChildViewController: currencyBarVC)
            add(asChildViewController: currencyTableVC)
            isSwitched = true
            
        }
        
    }
    
}





