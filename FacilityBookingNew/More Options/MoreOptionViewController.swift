//
//  MoreOptionViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class MoreOptionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var nameFields = ["My Profile","Wallet Management","My Favorites","Share App ","Refer Friend","Notification"]
    var imgs = ["user","wallet","fav","share","refer","notif"]
    var udf = UserDefaults()
    
    @IBOutlet weak var moreTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreTV.delegate = self
        moreTV.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreOptionTableViewCell", for: indexPath as IndexPath) as! MoreOptionTableViewCell
        cell.nameField.text = nameFields[indexPath.row]
        cell.acntViw.addBorders()
        cell.selectionStyle = .none
       cell.imgVw.image = UIImage(named: imgs[indexPath.row])
        
        if indexPath.row == 5{
            
            
            let switchButton = UISwitch(frame: CGRect(x: 310, y: 13, width: 0, height: 0))
            switchButton.tintColor = .black
            switchButton.onTintColor = #colorLiteral(red: 0.2588526607, green: 0.8007593751, blue: 0.7807978988, alpha: 1)
            switchButton.isOn = true
            cell.contentView.addSubview(switchButton)
            

            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3{
             let textToShare = "Swift is awesome!  Check out this website about it!"
            
               if let myWebsite = NSURL(string: "http://google.com/") {
                let objectsToShare = [textToShare, myWebsite] as [Any]
                   let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
                   //New Excluded Activities Code
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                   //
            
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC, animated: true, completion: nil)
               }
        }else {
            self.performSegue(withIdentifier: nameFields[indexPath.row], sender:nil)
        }
        
        
    }
    
    
    
    @IBAction func logoutAction(_ sender: Any) {
        let alertController = UIAlertController(title: "", message:"Are you sure do you want to logout?" , preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.udf.set(false, forKey: "LOGIN")
            self.udf.synchronize()
            self.performSegue(withIdentifier: "Logout", sender: nil)
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
        }
        alertController.addAction(OKAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true)
        {
        }       
    }
}
