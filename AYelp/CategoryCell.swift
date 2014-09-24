//
//  CategoryCell.swift
//  AYelp
//
//  Created by admin on 9/21/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate {
    func categoryCell(categoryCell: CategoryCell, didChangeValue value: Bool) -> Void
}

class CategoryCell: UITableViewCell {

    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categorySwitch: UISwitch!
    
    var delegate: CategoryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func categorySwitch(sender: AnyObject) {
        delegate?.categoryCell(self, didChangeValue: categorySwitch.on)
        
    }
}
