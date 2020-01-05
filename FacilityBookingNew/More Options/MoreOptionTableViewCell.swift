//
//  MoreOptionTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class MoreOptionTableViewCell: UITableViewCell {

    @IBOutlet  var imgVw: UIImageView!
    @IBOutlet  var acntViw: UIView!
    @IBOutlet  var nameField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
