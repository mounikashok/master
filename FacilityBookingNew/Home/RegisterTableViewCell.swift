//
//  RegisterTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/26/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {

    
    @IBOutlet  var playerField: UILabel!
    @IBOutlet  var phoneField: UILabel!
    @IBOutlet  var nameField: UILabel!
    @IBOutlet  var emailField: UILabel!
    @IBOutlet  var radioButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
