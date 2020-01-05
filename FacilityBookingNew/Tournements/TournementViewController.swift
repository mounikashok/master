//
//  TournementViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit
class TournementViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func itemPressedAtIndex(index: Int) {
    }
    
    @IBOutlet  var tournmentTV: UITableView!
    var udf = UserDefaults.standard
    var images: [UIImage]!
    var tourmentsArray: NSArray = NSArray()
    var imagesArray = NSMutableArray()
    var dataDict: NSDictionary!
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tournmentTV.delegate = self
        tournmentTV.dataSource = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tournmentApiCalling()
    }
    
    //MARK:- TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tourmentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TournementTableViewCell", for: indexPath as IndexPath) as! TournementTableViewCell

        cell.viewBtn.tag = indexPath.row
      //  cell.btn.tag = indexPath.row

        cell.viewBtn.addTarget(self, action: #selector(viewMethod),  for: .touchUpInside)
      //  cell.btn.addTarget(self, action: #selector(wshlisteMethod), for: .touchUpInside)
        cell.selectionStyle = .none
        
        dataDict = (self.tourmentsArray.object(at: indexPath.row) as! NSDictionary)
        cell.stadiumNameLabel.text = (dataDict.value(forKey: "name") as! String)
        cell.teamLabel.text = (dataDict.value(forKey: "team") as! String)
        cell.feeLabel.text = NSString(format: "₹%@",(dataDict.value(forKey: "entryfee") as! String)) as String
        DispatchQueue.main.async{
            cell.imgView.sd_setImage(with: URL(string: (self.dataDict.value(forKey: "image") as! String)))
        }
        cell.imageView?.layer.masksToBounds = true
        cell.borderView.layer.shadowColor = UIColor.darkGray.cgColor
        cell.borderView.layer.shadowOpacity = 3
        cell.borderView.layer.shadowOffset = CGSize.zero
        cell.borderView.layer.shadowRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 259
    }
    
    @objc func viewMethod(_ sender : UIButton) {
        dataDict = (self.tourmentsArray.object(at: sender.tag) as! NSDictionary)
        self.udf.set((dataDict.value(forKey: "id") as! String), forKey: "tID")
        self.udf.synchronize()
        self.performSegue(withIdentifier: "ipl", sender: nil)
    }
    
    private func fetchImage(_ photoURL: URL?) {

        guard let imageURL = photoURL else { return  }

        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let imageData: Data = try Data(contentsOf: imageURL)

                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.imagesArray.add(image!)
                }
            }catch{
                print("Unable to load data: \(error)")
            }
        }
    }
    
    //MARK:- Api Callings
   func tournmentApiCalling()
   {
      SVProgressHUD.show()
      let details:[Any] = ["tournments"]
      ApiManager.shared().tournment(withDetails: details, success: { (NSURLSessionTask, responseObject) in
      let responseJSON:NSDictionary = responseObject as! NSDictionary
      print(responseJSON)
      SVProgressHUD.dismiss()
      let status:String = responseJSON.value(forKey: "status") as! String
      if status == "success" {
        self.tourmentsArray = (responseJSON.value(forKey: "grounds") as! NSArray)
        self.tournmentTV.reloadData()
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

    //MARK:- Button Actions
    @objc func wshlisteMethod(){
        self.performSegue(withIdentifier: "ipl", sender: nil)
    }
}

