//
//  BookViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/26/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit
import GoogleMaps

class BookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func itemPressedAtIndex(index: Int) {
        
    }
    @IBOutlet weak var bookTV: UITableView!
    var udf = UserDefaults.standard
    var images: [UIImage]!
    var groundID = ""
    var dataDict: NSDictionary!
    var array: NSArray = NSArray()
    var reviewsArray: NSArray = NSArray()
    var imageArray = [UIImage]()
    var imagesArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        bookTV.delegate = self
        bookTV.dataSource = self
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("Booking", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.groundDetailApiCalling()
    }
    
    //MARK:- TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.array.count
        }else {
            return self.reviewsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath as IndexPath) as! BookTableViewCell
            cell.selectionStyle = .none
            cell.stadiumName.text = (dataDict.value(forKey: "name") as! String)
            let rupee = "\u{20B9}"
            cell.stadiumName.text = (dataDict.value(forKey: "name") as! String)
            cell.locationLabel.text = (dataDict.value(forKey: "location") as! String)
            cell.costLabel.text = "\(rupee) \((dataDict.value(forKey: "costperhour") as! String)) \("Per day")"
            if dataDict.value(forKey: "avgrating") == nil || (dataDict.value(forKey: "avgrating") is NSNull){
                cell.rateLabel.text = "0"
            }else {
                cell.rateLabel.text = (dataDict.value(forKey: "avgrating") as! String)
            }
            cell.reviewLabel.text = "\(dataDict.value(forKey: "totalpersons") as! Int) \("Reviews")"
            if (dataDict.value(forKey: "favstatus") as! String) == "true" {
                cell.reviewButton.setImage(UIImage(named: "favo"), for: .normal)
            }else {
                cell.reviewButton.setImage(UIImage(named: "fav"), for: .normal)
            }
            cell.reviewButton.addTarget(self, action: #selector(favBtnAction), for: .touchUpInside)
            cell.topDeskLabel.text = (dataDict.value(forKey: "description") as! String)

            let lat = Double((dataDict.value(forKey: "lat") as! String))
            let long = Double((dataDict.value(forKey: "lng") as! String))

            let latitude: CLLocationDegrees = lat!
            let longitude: CLLocationDegrees = long!

//            let location: CLLocation = CLLocation(latitude: latitude,
//              longitude: longitude)
            
            
            cell.mapView.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 6.0)
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            marker.title = cell.stadiumName.text
            marker.snippet = cell.locationLabel.text
            marker.icon = UIImage(named: "favo") // Marker icon
            marker.map = cell.mapView
            
// Adding Images
            let imgs = (dataDict.value(forKey: "image") as! NSArray)
            print(imgs)
            for i in 0..<imgs.count {
                let imgStrDict = (imgs.object(at: i) as! NSDictionary)
                if (imgStrDict.value(forKey: "image") as! String) != "" {
                    let url = NSURL(string: (imgStrDict.value(forKey: "image") as! String))
                    if let data = try? Data(contentsOf: url! as URL)
                    {
                        let image: UIImage = UIImage(data: data)!
                        self.imagesArray.add(image as UIImage)
                        print(self.imagesArray)
                    }
                    print(self.imagesArray)
                }
            }
            if imagesArray.count == 0 {
                imagesArray = images as! NSMutableArray
            }
            return cell
        }else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath as IndexPath) as! BookTableViewCell
            cell2.img.layer.cornerRadius = cell2.img.frame.height/2
            cell2.selectionStyle = .none
            print(reviewsArray)
            let reviewDict = reviewsArray.object(at: indexPath.row) as! NSDictionary
            cell2.nameField.text = (reviewDict.value(forKey: "username") as! String)
            cell2.dateLabel.text = (reviewDict.value(forKey: "date") as! String)
            cell2.descTxtview.text = (reviewDict.value(forKey: "review") as! String)
            cell2.star1Img.image = UIImage(named: "y1star")
            cell2.star2Img.image = UIImage(named: "y1star")
            cell2.star3Img.image = UIImage(named: "y1star")
            cell2.star4Img.image = UIImage(named: "y1star")
            cell2.star5Img.image = UIImage(named: "y1star")

            let rating = (reviewDict.value(forKey: "rating") as! String)
            if rating == "1" {
                cell2.star1Img.image = UIImage(named: "y1star")
            }else if rating == "2" {
                cell2.star1Img.image = UIImage(named: "y1star")
                cell2.star2Img.image = UIImage(named: "y1star")
            }else if rating == "3" {
                cell2.star1Img.image = UIImage(named: "y1star")
                cell2.star2Img.image = UIImage(named: "y1star")
                cell2.star3Img.image = UIImage(named: "y1star")
            }else if rating == "4" {
                cell2.star1Img.image = UIImage(named: "y1star")
                cell2.star2Img.image = UIImage(named: "y1star")
                cell2.star3Img.image = UIImage(named: "y1star")
                cell2.star4Img.image = UIImage(named: "y1star")
            }else if rating == "5" {
                cell2.star1Img.image = UIImage(named: "y1star")
                cell2.star2Img.image = UIImage(named: "y1star")
                cell2.star3Img.image = UIImage(named: "y1star")
                cell2.star4Img.image = UIImage(named: "y1star")
                cell2.star5Img.image = UIImage(named: "y1star")
            }
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 590
        }
        else
        {
            return 150
        }
    }
    
    //MARK:- Api Callings
       func groundDetailApiCalling()
       {
              SVProgressHUD.show()
           let details:[Any] = ["grounddetail",udf.value(forKey: "userID") as! String,groundID]
              ApiManager.shared().groundDetails(withDetails: details, success: { (NSURLSessionTask, responseObject) in
              let responseJSON:NSDictionary = responseObject as! NSDictionary
              print(responseJSON)
              SVProgressHUD.dismiss()
              let status:String = responseJSON.value(forKey: "status") as! String
              if status == "success" {
                self.dataDict = (responseJSON.value(forKey: "grounds") as! NSDictionary)
                self.array = NSArray.init(object: self.dataDict as NSDictionary)
                self.reviewsArray = self.dataDict.value(forKey: "reviews") as! NSArray
                print(self.dataDict.count)
                /*
                 {
                     grounds =     {
                         avgrating = "<null>";
                         costperhour = 100;
                         description = 100100100100100;
                         favstatus = false;
                         id = 22;
                         image = "http://sampletemplates.net.in/facilitybooking/assets/image/grounds/Priyanka_Chopra52.jpg,http://sampletemplates.net.in/facilitybooking/assets/image/grounds/Priyanka_Chopra43.jpg,http://sampletemplates.net.in/facilitybooking/assets/image/grounds/Priyanka_Chopra33.jpg,http://sampletemplates.net.in/facilitybooking/assets/image/grounds/Priyanka_Chopra23.jpg";
                         lat = "16.9890648";
                         lng = "82.24746479999999";
                         location = "Kakinada, Andhra Pradesh, India";
                         name = "siva Play ground1111";
                         reviews =         (
                         );
                         totalpersons = 0;
                     };
                     status = success;
                 }
                 */
                self.bookTV.reloadData()
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
             var mutableDataDict: NSMutableDictionary = NSMutableDictionary()
            let selectedIndex = IndexPath(row: 0, section: 0)
            self.bookTV.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
            let cell = self.bookTV.cellForRow(at: selectedIndex) as! BookTableViewCell
            mutableDataDict = NSMutableDictionary(dictionary: self.dataDict!)
            if (self.dataDict.value(forKey: "favstatus") as! String) == "true" {
                 cell.reviewButton.setImage(UIImage(named: "fav"), for: .normal)
                 mutableDataDict.removeObject(forKey: "favstatus")
                 mutableDataDict.setValue("false", forKey: "favstatus")
             }else {
                 cell.reviewButton.setImage(UIImage(named: "fav0"), for: .normal)
                 mutableDataDict.removeObject(forKey: "favstatus")
                 mutableDataDict.setValue("true", forKey: "favstatus")
             }
            self.dataDict = mutableDataDict as NSDictionary
            self.bookTV.reloadData()
            self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
           }
           else if status == "error" {
               self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
           }
       },failure: { (session, error) in
           print(error?.localizedDescription as Any)
           self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
           SVProgressHUD.dismiss()
       })
    }
    
    //MARK:- Button Actions
    @objc func favBtnAction(_ sender : UIButton) {
        //Calling Favourite Api
        self.favouriteApiCalling(dataDict.value(forKey: "id") as! String)
    }
    
    @objc func backMethod() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookNowAction(_ sender: Any) {
        udf.setValue(groundID, forKey: "groundID")
        udf.setValue((dataDict.value(forKey: "costperhour") as! String), forKey: "Price")
        udf.synchronize()
        self.performSegue(withIdentifier: "book1", sender: nil)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        if dataDict != nil {
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
    }
}
