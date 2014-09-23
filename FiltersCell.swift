//
//  FiltersCell.swift
//  
//
//  Created by admin on 9/21/14.
//
//

import UIKit

protocol FiltersCellDelegate {
    func filtersCell(filtersCell: FiltersCell, didChangeValue value: Bool) -> Void
}

class FiltersCell: UITableViewCell {

    @IBOutlet weak var dealsLabel: UILabel!
    @IBOutlet weak var dealsSwitch: UISwitch!
    var delegate: FiltersCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitch(sender: AnyObject) {
        delegate?.filtersCell(self, didChangeValue: dealsSwitch.on)
    }

}
