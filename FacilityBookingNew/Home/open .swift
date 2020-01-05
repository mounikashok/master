//
//  HomeViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/24/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, MyDataSendingDelegateProtocol {

    
    @IBOutlet  var homeTV: UITableView!
    @IBOutlet  var vw: UIView!
    
    var udf = UserDefaults.standard
    var loginDict: NSDictionary!
    var groundsArray: NSMutableArray = NSMutableArray()
    var seachGroundsArray: NSMutableArray = NSMutableArray()
    var images: [UIImage]!
    var  imagesArray: NSMutableArray = NSMutableArray()
    var  searchImagesArray: NSMutableArray = NSMutableArray()
    var searchornot: Bool = false
    var dataDict: NSDictionary! = nil
    var groundID = ""
    var searchListArray: NSMutableArray = [];
    @IBOutlet var searchBar:UISearchBar!
    var issearch = false

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                 issearch = true
                 searchListArray.removeAllObjects()
                 print("searchText \(searchText)")
                 issearch = true
                 let resultPredicate = NSPredicate(format: "name contains[c]         %@", searchText)
                 //var recipes : NSArray = NSArray()
                 let array = groundsArray.filtered(using: resultPredicate) as NSArray
                 if(array.count != 0)
                 {
                 searchListArray = array.mutableCopy() as! NSMutableArray
                 }
                 print("names = ,\(searchListArray)");
                 if(searchText.count == 0)
                 {
                     issearch = false
                 }
                 else{
                     issearch = true
                 }
                 self.homeTV.reloadData()
             }
             
             func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                 print("searchText \(searchBar.text ?? "")")
                 issearch = false
                 self.homeTV.reloadData()
             }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTV.delegate = self
        homeTV.dataSource = self
        searchBar.delegate = self
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "notification"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        btn1.addTarget(self, action: #selector(addCartMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1] , animated: true)
        
        vw.layer.shadowColor = UIColor.darkGray.cgColor
        vw.layer.shadowOpacity = 1.5
        vw.layer.shadowOffset = CGSize.zero
        vw.layer.shadowRadius = 3
        vw.layer.cornerRadius = 8.0
  }
    @objc func addCartMethod(){
           self.performSegue(withIdentifier: "notify", sender: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        if udf.value(forKey: "loginDict") != nil {
            loginDict = (udf.value(forKey: "loginDict") as! NSDictionary)
          //  groundsArray = (loginDict.value(forKey: "grounds") as! NSArray) as! NSMutableArray
            groundsArray = NSMutableArray(array: (loginDict.value(forKey: "grounds") as! NSArray))
            homeTV.reloadData()
        }
        self.homeApiCalling()
        print(groundsArray as NSArray)
    }
    
    // Delegate Method
    func sendDataToFirstViewController(myData: NSArray) {
        groundsArray = myData as! NSMutableArray
    }
    
    //MARK:- Searchbar Delegate Methods
    private func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }

    private func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    private func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false

        // Remove focus from the search bar.
        searchBar.endEditing(true)

        // Perform any necessary work.  E.g., repopulating a table view
        // if the search bar performs filtering.
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print(searchBar.text!)
//        searchBar.text = searchBar.text?.replacingOccurrences(of: " ", with: "")
//        if (searchBar.text!.isEmpty) {
//            self.searchornot = false
//            self.homeTV.reloadData()
//            searchBar.resignFirstResponder() // hides the keyboard.
//        }else {
//            searchBar.resignFirstResponder() // hides the keyboard.
//            self.searchApiCalling(searchBar.text!)
//        }
//    }

    
    //MARK:- Slider Delegate Method
    func itemPressedAtIndex(index: Int) {
        
    }

    
 //MARK:- Api Callings
    func homeApiCalling()
    {
           SVProgressHUD.show()
        let details:[Any] = ["grounds",udf.value(forKey: "userID") as! String]
           ApiManager.shared().home(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
            self.groundsArray = NSMutableArray(array: (responseJSON.value(forKey: "grounds") as! NSArray))
                self.homeTV.reloadData()
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
            self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
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
    //Search Api
    func searchApiCalling(_ text: String)
    {
           SVProgressHUD.show()
           let details:[Any] = ["searchgrounds",udf.value(forKey: "userID") as! String, text]
           ApiManager.shared().search(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
            self.searchornot = true
           if status == "success" {
                self.seachGroundsArray = (responseJSON.value(forKey: "grounds") as! NSMutableArray)
                self.homeTV.reloadData()
           }
           else if status == "error" {
               self.homeTV.reloadData()
               self.presentAlert(withTitle: "Grounds", message: responseJSON.value(forKey: "message") as! String)
           }
       },failure: { (session, error) in
           print(error?.localizedDescription as Any)
           self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
           SVProgressHUD.dismiss()
       })
    }
    
    //MARK:- TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(issearch)
        {
            return  self.searchListArray.count
        }
        return groundsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath as IndexPath) as! HomeTableViewCell
         if(issearch){
            dataDict =  self.searchListArray[indexPath.row] as! NSDictionary
             }else {
            dataDict = (groundsArray.object(at: indexPath.row) as! NSDictionary)
        }
        cell.bookNowBtn.tag = indexPath.row
        cell.favouriteBtn.tag = indexPath.row
        cell.bookNowBtn.addTarget(self, action: #selector(wshlisteMethod),  for: .touchUpInside)
        cell.favouriteBtn.addTarget(self, action: #selector(favBtnAction), for: .touchUpInside)
        print(dataDict as Any)
        let rupee = "\u{20B9}"
        cell.stadiumName.text = (dataDict.value(forKey: "name") as! String)
        cell.locationName.text = (dataDict.value(forKey: "location") as! String)
        cell.costLbl.text = "\(rupee) \((dataDict.value(forKey: "costperhour") as! String)) \("/ Per hour")"
        if (dataDict.value(forKey: "avgrating") as! String) == "" {
            cell.ratingsLbl.text = "0"
        }else {
            cell.ratingsLbl.text = (dataDict.value(forKey: "avgrating") as! String)
        }
        cell.reviewsLbl.text = "(\(dataDict.value(forKey: "totalpersons") as! Int) \("Reviews"))"
        if (dataDict.value(forKey: "favstatus") as! String) == "true" {
            cell.favouriteBtn.setImage(UIImage(named: "favo"), for: .normal)
        }else {
            cell.favouriteBtn.setImage(UIImage(named: "fav"), for: .normal)
        }
        DispatchQueue.main.async{
            cell.imgPage.sd_setImage(with: URL(string: (self.dataDict.value(forKey: "image") as! String)))
        }
        cell.borderView.layer.shadowColor = UIColor.darkGray.cgColor
        cell.borderView.layer.shadowOpacity = 3
        cell.borderView.layer.shadowOffset = CGSize.zero
        cell.borderView.layer.shadowRadius = 5
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    @objc func wshlisteMethod(sender: UIButton){
        if searchornot == true {
            dataDict = (seachGroundsArray.object(at: sender.tag) as! NSDictionary)
        }else {
            dataDict = (groundsArray.object(at: sender.tag) as! NSDictionary)
        }
        groundID = (dataDict.value(forKey: "id") as! String)
        self.performSegue(withIdentifier: "book", sender: nil)
    }

    @objc func favBtnAction(_ sender : UIButton) {
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        self.homeTV.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        let cell = self.homeTV.cellForRow(at: selectedIndex) as! HomeTableViewCell
        if searchornot == true {
            dataDict = (seachGroundsArray.object(at: sender.tag) as! NSDictionary)
        }else {
            dataDict = (groundsArray.object(at: sender.tag) as! NSDictionary)
        }
        var mutableDataDict: NSMutableDictionary = NSMutableDictionary()
        mutableDataDict = dataDict.mutableCopy() as! NSMutableDictionary

        if (dataDict.value(forKey: "favstatus") as! String) == "true" {
            cell.favouriteBtn.setImage(UIImage(named: "fav"), for: .normal)
            mutableDataDict.removeObject(forKey: "favstatus")
            mutableDataDict.setValue("false", forKey: "favstatus")
            groundsArray.removeObject(at: sender.tag)
            groundsArray.insert(mutableDataDict, at: sender.tag)
        }else {
            cell.favouriteBtn.setImage(UIImage(named: "fav0"), for: .normal)
            mutableDataDict.removeObject(forKey: "favstatus")
            mutableDataDict.setValue("true", forKey: "favstatus")
            groundsArray.removeObject(at: sender.tag)
            groundsArray.insert(mutableDataDict, at: sender.tag)
        }
    //    groundsArray.replaceObject(at: sender.tag, with: mutableDataDict)

        self.homeTV.reloadRows(at: [selectedIndex], with: .none)
        //Calling Favourite Api
        self.favouriteApiCalling(dataDict.value(forKey: "id") as! String)

    }
    
    //MARK:- Button Actions
    @IBAction func filtrAction(_ sender: Any) {
        self.performSegue(withIdentifier: "filter", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "book") {
            let vc = segue.destination as! BookViewController
            vc.groundID = groundID
        }
    }
    
}

extension UISearchBar {

    var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        return (subViews.filter { $0 is UITextField }).first as? UITextField
    }
}



