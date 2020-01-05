//
//  OTPVerifcationViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/24/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class OTPVerifcationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var phBtn: UIButton!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var verfyBtn: UIButton!
    var udf = UserDefaults()
    var appDelegate: AppDelegate!
    var otpString: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Button Functionality
        verfyBtn.layer.shadowColor = UIColor.gray.cgColor
        verfyBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        verfyBtn.layer.shadowRadius = 3
        verfyBtn.layer.shadowOpacity = 0.7
        //TextField Methods
        textField1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        //Dividing OTP String
        otpString = (udf.value(forKey: "otpValue" as String) as! String)
        phBtn.setTitle((udf.value(forKey: "mobile") as! String), for: .normal)
        emailBtn.setTitle((udf.value(forKey: "email") as! String), for: .normal)

        print(otpString as String)
        let otpLetters = otpString!.map { String($0) }
        if otpLetters.count != 0 {
            textField1.text = otpLetters[0]
            textField2.text = otpLetters[1]
            textField3.text = otpLetters[2]
            textField4.text = otpLetters[3]
        }
    }
    
    //MARK:- TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case self.textField1:
                self.textField2.becomeFirstResponder()
            case self.textField2:
                self.textField3.becomeFirstResponder()
            case self.textField3:
                self.textField4.becomeFirstResponder()
            case self.textField4:
                self.textField4.resignFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case self.textField1:
                self.textField1.becomeFirstResponder()
            case self.textField2:
                self.textField1.becomeFirstResponder()
            case self.textField3:
                self.textField2.becomeFirstResponder()
            case self.textField4:
                self.textField3.becomeFirstResponder()
            default:
                break
            }
        }
        else{
        }
    }
    
    // MARK: - Navigation
     func otpApiCalling()
         {
            SVProgressHUD.show()
            var str = "\(textField1.text!)\(textField2.text!)\(textField3.text!)\(textField4.text!)"
            str = str.trimmingCharacters(in: CharacterSet.whitespaces)
            print(str)
            let details:[Any] = ["otp",str as String,udf.value(forKey: "userID") as! String]
            print(details)
             ApiManager.shared().otp(withDetails: details, success: { (NSURLSessionTask, responseObject) in
             let responseJSON:NSDictionary = responseObject as! NSDictionary
             print(responseJSON)
             SVProgressHUD.dismiss()
             let status:String = responseJSON.value(forKey: "status") as! String
             print(responseJSON)
             if status == "success" {
                self.performSegue(withIdentifier: "home", sender: nil)
             }
             else if status == "failure" {
                self.presentAlert(withTitle: "OTP", message: responseJSON.value(forKey: "message") as! String)
             }
         },failure: { (session, error) in
             print(error?.localizedDescription as Any)
            self.presentAlert(withTitle: "OTP", message: error!.localizedDescription)
            SVProgressHUD.dismiss()
         })
     }
    
    //MARK:- Button Actions
    @IBAction func resendBtn(_ sender: Any) {
        if (textField1.text?.isEmpty == true && textField2.text?.isEmpty == true && textField3.text?.isEmpty == true && textField4.text?.isEmpty == true)
        {
            presentAlert(withTitle: "OTP", message: "Fields cannot be empty")
        }
        if (textField1.text?.isEmpty == true || textField2.text?.isEmpty == true || textField3.text?.isEmpty == true || textField4.text?.isEmpty == true)
        {
            presentAlert(withTitle: "OTP", message: "please fill remaining Field")
        }
        else {
            self.otpApiCalling()
        }
    }
    
    @IBAction func verifyBtn(_ sender: Any) {
        if (textField1.text?.isEmpty == true && textField2.text?.isEmpty == true && textField3.text?.isEmpty == true && textField4.text?.isEmpty == true)
        {
            presentAlert(withTitle: "OTP", message: "Fields cannot be empty")
        }
        if (textField1.text?.isEmpty == true || textField2.text?.isEmpty == true || textField3.text?.isEmpty == true || textField4.text?.isEmpty == true)
        {
            presentAlert(withTitle: "OTP", message: "please fill remaining Field")
        }
        else {
            self.otpApiCalling()
        }
    }
}
