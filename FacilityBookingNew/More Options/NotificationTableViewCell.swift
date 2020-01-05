//
//  NotificationTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet  var viw: UIView!
    @IBOutlet  var img: UIImageView!
    
    @IBOutlet  var discrptionField: UILabel!
    
    @IBOutlet  var timeField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = img.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
