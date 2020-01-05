//
//  TournementTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class TournementTableViewCell: UITableViewCell {
    @IBOutlet  var borderView: UIView!
    @IBOutlet  var viw: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet  var vw: UIView!
    
    @IBOutlet weak var stadiumNameLabel: UILabel!
    @IBOutlet  var btn: UIButton!
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
}
