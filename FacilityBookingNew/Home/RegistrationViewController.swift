//
//  RegistrationViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit
import Razorpay

class RegistrationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NotifyReloadCoreData {

    
    @IBOutlet  var payNw: UIButton!
    @IBOutlet  var saveOutlet: UIButton!
    @IBOutlet  var viw: UIView!
    @IBOutlet  var viw2: UIView!
    @IBOutlet  var registerTV: UITableView!
    @IBOutlet  var selectTeamField: UITextField!
    @IBOutlet  var amountField: UITextField!
    @IBOutlet  var phoneNmbrField: UITextField!
    @IBOutlet  var emailField: UITextField!
    @IBOutlet  var palyerField: UITextField!
    @IBOutlet  var nameField: UITextField!
    @IBOutlet weak var teamNameLabel: UILabel!
    var playersArray: NSMutableArray = NSMutableArray()
    var teamLenthArray: NSMutableArray = NSMutableArray()
    var seledctedTeamLenthArray: NSMutableArray = NSMutableArray()
    var alt = AlertViewController()


    var nameFieldArray = ["1","2","3","4"]
    var udf = UserDefaults()
    var teamIDStr = ""
    var teamString = ""
    var playerID = ""
    var money = ""
    var teamLenth: Int = 0
    var selectedPlayer: Int = 0
    var apiBool: Bool = false
    //Payment
    private var razorpay:Razorpay?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowTextFields()
        registerTV.delegate = self
        registerTV.dataSource = self
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("Registration", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
        self.teamNameLabel.text = self.teamString
        self.teamIDStr = self.teamString
        self.saveOutlet.setTitle("Add Player", for: .normal)
        
        selectTeamField.setLeftPaddingPoints(10)
        nameField.setLeftPaddingPoints(10)
        emailField.setLeftPaddingPoints(10)
        phoneNmbrField.setLeftPaddingPoints(10)
        palyerField.setLeftPaddingPoints(10)
        amountField.setLeftPaddingPoints(10)
        
        self.amountField.text = money
        
        //Payment
        razorpay = Razorpay.initWithKey("rzp_test_FYCQAsmKTFF8FR", andDelegate: self)
        self.payNw.backgroundColor = UIColor.init(red: 191.0/255.0, green: 191/255.0, blue: 191/255.0, alpha: 1.0)
        self.payNw.isUserInteractionEnabled = false
        //Extracting team length string
        var teamLengthStr: String = String(self.teamString.prefix(2))
        teamLengthStr = teamLengthStr.replacingOccurrences(of: "v", with: "")
        teamLenth = Int(teamLengthStr)!
        print(teamLenth)
        for i in 0..<teamLenth {
            self.teamLenthArray.add("\("Player")\(i)")
        }
        print(self.teamLenthArray)
        alt.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.playerListApiCalling()
    }

    @objc func backMethod() {
        navigationController?.popViewController(animated: true)
    }
    
    func shadowTextFields(){
        viw.backgroundColor = UIColor.white
        viw.layer.shadowColor = UIColor.gray.cgColor
        viw.layer.shadowOpacity = 0.2
        viw.layer.borderWidth = 0.5
        viw.layer.borderColor = UIColor.gray.cgColor
        viw.clipsToBounds = true
        viw.layer.cornerRadius = 7
        viw.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        viw.layer.shadowOffset = CGSize.zero
        viw.layer.shadowRadius = 4
         // Top right corner, Top left corner respectively

        viw2.backgroundColor = UIColor.white
        viw2.layer.shadowColor = UIColor.gray.cgColor
        viw2.layer.shadowOpacity = 0.2
        viw2.layer.borderWidth = 0.5
        viw2.layer.borderColor = UIColor.gray.cgColor
        viw2.clipsToBounds = true
        viw2.layer.cornerRadius = 7
        viw2.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        viw2.layer.shadowOffset = CGSize.zero
        viw2.layer.shadowRadius = 4
        
        selectTeamField.layer.cornerRadius = 5
        selectTeamField.layer.masksToBounds = false
        selectTeamField.layer.shadowRadius = 3.0
        selectTeamField.layer.shadowColor = UIColor.black.cgColor
        selectTeamField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        selectTeamField.layer.shadowOpacity = 0.3
        
        amountField.layer.cornerRadius = 5
        amountField.layer.masksToBounds = false
        amountField.layer.shadowRadius = 3.0
        amountField.layer.shadowColor = UIColor.black.cgColor
        amountField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        amountField.layer.shadowOpacity = 0.3
        
        phoneNmbrField.layer.cornerRadius = 5
        phoneNmbrField.layer.masksToBounds = false
        phoneNmbrField.layer.shadowRadius = 3.0
        phoneNmbrField.layer.shadowColor = UIColor.black.cgColor
        phoneNmbrField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        phoneNmbrField.layer.shadowOpacity = 0.3
        
        emailField.layer.cornerRadius = 5
        emailField.layer.masksToBounds = false
        emailField.layer.shadowRadius = 3.0
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        emailField.layer.shadowOpacity = 0.3
        
        palyerField.layer.cornerRadius = 5
        palyerField.layer.masksToBounds = false
        palyerField.layer.shadowRadius = 3.0
        palyerField.layer.shadowColor = UIColor.black.cgColor
        palyerField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        palyerField.layer.shadowOpacity = 0.3
       
        payNw.layer.shadowColor = UIColor.gray.cgColor
        payNw.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        payNw.layer.shadowRadius = 4
        payNw.layer.shadowOpacity = 0.5
        
        saveOutlet.layer.shadowColor = UIColor.gray.cgColor
        saveOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        saveOutlet.layer.shadowRadius = 4
        saveOutlet.layer.shadowOpacity = 0.5
        
        nameField.layer.cornerRadius = 5
        nameField.layer.masksToBounds = false
        nameField.layer.shadowRadius = 3.0
        nameField.layer.shadowColor = UIColor.black.cgColor
        nameField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        nameField.layer.shadowOpacity = 0.3
    }
    
    //Protocal Method
    func notifyDelegate(_ str: String, playerIndex: Int) {
        seledctedTeamLenthArray.add(str)
        print(str)
        self.palyerField.text = str
    }
    
    //MARK:- TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTableViewCell", for: indexPath as IndexPath) as! RegisterTableViewCell
        let dataDict = (self.playersArray.object(at: indexPath.row) as! NSDictionary)
        cell.playerField.text! = (dataDict.value(forKey: "player") as! String)
        cell.nameField.text! = (dataDict.value(forKey: "name") as! String)
        cell.emailField.text! = (dataDict.value(forKey: "email") as! String)
        cell.phoneField.text! = (dataDict.value(forKey: "phone") as! String)
       //cell.viw.addBorders()
        cell.radioButton.tag = indexPath.row
        cell.radioButton.addTarget(self, action: #selector(radioMethod),  for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func radioMethod(_ sender : UIButton) {
        self.saveOutlet.setTitle("Edit Player", for: .normal)
        let dataDict = (self.playersArray.object(at: sender.tag) as! NSDictionary)
        self.selectTeamField.text = (dataDict.value(forKey: "teamname") as! String)
        self.palyerField.text! = "\("Player") \(dataDict.value(forKey: "player") as! String)"
        self.nameField.text! = (dataDict.value(forKey: "name") as! String)
        self.emailField.text! = (dataDict.value(forKey: "email") as! String)
        self.phoneNmbrField.text! = (dataDict.value(forKey: "phone") as! String)
        self.amountField.text! = (dataDict.value(forKey: "cost") as! String)
        playerID = (dataDict.value(forKey: "id") as! String)
     }
    
    //MARK:- Api Callings
    func playerListApiCalling()
    {
           SVProgressHUD.show()
        let details:[Any] = ["playerslist",udf.value(forKey: "userID") as! String]
           ApiManager.shared().playersList(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
                self.playersArray = NSMutableArray(array: (responseJSON.value(forKey: "grounds") as! NSArray))
            self.registerTV.reloadData()
            /*
             {
                 cost = 500;
                 email = "tester@gmail.com";
                 id = 5;
                 name = tester;
                 phone = 1234567890;
                 player = 0;
                 team = 11;
                 teamname = "test team";
             },
             */
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
    
    func registerApiCalling()
    {
        self.apiBool = false
           SVProgressHUD.show()
        let details:[Any] = ["playerregistration",udf.value(forKey: "userID") as! String,self.selectTeamField.text!, teamIDStr,self.palyerField.text!,self.nameField.text!,self.emailField.text!,self.phoneNmbrField.text!,self.amountField.text!]
           ApiManager.shared().registrationApi(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
                self.apiBool = true
                self.teamLenthArray.removeObject(at: self.selectedPlayer)
                self.selectTeamField.text = ""
                self.palyerField.text! = ""
                self.nameField.text! = ""
                self.emailField.text! = ""
                self.phoneNmbrField.text! = ""
                self.playerListApiCalling()
                self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
           }
           else if status == "error" {
               self.presentAlert(withTitle: "Login", message: responseJSON.value(forKey: "message") as! String)
           }
       },failure: { (session, error) in
           self.apiBool = false
           print(error?.localizedDescription as Any)
           self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
           SVProgressHUD.dismiss()
       })
    }
    
    func playerEditApiCalling(_ str: String)
    {
        self.apiBool = false
           SVProgressHUD.show()
        let details:[Any] = ["playerregistration",udf.value(forKey: "userID") as! String,self.selectTeamField.text!, teamIDStr,self.palyerField.text!,self.nameField.text!,self.emailField.text!,self.phoneNmbrField.text!,self.amountField.text!,str]
        ApiManager.shared().playerEdit(details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
                self.apiBool = true
                self.teamLenthArray.removeObject(at: self.selectedPlayer)
                self.selectTeamField.text = ""
                self.palyerField.text! = ""
                self.nameField.text! = ""
                self.emailField.text! = ""
                self.phoneNmbrField.text! = ""
                self.playerListApiCalling()
                self.presentAlert(withTitle: "", message: responseJSON.value(forKey: "message") as! String)
           }
           else if status == "error" {
               self.presentAlert(withTitle: "Login", message: responseJSON.value(forKey: "message") as! String)
           }
       },failure: { (session, error) in
            self.apiBool = false
           print(error?.localizedDescription as Any)
           self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
           SVProgressHUD.dismiss()
       })
    }
    
    //MARK:- Button Actions
    @IBAction func payNowAction(_ sender: Any) {
        if (self.amountField.text?.isEmpty == true)
        {
            presentAlert(withTitle: "", message: "Please enter amount")
        }else {
            let options: [String:Any] = [
                "amount" : self.amountField.text!, //mandatory in paise like:- 1000 paise ==  10 rs
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
           razorpay?.open(options)
        }
//        self.performSegue(withIdentifier: "success", sender: nil)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if sender.tag == 1 {
            if (self.selectTeamField.text!.isEmpty) {
                self.presentAlert(withTitle: "", message: "Please enter team name")
            }else if (self.palyerField.text!.isEmpty) {
                self.presentAlert(withTitle: "", message: "Please enter player")
            }else if (self.nameField.text!.isEmpty) {
                self.presentAlert(withTitle: "", message: "Please enter player name")
            }else if (self.emailField.text!.isEmpty) {
                self.presentAlert(withTitle: "", message: "Please enter email ID")
            }else if (self.phoneNmbrField.text!.isEmpty) {
                self.presentAlert(withTitle: "", message: "Please enter phone number")
            }else if (self.amountField.text!.isEmpty) {
                self.presentAlert(withTitle: "", message: "Please enter amount")
            }else
            {
                if self.saveOutlet.titleLabel?.text == "Add Player" {
                    self.registerApiCalling()
                }else {
                    self.playerEditApiCalling(playerID)
                }
            }
        }else if(sender.tag == 2) {
            if self.apiBool == true {
                self.payNw.isUserInteractionEnabled = true
                self.payNw.backgroundColor = UIColor.init(red: 66.0/255.0, green: 109/255.0, blue: 159/255.0, alpha: 1.0)
            }
        }
    }
    
    @IBAction func playerButton(_ sender: Any) {
            let avc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController
            avc?.arr_languages = teamLenthArray
            avc!.delegate = self
            avc!.modalPresentationStyle = .overCurrentContext
            avc!.modalTransitionStyle = .crossDissolve
            self.present(avc!, animated: true, completion:nil)
    }
}

extension RegistrationViewController: RazorpayPaymentCompletionProtocol {
    func onPaymentSuccess(_ payment_id: String) {
        let alert = UIAlertController(title: "Paid", message: "Payment Success", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        let alert = UIAlertController(title: "Error", message: "\(code)\n\(str)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
