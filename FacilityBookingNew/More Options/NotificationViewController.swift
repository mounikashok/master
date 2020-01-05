//
//  NotificationViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet  var notifcationTV: UITableView!
    var udf = UserDefaults()
    var groundsArray: NSMutableArray = NSMutableArray()
    var dataDict: NSDictionary! = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifcationTV.delegate = self
        notifcationTV.dataSource = self
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("Notifications", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.notificationApiCalling()
    }
    
    //MARK:- TableView Delegate Methods
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groundsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath as IndexPath) as! NotificationTableViewCell
        cell.viw.addBorders()
        dataDict = (groundsArray.object(at: indexPath.row) as! NSDictionary)
        cell.discrptionField.text = (dataDict.value(forKey: "message") as! String)
        cell.timeField.text = ""
        cell.img.sd_setImage(with: URL(string: (self.dataDict.value(forKey: "image") as! String)))

        cell.selectionStyle = .none
        /*
         {
                    id = 3;
                    image = "http://sampletemplates.net.in/facilitybooking/assets/image/grounds/Priyanka_Chopra52.jpg";
                    message = "Your booking successfully created";
                    name = "siva Play ground1111";
                }
         */
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    //MARK:- Api Callings
    func notificationApiCalling() {
            SVProgressHUD.show()
         let details:[Any] = ["notifications",udf.value(forKey: "userID") as! String]
            ApiManager.shared().getNotificationsApi(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:String = responseJSON.value(forKey: "status") as! String
            if status == "success" {
                self.groundsArray = NSMutableArray(array: (responseJSON.value(forKey: "grounds") as! NSArray))
                    self.notifcationTV.reloadData()
            }
            else if status == "error" {
                self.presentAlert(withTitle: "Login", message: responseJSON.value(forKey: "message") as! String)
            }
        },failure: { (session, error) in
            print(error?.localizedDescription as Any)
            self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
            SVProgressHUD.dismiss()
        })
    }
}
