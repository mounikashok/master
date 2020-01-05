//
//  HomeTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet  var borderView: UIView!
    @IBOutlet  var favouriteBtn: UIButton!
    @IBOutlet  var bookNowBtn: UIButton!
    @IBOutlet  var costField: UILabel!
    @IBOutlet var stadiumName: UILabel!
    @IBOutlet var locationName: UILabel!
    
    @IBOutlet var costLbl: UILabel!
    
    @IBOutlet var ratingsLbl: UILabel!
    
    @IBOutlet var reviewsLbl: UILabel!
    
    @IBOutlet var imgPage: UIImageView!

    
        
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

