//
//  walletTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/26/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class walletTableViewCell: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var statusLabel: UIButton!
    @IBOutlet  var imgg: UIImageView!
    @IBOutlet  var viw: UIView!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
