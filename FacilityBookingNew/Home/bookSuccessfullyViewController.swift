//
//  bookSuccessfullyViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/27/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class bookSuccessfullyViewController: UIViewController {

    @IBOutlet weak var stadiumNameLabel: UILabel!
    
    @IBOutlet weak var temaNameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var teamNumberLabel: UILabel!
    @IBOutlet weak var regLabel: UILabel!
    var udf = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("Booking Successful", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
        regLabel.text = (udf.value(forKey: "bookingID") as! String)
    }
    
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func shareButton(_ sender: Any) {
         let textToShare = "Swift is awesome!  Check out this website about it!"
        
           if let myWebsite = NSURL(string: "http://google.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
               //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
               //
        
            activityVC.popoverPresentationController?.sourceView = (sender as! UIView)
            self.present(activityVC, animated: true, completion: nil)
           }
    }
    @IBAction func homeButton(_ sender: UIButton) {
        if sender.tag == 1 {
            tabBarController?.selectedIndex = 0
        }else{
            tabBarController?.selectedIndex = 2

        }
    }
}
