//
//  RadiusCell.swift
//  AYelp
//
//  Created by admin on 9/21/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

protocol RadiusCellDelegate {
    func radiusCell(radiusCell: RadiusCell, didChangeValue value: Bool) -> Void
}

class RadiusCell: UITableViewCell {

    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var radiusSwitch: UISwitch!
    var delegate: RadiusCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRadiusSwitch(sender: AnyObject) {
        delegate?.radiusCell(self, didChangeValue: radiusSwitch.on)
    }
}
