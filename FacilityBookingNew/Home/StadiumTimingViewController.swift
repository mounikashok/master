//
//  StadiumTimingViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/26/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit
import Razorpay

class StadiumTimingViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    private var razorpay:Razorpay?

    
    @IBOutlet weak var todayTimeLabel: UILabel!
    @IBOutlet  var mrngTme1: UIButton!
    @IBOutlet  var mrngTme2: UIButton!
    @IBOutlet  var mrngTme3: UIButton!
    @IBOutlet  var aftrnTme1: UIButton!
    @IBOutlet  var aftrnonTme3: UIButton!
    @IBOutlet  var aftrnonTme2: UIButton!
    @IBOutlet  var evngTme1: UIButton!
    @IBOutlet  var evngTme3: UIButton!
    @IBOutlet  var evngTme2: UIButton!
    @IBOutlet  var tbleViw: UITableView!
    @IBOutlet  var backViw: UIView!
    @IBOutlet  var scrlViw: UIView!
    @IBOutlet  var viw3: UIView!
    @IBOutlet  var collectioVw: UICollectionView!
    @IBOutlet  var viw: UIView!
    @IBOutlet  var viw2: UIView!
    @IBOutlet  var costField: UITextField!
    @IBOutlet  var peopleCollectionView: UICollectionView!
    var teamsArray: NSMutableArray = NSMutableArray()
    var teamStatusArray: NSMutableArray = NSMutableArray()
    var dataDict: NSDictionary! = nil


    var matchesListArray = ["9v9","7v7","8v8","5v5","4v4","3v3","2v2"]
    var matchStatusArray = ["0","0","0","0","0","0","0"]

    
    var mrg1 : Bool = false
    var mrg2 : Bool = false
    var mrg3 : Bool = false

    var aft1 : Bool = false
    var aft2 : Bool = false
    var aft3 : Bool = false

    var evg1 : Bool = false
    var evg2 : Bool = false
    var evg3 : Bool = false
    
    var mrgStr1 = ""
    var mrgStr2 = ""
    var mrgStr3 = ""

    var aftStr1 = ""
    var aftStr2 = ""
    var aftStr3 = ""

    var evgStr1 = ""
    var evgStr2 = ""
    var evgStr3 = ""
    
    var selCount: Int = 0


    
    var weekField = ["THU","FRI","SAT","SUN","MON","TUE","WED","THU","FRI","SAT","SUN"]
    var dateField1 = ["17","18","19","20","21","22","23","24","25","26","27"]
    
    var udf = UserDefaults()
    var teamID = ""
    var dateText = ""
    var month = ""
    var monthStr = ""

    var year = ""
    var timeSlotString = ""
    
    var currentDateString = ""
    
    var yearArray: NSMutableArray = NSMutableArray()
    var monthStringArray: NSMutableArray = NSMutableArray()
    var monthArray: NSMutableArray = NSMutableArray()
    var monthDateArray: NSMutableArray = NSMutableArray()
    var dateArray: NSMutableArray = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       shadw()
       collectioVw.delegate = self
       collectioVw.dataSource = self
        
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("Lahor Stadium", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
        
        //Getting Date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
        formatter.dateFormat = "yyyy"
        year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        month = formatter.string(from: date)
        
        formatter.dateFormat = "MMM"
        monthStr = formatter.string(from: date)
        
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        print(year, month, day) // 2018 12 24
        
        
        currentDateString = "\(year)\("-")\(month)\("-")\(day)"
        
      //  tbleViw.alpha = 0
        todayTimeLabel.text = "\("Today") \(day)\(monthStr)"
        costField.text = (udf.value(forKey: "Price") as! String)
        teamID = "1"
        
        
        self.gettingDateStrings(currentDateString)
        

    }
    
    //MARK:- gETTING sTRING
    func gettingDateStrings(_ str: String) {
        let dateStr          = str
        let formatter        = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let currDate         = formatter.date(from: dateStr)

        for i in 1...30
        {
            let interval = TimeInterval(60 * 60 * 24 * i)
            let newDate = currDate?.addingTimeInterval(interval)
            print(newDate!)
            let formatter1 = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let myString = formatter1.string(from: newDate!) // string purpose I add here
            // convert your string to date
            let yourDate = formatter1.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter1.dateFormat = "yyyy-MM-dd"
            // again convert your date to string
            let myStringafd = formatter1.string(from: yourDate!)
            print(myStringafd)
            
            
            
            
            formatter1.dateFormat = "yyyy"
            let year = formatter1.string(from: newDate!)
            yearArray.add(year)
            
            formatter1.dateFormat = "MMM"
            let monthStr = formatter1.string(from: newDate!)
            print(monthStr)
            monthDateArray.add(monthStr)
            
            formatter1.dateFormat = "MM"
            let month = formatter1.string(from: newDate!)
            monthArray.add(month)
            
            formatter1.dateFormat = "dd"
            let day = formatter1.string(from: newDate!)
            dateArray.add(day)
        }
        
        print(monthDateArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {

        self.teamsListApiCalling()
    }
    
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
    
    func shadw(){
        costField.layer.cornerRadius = 5
        costField.layer.masksToBounds = false
        costField.layer.shadowRadius = 3.0
        costField.layer.shadowColor = UIColor.black.cgColor
        costField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        costField.layer.shadowOpacity = 0.5
        viw.backgroundColor = UIColor.white
        viw.layer.shadowColor = UIColor.gray.cgColor
        viw.layer.shadowOpacity = 0.2
        viw.layer.borderWidth = 0.3
        viw.layer.borderColor = UIColor.gray.cgColor
        viw.layer.cornerRadius = 0
        viw.layer.shadowOffset = CGSize.zero
        viw.layer.shadowRadius = 2
        viw2.backgroundColor = UIColor.white
        viw2.layer.shadowColor = UIColor.gray.cgColor
        viw2.layer.shadowOpacity = 0.2
        viw2.layer.borderWidth = 0.3
        viw2.layer.borderColor = UIColor.gray.cgColor
        viw2.layer.cornerRadius = 0
        viw2.layer.shadowOffset = CGSize.zero
        viw2.layer.shadowRadius = 2
        
        viw3.backgroundColor = UIColor.white
        viw3.layer.shadowColor = UIColor.gray.cgColor
        viw3.layer.shadowOpacity = 0.2
        viw3.layer.borderWidth = 0.3
        viw3.layer.borderColor = UIColor.gray.cgColor
        viw3.layer.cornerRadius = 0
        viw3.layer.shadowOffset = CGSize.zero
        viw3.layer.shadowRadius = 2
        
        mrngTme1.layer.borderColor = UIColor.green.cgColor
        mrngTme1.layer.borderWidth = 1
        mrngTme2.layer.borderColor = UIColor.green.cgColor
        mrngTme2.layer.borderWidth = 1
        mrngTme3.layer.borderColor = UIColor.green.cgColor
        mrngTme3.layer.borderWidth = 1
        aftrnTme1.layer.borderColor = UIColor.green.cgColor
        aftrnTme1.layer.borderWidth = 1
        aftrnonTme2.layer.borderColor = UIColor.green.cgColor
        aftrnonTme2.layer.borderWidth = 1
        aftrnonTme3.layer.borderColor = UIColor.green.cgColor
        aftrnonTme3.layer.borderWidth = 1
        
        evngTme1.layer.borderColor = UIColor.green.cgColor
        evngTme1.layer.borderWidth = 1
        evngTme2.layer.borderColor = UIColor.green.cgColor
        evngTme2.layer.borderWidth = 1
        evngTme3.layer.borderColor = UIColor.green.cgColor
        evngTme3.layer.borderWidth = 1
        
        mrngTme1.titleLabel?.textColor = UIColor.green
        mrngTme2.titleLabel?.textColor = UIColor.green
        mrngTme3.titleLabel?.textColor = UIColor.green

        aftrnTme1.titleLabel?.textColor = UIColor.green
        aftrnonTme2.titleLabel?.textColor = UIColor.green
        aftrnonTme3.titleLabel?.textColor = UIColor.green

        evngTme1.titleLabel?.textColor = UIColor.green
        evngTme2.titleLabel?.textColor = UIColor.green
        evngTme3.titleLabel?.textColor = UIColor.green

    }

    //MARK:- CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if(collectionView == peopleCollectionView){
            return self.teamsArray.count
          }
          return monthDateArray.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           if(collectionView == peopleCollectionView) {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatdiumTimingCollectionViewCell", for: indexPath) as! StatdiumTimingCollectionViewCell
            dataDict = (self.teamsArray.object(at: indexPath.item) as! NSDictionary)
            print(dataDict as Dictionary)
            cell.weekField.text! = (dataDict.value(forKey: "name") as! String)
            if ((self.teamStatusArray.object(at: indexPath.item)) as! String).isEqual("0"){
                cell.selectionBtn.setImage(UIImage(named: "cirempty"), for: .normal)
            }else {
                cell.selectionBtn.setImage(UIImage(named: "ciremptyfill"), for: .normal)
            }
          return cell;
          }
           else {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatdiumTimingCollectionViewCell", for: indexPath) as! StatdiumTimingCollectionViewCell
            cell.weekField.text! = monthDateArray.object(at: indexPath.item) as! String
            cell.dateField.text! = dateArray.object(at: indexPath.item) as! String
              return cell;
          }
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
         self.teamStatusArray.removeAllObjects()
         for _ in 0..<self.teamsArray.count {
             self.teamStatusArray.add("0")
         }
         */
        if(collectionView == peopleCollectionView) {
            dataDict = (self.teamsArray.object(at: indexPath.item) as! NSDictionary)
            print(self.teamStatusArray.object(at: indexPath.item))

            if ((self.teamStatusArray.object(at: indexPath.item)) as! String).isEqual("0"){
                self.teamStatusArray.removeAllObjects()
                for _ in 0..<self.teamsArray.count {
                    self.teamStatusArray.add("0")
                }
                self.teamStatusArray.replaceObject(at: indexPath.item, with: "1")
            }else {
                self.teamStatusArray.removeAllObjects()
                for _ in 0..<self.teamsArray.count {
                    self.teamStatusArray.add("0")
                }
                self.teamStatusArray.replaceObject(at: indexPath.item, with: "0")
            }
            teamID = (dataDict.value(forKey: "id") as! String)
            print(self.teamStatusArray)
            self.peopleCollectionView.reloadData()
        }else {
            dateText = "\(yearArray.object(at: indexPath.item) as! String)\("-")\(monthArray.object(at: indexPath.item) as! String)\("-")\(dateArray.object(at: indexPath.item) as! String)"
            if let cell = collectionView.cellForItem(at: indexPath) as? StatdiumTimingCollectionViewCell {
                cell.backgroundColor = .lightGray
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? StatdiumTimingCollectionViewCell else {
                    return
            }
            cell.backgroundColor = .clear
        }
    
    //MARK:- Api Callings
    func teamsListApiCalling()
    {
           SVProgressHUD.show()
        let details:[Any] = ["teams"]
           ApiManager.shared().teams(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
            self.teamsArray = NSMutableArray(array: (responseJSON.value(forKey: "teams") as! NSArray))
            self.udf.set(self.teamsArray, forKey: "teamsArray")
            self.udf.synchronize()
            for _ in 0..<self.teamsArray.count {
                self.teamStatusArray.add("0")
            }
            self.peopleCollectionView.reloadData()
            
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
    
    func bookNowApiCalling()
    {
           SVProgressHUD.show()
        let details:[Any] = ["booknow",udf.value(forKey: "userID") as! String,udf.value(forKey: "groundID") as! String,dateText,timeSlotString,teamID,self.costField.text!]
           ApiManager.shared().bookNow(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
            let bookingID = responseJSON.value(forKey: "bookingid") as! Int
            self.udf.setValue(String(bookingID), forKey: "bookingID")
            self.udf.synchronize()
            //For Payment
             let options: [String:Any] = [
                 "amount" : self.costField.text!, //mandatory in paise like:- 1000 paise ==  10 rs
                 "description": "purchase description",
                 "image": "ss",
                 "name": (self.udf.value(forKey: "name") as! String),
                 "prefill": [
                 "contact": (self.udf.value(forKey: "phone") as! String),
                 "email": (self.udf.value(forKey: "email") as! String)
                 ],
                 "theme": [
                     "color": "#F37254"
                 ]
             ]
            self.razorpay?.open(options)
            // self.performSegue(withIdentifier: "book2", sender: nil)
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
    @IBAction func payNowAction(_ sender: Any) {
        timeSlotString = "\(mrgStr1)\(",")\(mrgStr2)\(",")\(mrgStr3)\(",")\(aftStr1)\(",")\(aftStr2)\(",")\(aftStr3)\(",")\(evgStr1) \(evgStr2)\(",")\(evgStr3)"
        if dateText == "" {
            self.presentAlert(withTitle: "", message: "Please select Date")
        }else if mrgStr1 == "" && mrgStr2 == "" && mrgStr3 == "" && aftStr1 ==
        "" && aftStr2 == "" && aftStr3 == "" && evgStr1 == "" && evgStr2 == "" && evgStr3 == ""{
            self.presentAlert(withTitle: "", message: "Please select Time Slot")
        }
        else if (self.costField.text!.isEmpty) {
            self.presentAlert(withTitle: "", message: "Please enter cost")
        }else {
            timeSlotString = timeSlotString.replacingOccurrences(of: ",,", with: "")
            self.bookNowApiCalling()
        }
    }
    
    @IBAction func closebtn(_ sender: Any) {
        tbleViw.alpha = 0
    }
    
    @IBAction func mrngTmeAction(_ sender: UIButton) {
        tbleViw.alpha = 1
        if sender.tag == 1 {
            if mrg1 == false {
                mrg1 = true
                mrngTme1.layer.borderColor = UIColor.red.cgColor
                mrngTme1.titleLabel?.textColor = UIColor.red
                mrgStr1 = self.mrngTme1.titleLabel!.text!
                selCount = selCount + 1
            }else {
                mrg1 = false
                mrngTme1.layer.borderColor = UIColor.green.cgColor
                mrngTme1.titleLabel?.textColor = UIColor.green
                mrgStr1 = ""
                selCount = selCount - 1
            }
        }else if sender.tag == 2 {
            if mrg2 == false {
                mrg2 = true
                mrngTme2.layer.borderColor = UIColor.red.cgColor
                mrngTme2.titleLabel?.textColor = UIColor.red
                mrgStr2 = self.mrngTme2.titleLabel!.text!
                selCount = selCount + 1


            }else {
                mrg2 = false
                mrngTme2.layer.borderColor = UIColor.green.cgColor
                mrngTme2.titleLabel?.textColor = UIColor.green
                mrgStr2 = self.mrngTme2.titleLabel!.text!
                selCount = selCount - 1

            }
        }else if sender.tag == 3 {
            if mrg3 == false {
                mrg3 = true
                mrngTme3.layer.borderColor = UIColor.red.cgColor
                mrngTme3.titleLabel?.textColor = UIColor.red
                mrgStr3 = self.mrngTme3.titleLabel!.text!
                selCount = selCount + 1

            }else {
                mrg3 = false
                mrngTme3.layer.borderColor = UIColor.green.cgColor
                mrngTme3.titleLabel?.textColor = UIColor.green
                mrgStr3 = self.mrngTme3.titleLabel!.text!
                selCount = selCount - 1

            }
        }else if sender.tag == 4 {
            if aft1 == false {
                aft1 = true
                aftrnTme1.layer.borderColor = UIColor.red.cgColor
                aftrnTme1.titleLabel?.textColor = UIColor.red
                aftStr1 = self.aftrnTme1.titleLabel!.text!
                selCount = selCount + 1


            }else {
                aft1 = false
                aftrnTme1.layer.borderColor = UIColor.green.cgColor
                aftrnTme1.titleLabel?.textColor = UIColor.green
                aftStr1 = ""
                selCount = selCount - 1

            }
        }else if sender.tag == 5 {
            if aft2 == false {
                aft2 = true
                aftrnonTme2.layer.borderColor = UIColor.red.cgColor
                aftrnonTme2.titleLabel?.textColor = UIColor.red
                aftStr2 = self.aftrnonTme2.titleLabel!.text!
                selCount = selCount + 1

            }else {
                aft2 = false
                aftrnonTme2.layer.borderColor = UIColor.green.cgColor
                aftrnonTme2.titleLabel?.textColor = UIColor.green
                aftStr2 = ""
                selCount = selCount - 1

            }
        }else if sender.tag == 6 {
            if aft3 == false {
                aft3 = true
                aftrnonTme3.layer.borderColor = UIColor.red.cgColor
                aftrnonTme3.titleLabel?.textColor = UIColor.red
                aftStr3 = self.aftrnonTme3.titleLabel!.text!
                selCount = selCount + 1

            }else {
                aft3 = false
                aftrnonTme3.layer.borderColor = UIColor.green.cgColor
                aftrnonTme3.titleLabel?.textColor = UIColor.green
                aftStr3 = ""
                selCount = selCount - 1

            }
        }
        else if sender.tag == 7 {
            if evg1 == false {
                evg1 = true
                evngTme1.layer.borderColor = UIColor.red.cgColor
                evngTme1.titleLabel?.textColor = UIColor.red
                evgStr1 = self.evngTme1.titleLabel!.text!
                selCount = selCount + 1

            }else {
                evg1 = false
                evngTme1.layer.borderColor = UIColor.green.cgColor
                evngTme1.titleLabel?.textColor = UIColor.green
                evgStr1 = ""
                selCount = selCount - 1
            }
        }else if sender.tag == 8 {
            if evg2 == false {
                evg2 = true
                evngTme2.layer.borderColor = UIColor.red.cgColor
                evngTme2.titleLabel?.textColor = UIColor.red
                evgStr2 = self.evngTme2.titleLabel!.text!
                selCount = selCount + 1
            }else {
                evg2 = false
                evngTme2.layer.borderColor = UIColor.green.cgColor
                evngTme2.titleLabel?.textColor = UIColor.green
                evgStr2 = ""
                selCount = selCount - 1

            }
        }else if sender.tag == 9 {
            if evg3 == false {
                evg3 = true
                evngTme3.layer.borderColor = UIColor.red.cgColor
                evngTme3.titleLabel?.textColor = UIColor.green
                evgStr3 = self.evngTme3.titleLabel!.text!
                selCount = selCount + 1
            }else {
                evg3 = false
                evngTme3.layer.borderColor = UIColor.green.cgColor
                evngTme3.titleLabel?.textColor = UIColor.green
                evgStr3 = ""
                selCount = selCount - 1
            }
        }
    }
    
    @IBAction func peopelBtnAction(_ sender: UIButton) {
        if sender.tag == 10 {
            teamID = "1"
        }else if sender.tag == 11 {
            teamID = "2"
        }
    }

}
