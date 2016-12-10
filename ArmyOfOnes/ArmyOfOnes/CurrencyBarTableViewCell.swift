//
//  CurrencyBarTableViewCell.swift
//  ArmyOfOnes
//
//  Created by Arvin San Miguel on 12/8/16.
//  Copyright © 2016 AppRising. All rights reserved.
//

import UIKit

class CurrencyBarTableViewCell: UITableViewCell {
    
    var barView : UIView!
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setup()
    }
    
    func setup() {
        
        barView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: contentView.frame.height))
        barView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        contentView.addSubview(barView)
    }
    
    func animateBar() {
        
        UIView.animate(withDuration: 1.5, delay: 1.0, options: [.autoreverse, .repeat], animations: {
            
            self.barView.frame = CGRect(x: 0.0, y: 0.0, width: self.contentView.frame.width * 0.6, height: self.contentView.frame.height)
            
        }, completion: nil)
        
    }
    
    func reset() {
        
        UIView.animate(withDuration: 1.5, delay: 1.0, options: .curveEaseInOut, animations: {
            
            self.barView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: self.contentView.frame.height)
            
        }, completion: nil)
        
    }
    
    
}
