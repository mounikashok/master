//
//  LanguageTableCell.swift
//  OFA
//
//  Created by mounika on 05/09/19.
//  Copyright © 2019 Mounika Ashok. All rights reserved.
//

import UIKit

class LanguageTableCell: UITableViewCell {

    @IBOutlet var imgvw_language: UIImageView!
    @IBOutlet var lbl_language: UILabel!
    
    //MARK:- awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- setSelected
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
