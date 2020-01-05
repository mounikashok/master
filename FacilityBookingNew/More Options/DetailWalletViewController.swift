//
//  DetailWalletViewController.swift
//  FacilityBooking
//
//  Created by revansh on 12/19/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class DetailWalletViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {

    @IBOutlet  var walletTV: UITableView!
    var transactionArray: NSArray = NSArray()
    var price = ["100","200","500","1000"]
       var img = ["sport","2","sport","2"]
    let dataDict: NSDictionary! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        walletTV.delegate = self
        walletTV.dataSource = self
        
         let btn1 = UIButton(type: .custom)
               btn1.setImage(UIImage(named: "back"), for: .normal)
               btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
               btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
               let item1 = UIBarButtonItem(customView: btn1)
               let home = UIButton(type: .custom)
               home.setTitle("Wallet", for: .normal)
               home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
               home.setTitleColor(.white, for: .normal)
               home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
               let homeItem = UIBarButtonItem(customView: home)
               self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
    }
    
    //MARK:- Button Actions
       @objc func backMethod(){
           navigationController?.popViewController(animated: true)
       }

        //MARK:- TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletTableViewCell", for: indexPath as IndexPath) as! walletTableViewCell
          cell.imgg.image = UIImage(named:img[indexPath.row])
        cell.viw.addBorders()
        let dataDict = (self.transactionArray.object(at: indexPath.row) as! NSDictionary)
        cell.label1.text = (dataDict.value(forKey: "name") as! String)
        cell.dateLabel.text = (dataDict.value(forKey: "createddatetime") as! String)
        let rupee = "\u{20B9}"
        cell.amountLabel.text = "\(rupee) \((dataDict.value(forKey: "price") as! String))"
        if (dataDict.value(forKey: "paystatus") as! String) == "add" {
            cell.statusLabel.setTitle("Received", for: .normal)
            cell.statusLabel.setTitleColor(UIColor.green, for: .normal)
        }else {
            cell.statusLabel.setTitle("Paid", for: .normal)
            cell.statusLabel.setTitleColor(UIColor.red, for: .normal)
        }
        if dataDict.value(forKey: "image") != nil {
            cell.imgView.sd_setImage(with: URL(string: (self.dataDict.value(forKey: "image") as! String)))
        }
        cell.groupLabel.text = (dataDict.value(forKey: "paystatus") as! String)

        /*
         {
                    createddatetime = "2019-12-12 06:12:22";
                    id = 7;
                    message = "receive amount";
                    name = testing;
                    paystatus = add;
                    price = 100;
                }
         */
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //MARK:- Api Calling
    func transHistoryApi() {
            SVProgressHUD.show()
        //udf.value(forKey: "userID") as! String
         let details:[Any] = ["transactions","1"]
            ApiManager.shared()?.getTransactionsApi(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:String = responseJSON.value(forKey: "status") as! String
            if status == "success" {
                self.transactionArray = (responseJSON.value(forKey: "grounds") as! NSArray)
                self.walletTV.reloadData()
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
    
   
}
