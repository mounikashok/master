//
//  ReferandearnViewController.swift
//  EventClap
//
//  Created by prominere on 9/18/19.
//  Copyright © 2019 promm. All rights reserved.
//

import UIKit

class ReferandearnViewController: UIViewController {

    
    
    @IBOutlet  var vw: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vw.addBorders()
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("Refer & Earn", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
        
    }
    
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func inviteButtonAction(_ sender: Any) {
         let textToShare = "Earn minimum $100"
        
           if let myWebsite = NSURL(string: "http://google.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
               //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
               //
        
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
           }
    }
    
}
