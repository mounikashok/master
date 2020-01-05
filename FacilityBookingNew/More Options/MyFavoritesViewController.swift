//
//  MyFavoritesViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class MyFavoritesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func itemPressedAtIndex(index: Int) {
        
    }
    
    var groundsArray: NSMutableArray = NSMutableArray()
    @IBOutlet  var myFavoritesTV: UITableView!
    var dataDict: NSDictionary! = nil
    var udf = UserDefaults()
    var groundID = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
       myFavoritesTV.delegate = self
        myFavoritesTV.dataSource = self
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("My Favorites", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favApiCalling()
    }
    
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groundsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath as IndexPath) as! HomeTableViewCell
        dataDict = (self.groundsArray.object(at: indexPath.row) as! NSDictionary)
        cell.bookNowBtn.tag = indexPath.row
        cell.favouriteBtn.tag = indexPath.row
        cell.bookNowBtn.addTarget(self, action: #selector(wshlisteMethod),  for: .touchUpInside)
        cell.favouriteBtn.addTarget(self, action: #selector(favBtnAction), for: .touchUpInside)
        cell.bookNowBtn.setTitle("Rebook", for: .normal)
        print(dataDict as NSDictionary)
        let rupee = "\u{20B9}"
        cell.stadiumName.text = (dataDict.value(forKey: "name") as! String)
        cell.locationName.text = (dataDict.value(forKey: "location") as! String)
        cell.costLbl.text = "\("Cost: ")\(rupee) \((dataDict.value(forKey: "costperhour") as! String)) \("Per day")"
        if (dataDict.value(forKey: "avgrating") as! String) == "" {
            cell.ratingsLbl.text = "0"
        }else {
            cell.ratingsLbl.text = (dataDict.value(forKey: "avgrating") as! String)
        }
        cell.reviewsLbl.text = "\(dataDict.value(forKey: "totalpersons") as! Int) \("Reviews")"
        if (dataDict.value(forKey: "favstatus") as! String) == "true" {
            cell.favouriteBtn.setImage(UIImage(named: "favo"), for: .normal)
        }else {
            cell.favouriteBtn.setImage(UIImage(named: "fav"), for: .normal)
        }
        cell.selectionStyle = .none
        DispatchQueue.main.async{
            cell.imgPage.sd_setImage(with: URL(string: (self.dataDict.value(forKey: "image") as! String)))
        }
        cell.imageView?.layer.masksToBounds = true
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
    
    @objc func wshlisteMethod(sender: UIButton){
               dataDict = (groundsArray.object(at: sender.tag) as! NSDictionary)
           groundID = (dataDict.value(forKey: "id") as! String)
           self.performSegue(withIdentifier: "book", sender: nil)
       }
       
   @objc func favBtnAction(_ sender : UIButton) {
       dataDict = (groundsArray.object(at: sender.tag) as! NSDictionary)       //Calling Favourite Api
    print(dataDict as Any)
       self.favouriteApiCalling(dataDict.value(forKey: "gid") as! String)
    }

    
    //MARK:- ApiCallings
    func favApiCalling() {
            SVProgressHUD.show()
         let details:[Any] = ["favourites",udf.value(forKey: "userID") as! String]
            ApiManager.shared()?.getFavouriteApi(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:String = responseJSON.value(forKey: "status") as! String
                self.groundsArray.removeAllObjects()
            if status == "success" {
                self.groundsArray = NSMutableArray(array: (responseJSON.value(forKey: "grounds") as! NSArray))
            }
            else if status == "failure" {
                self.presentAlert(withTitle: "Login", message: responseJSON.value(forKey: "message") as! String)
            }
            else{
                self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
            }
            self.myFavoritesTV.reloadData()

        },failure: { (session, error) in
            print(error?.localizedDescription as Any)
            self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
            SVProgressHUD.dismiss()
        })
    }
    
    //Fav Api
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
                self.favApiCalling()
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
