//
//  BookingsViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit
class BookingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet  var bookngTV: UITableView!
    var udf = UserDefaults.standard
    var images: [UIImage]!
    var groundID = ""
    var dataDict: NSDictionary!
    var bookingsArray: NSMutableArray = NSMutableArray()
    var imagesArray: NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        bookngTV.delegate = self
        bookngTV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bookingsApiCalling()
    }
    
    //MARK:- TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingsTableViewCell", for: indexPath as IndexPath) as! BookingsTableViewCell
        cell.viw.addBorders()
        
        dataDict = (bookingsArray.object(at: indexPath.row) as! NSDictionary)
        cell.nameLabel.text = (dataDict.value(forKey: "name") as! String)
        cell.fromDateLabel.text = (dataDict.value(forKey: "bookeddate") as! String)
        cell.toDateLabel.text = (dataDict.value(forKey: "bookeddate") as! String)
        let rupee = "\u{20B9}"
        cell.costLabel.text = "\(rupee) \((dataDict.value(forKey: "price") as! String)) \("Per day")"
        DispatchQueue.main.async{
            cell.imgView.sd_setImage(with: URL(string: (self.dataDict.value(forKey: "image") as! String)))
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 295
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataDict = (bookingsArray.object(at: indexPath.row) as! NSDictionary)
        self.bookingsDetailsApiCalling((dataDict.value(forKey: "id") as! String))
    }
    
    func itemPressedAtIndex(index: Int) {
        
    }
    
    //MARK:- Api Callings
   func bookingsApiCalling()
   {
          SVProgressHUD.show()
       let details:[Any] = ["mybookings",udf.value(forKey: "userID") as! String]
          ApiManager.shared().home(withDetails: details, success: { (NSURLSessionTask, responseObject) in
          let responseJSON:NSDictionary = responseObject as! NSDictionary
          print(responseJSON)
          SVProgressHUD.dismiss()
          let status:String = responseJSON.value(forKey: "status") as! String
          if status == "success" {
           self.bookingsArray = NSMutableArray(array: (responseJSON.value(forKey: "bookings") as! NSArray))
               self.bookngTV.reloadData()
          }
          else if status == "failure" {
              self.presentAlert(withTitle: "Login", message: responseJSON.value(forKey: "message") as! String)
          }
          else{
             self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
            }
      },failure: { (session, error) in
          print(error?.localizedDescription as Any)
          self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
          SVProgressHUD.dismiss()
      })
   }
    
    func bookingsDetailsApiCalling(_ str: String)
    {
           SVProgressHUD.show()
        let details:[Any] = ["bookingdetails",str]
           ApiManager.shared().home(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
            self.bookingsArray = NSMutableArray(array: (responseJSON.value(forKey: "bookings") as! NSArray))
                self.bookngTV.reloadData()
           }
           else if status == "failure" {
               self.presentAlert(withTitle: "Login", message: responseJSON.value(forKey: "message") as! String)
           }
           else{
              self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
             }
       },failure: { (session, error) in
           print(error?.localizedDescription as Any)
           self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
           SVProgressHUD.dismiss()
       })
    }
    
}
