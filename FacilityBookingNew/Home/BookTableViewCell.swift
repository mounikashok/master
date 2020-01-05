//
//  BookTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/26/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit
import GoogleMaps

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var topDeskLabel: UITextView!
    
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var stadiumName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet  var viw: UIView!
    @IBOutlet  var reviwsField: UILabel!
    @IBOutlet  var img: UIImageView!
    @IBOutlet  var nameField: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descTxtview: UITextView!
    
    @IBOutlet weak var star1Img: UIImageView!
    
    @IBOutlet weak var star2Img: UIImageView!
    @IBOutlet weak var star3Img: UIImageView!
    @IBOutlet weak var star4Img: UIImageView!
    @IBOutlet weak var star5Img: UIImageView!
    
    
    @IBOutlet weak var mapView: GMSMapView!
    //  @IBOutlet weak var mapView: GMSMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
