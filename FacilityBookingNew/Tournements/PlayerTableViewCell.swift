//
//  PlayerTableViewCell.swift
//  FacilityBooking
//
//  Created by iso99 on 9/26/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
   var name:NSMutableArray = []
    @IBOutlet  var collectionVw: UICollectionView!
    
    @IBOutlet  var viw: UIView!
    @IBOutlet  var teamField: UILabel!
    @IBOutlet  var backgroundViewData: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet  var iplField: UILabel!
    func reload(nameArray:NSMutableArray){
        collectionVw.delegate = self
        collectionVw.dataSource = self
        name = nameArray
        collectionVw.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell", for: indexPath) as! PlayerCollectionViewCell
        
        cell.img.image = name[indexPath.item] as! UIImage
        cell.img.layer.cornerRadius = cell.img.frame.height/2
        
        return cell;
        
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
