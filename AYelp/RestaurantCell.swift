//
//  RestaurantCell.swift
//  AYelp
//
//  Created by admin on 9/20/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var rnameLabel: UILabel!
    @IBOutlet weak var raddressLabel: UILabel!
    @IBOutlet weak var rcuisinesLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var ratingsView: UIImageView!
    @IBOutlet weak var rreviewsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
