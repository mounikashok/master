//
//  PlayerViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/26/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func itemPressedAtIndex(index: Int) {
        
    }
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamNumberLabel: UILabel!
    @IBOutlet weak var teamsView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var gardenLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet  var playerTV: UITableView!
    var udf = UserDefaults()
    var dataDict: NSDictionary!
    var imagesArray: NSMutableArray = NSMutableArray()
    var teamsArray: NSArray = NSArray()
    var images: [UIImage]!

    @IBOutlet weak var descLabel: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    playerTV.delegate = self
    playerTV.dataSource = self
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("IPL 2019", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
        self.teamsView.alpha = 0.0
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tournmentDetailsApiCalling()
    }
    
    //MARK:- TableView Delegate Methods
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath as IndexPath) as! PlayerTableViewCell
        
            if(indexPath.row % 2 == 0)
           {
               cell2.backgroundViewData.layer.backgroundColor = UIColor.white.cgColor
           }
           else
           {
               cell2.backgroundViewData.layer.backgroundColor = UIColor.lightGray.cgColor
               
           }
        cell2.selectionStyle = .none
        let dataDict = (self.teamsArray.object(at: indexPath.row) as! NSDictionary)
        cell2.label1.text = (dataDict.value(forKey: "goals") as! String)
        cell2.label2.text = (dataDict.value(forKey: "won") as! String)
        cell2.label3.text = (dataDict.value(forKey: "lost") as! String)
        cell2.label4.text = (dataDict.value(forKey: "points") as! String)

        return cell2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 68
    }
     
     //MARK:- Api Callings
    func tournmentDetailsApiCalling()
    {
       SVProgressHUD.show()
        let details:[Any] = ["tournmentdetails",udf.value(forKey: "tID") as! String]
       ApiManager.shared().tournmentDetails(withDetails: details, success: { (NSURLSessionTask, responseObject) in
       let responseJSON:NSDictionary = responseObject as! NSDictionary
       print(responseJSON)
       SVProgressHUD.dismiss()
       let status:String = responseJSON.value(forKey: "status") as! String
       if status == "success" {
         self.dataDict = (responseJSON.value(forKey: "grounds") as! NSDictionary)
        self.teamName.text = (self.dataDict.value(forKey: "name") as! String)
        self.descLabel.text = (self.dataDict.value(forKey: "description") as! String)
        self.teamLabel.text = (self.dataDict.value(forKey: "team") as! String)
        self.statusLabel.text = "\("Status: ")\(self.dataDict.value(forKey: "status") as! String)"
        let rupee = "\u{20B9}"
        self.costLabel.text = "\("Entryfee: ")\(rupee) \((self.dataDict.value(forKey: "entryfee") as! String))"
        self.gardenLabel.text = (self.dataDict.value(forKey: "location") as! String)
        self.teamsArray = (self.dataDict.value(forKey: "teams") as! NSArray)
        if self.teamsArray.count > 0 {
            self.teamsView.alpha = 1.0
                self.teamNumberLabel.text = "\(self.teamsArray.count) \("Selected")"
        }else {
            self.teamsView.alpha = 0.0
        }
        let imgs = (self.dataDict.value(forKey: "image") as! NSArray)
        print(imgs)
//        for i in 0..<imgs.count {
//            let imgStrDict = (imgs.object(at: i) as! NSDictionary)
//            if (imgStrDict.value(forKey: "image") as! String) != "" {
//                let url = NSURL(string: (imgStrDict.value(forKey: "image") as! String))
//                if let data = try? Data(contentsOf: url! as URL)
//                {
//                    let image: UIImage = UIImage(data: data)!
//                    self.imagesArray.add(image as UIImage)
//                    print(self.imagesArray)
//                }
//                print(self.imagesArray)
//            }
//        }
//        if self.imagesArray.count == 0 {
//            self.imagesArray = self.images as! NSMutableArray
//        }
       
        /*
         {
             "status": "success",
             "grounds": {
                 description = "Corporate Cricket Tournament";
                 entryfee = 500;
                 favstatus = false;
                 id = 7;
                 image =         (
                                 {
                         image = "http://sampletemplates.net.in/facilitybooking/assets/image/tournments/22.png";
                     }
                 );
                 lat = "16.942360";
                 lng = "82.244621";
                 location = "Kakinada, Andhra Pradesh, India";
                 name = "Corporate Cricket Tournament";
                 status = "Tournament Not Started Yet";
                 team = 11vs11;
                 "teams": [
                     {
                         "id": "1",
                         "teamname": "test",
                         "goals": "10",
                         "won": "5",
                         "lost": "5",
                         "points": "10",
                         "lat": "16.9890648",
                         "lng": "82.24746479999999"
                     }
                 ]
             }
         }
         */
       }
       else if status == "failure" {
           self.presentAlert(withTitle: "Login", message: responseJSON.value(forKey: "message") as! String)
       }
       },failure: { (session, error) in
           print(error?.localizedDescription as Any)
           self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
           SVProgressHUD.dismiss()
       })
    }
    
    func favouriteApiCalling(_ favID: String)
    {
           SVProgressHUD.show()
        let details:[Any] = ["addremovefavourites",udf.value(forKey: "userID") as! String,favID]
           ApiManager.shared().favourite(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
            self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
            if (favID == "1") {
                self.favButton.setImage(UIImage(named: "fav"), for: .normal)
             }else {
                self.favButton.setImage(UIImage(named: "fav0"), for: .normal)
             }
           }
           else if status == "failure" {
               self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
           }
       },failure: { (session, error) in
           print(error?.localizedDescription as Any)
           self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
           SVProgressHUD.dismiss()
       })
    }
    
    //MARK:- Button Actions
    @IBAction func registerAction(_ sender: Any) {
        self.performSegue(withIdentifier: "registerpage", sender: nil)
    }
    
    @IBAction func favButton(_ sender: Any) {
        self.favouriteApiCalling(self.dataDict.value(forKey: "id") as! String)
    }
    
    @IBAction func shareButton(_ sender: Any) {
         let textToShare = (self.dataDict.value(forKey: "name") as! String)
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
    
    //MARK:- Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "registerpage") {
            let vc = segue.destination as! RegistrationViewController
            vc.teamString = self.teamLabel.text!
            vc.money = (self.dataDict.value(forKey: "entryfee") as! String)
        }
    }
}
