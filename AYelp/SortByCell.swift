//
//  SortByCell.swift
//  AYelp
//
//  Created by admin on 9/21/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

protocol SortByCellDelegate {
    func sortByCell(sortByCell: SortByCell, didChangeValue value: Bool) -> Void
}

class SortByCell: UITableViewCell {

    @IBOutlet weak var sortbyLabel: UILabel!
    @IBOutlet weak var sortBySwitch: UISwitch!
    
    var delegate: SortByCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func onSortBySwitch(sender: AnyObject) {
        delegate?.sortByCell(self, didChangeValue: sortBySwitch.on)
        
    }

}
