//
//  HomeNotificationsViewController.swift
//  FacilityBooking
//
//  Created by revansh on 12/9/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class HomeNotificationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet  var notificationTableView: UITableView!
    var notificationArray: NSArray = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn111 = UIButton(type: .custom)
        btn111.setImage(UIImage(named: "Logo"), for: .normal)
        btn111.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let item111 = UIBarButtonItem(customView: btn111)
        
        let home = UIButton(type: .custom)
        home.setTitle("Notifications", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-BOLD", size: 18.0)
        home.setTitleColor(.black, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,item111,homeItem] , animated: true)
    }
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
          let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNotificationCell", for: indexPath as IndexPath) as! HomeTableViewCell
            let array = notificationArray[indexPath.row]as! NSDictionary
            cell.selectionStyle = .none
           
            
            cell.borderView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.borderView.layer.shadowOpacity = 1.5
            cell.borderView.layer.shadowOffset = CGSize.zero
            cell.borderView.layer.shadowRadius = 3
            cell.borderView.layer.cornerRadius = 5.0
            
            return cell
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
    }
    
}
