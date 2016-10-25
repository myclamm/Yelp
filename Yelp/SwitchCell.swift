//
//  SwitchCell.swift
//  Yelp
//
//  Created by Mike Lam on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwitchCell,
            didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // This is equivalent to defining an Action outlet for the onSwitch, and executing a function (switchValueChanged) upon the "valuChanged" action
        onSwitch.addTarget(self, action: #selector(switchValueChanged), for: UIControlEvents.valueChanged)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged () {
        print("HEYYYY")
        delegate?.switchCell?(switchCell: self, didChangeValue: onSwitch.isOn)
    }

}
