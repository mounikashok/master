//
//  BookingsTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class BookingsTableViewCell: UITableViewCell {
    @IBOutlet  var viw: UIView!
    
    @IBOutlet  var vw: UIView!
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
