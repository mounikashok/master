//
//  SignUpViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/24/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet  var signUpBtn: UIButton!
    @IBOutlet  var fullnameField: UITextField!
    @IBOutlet  var emailField: UITextField!
    @IBOutlet  var mobileNmbrField: UITextField!
    @IBOutlet  var passwordField: UITextField!
    
    var udf = UserDefaults()
    var appDelegate: AppDelegate!
    var otpStr = ""
    var termsBool: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        textFieldShoadow()
        termsButton.setImage(UIImage(named: "checkbox"), for: .normal)
    }
    
    func textFieldShoadow(){
        fullnameField.setLeftPaddingPoints(10)
        emailField.setLeftPaddingPoints(10)
        mobileNmbrField.setLeftPaddingPoints(10)
        passwordField.setLeftPaddingPoints(10)

        fullnameField.layer.cornerRadius = 5
        fullnameField.layer.masksToBounds = false
        fullnameField.layer.shadowRadius = 3.0
        fullnameField.layer.shadowColor = UIColor.black.cgColor
        fullnameField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        fullnameField.layer.shadowOpacity = 0.3
        
        emailField.layer.cornerRadius = 5
        emailField.layer.masksToBounds = false
        emailField.layer.shadowRadius = 3.0
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        emailField.layer.shadowOpacity = 0.3
        
        
        mobileNmbrField.layer.cornerRadius = 5
        mobileNmbrField.layer.masksToBounds = false
        mobileNmbrField.layer.shadowRadius = 3.0
        mobileNmbrField.layer.shadowColor = UIColor.black.cgColor
        mobileNmbrField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        mobileNmbrField.layer.shadowOpacity = 0.3
        
        passwordField.layer.cornerRadius = 5
        passwordField.layer.masksToBounds = false
        passwordField.layer.shadowRadius = 3.0
        passwordField.layer.shadowColor = UIColor.black.cgColor
        passwordField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        passwordField.layer.shadowOpacity = 0.3
        
        signUpBtn.layer.shadowColor = UIColor.gray.cgColor
        signUpBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        signUpBtn.layer.shadowRadius = 3
        signUpBtn.layer.shadowOpacity = 0.7
    }
    
    //creating email validation
    func validate(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with:YourEMailAddress)
    }
    
    //MARK:- TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Api Callings
    func signUpApiCalling()
    {
            SVProgressHUD.show()
            let details:[Any] = ["signup",self.fullnameField.text!,self.emailField.text!,self.mobileNmbrField.text!,self.passwordField.text!]
            ApiManager.shared().signUp(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:Int = responseJSON.value(forKey: "status") as! Int

            if status == 1 {
                let userID:String = responseJSON.value(forKey: "userid") as! String
                self.otpStr = responseJSON.value(forKey: "otp") as! String
                self.udf.set(userID, forKey: "userID")
                self.udf.set(true, forKey: "LOGIN")
                self.udf.set(self.otpStr, forKey: "otpValue")
                self.udf.set(self.mobileNmbrField.text, forKey: "mobile")
                self.udf.set(self.emailField.text, forKey: "email")
                self.udf.set(self.fullnameField.text, forKey: "name")
                self.udf.synchronize()
                self.performSegue(withIdentifier: "verify", sender: nil)
            }
            else if status == 0 {
                self.presentAlert(withTitle: "SignUp", message: responseJSON.value(forKey: "message") as! String)
            }
        },failure: { (session, error) in
            print(error?.localizedDescription as Any)
            self.presentAlert(withTitle: "SignUp", message: error!.localizedDescription)
            SVProgressHUD.dismiss()
        })
    }
    
    //MARK:- Button Actions
    @IBAction func signUpAction(_ sender: Any) {
        if (fullnameField.text?.isEmpty == true) {
            presentAlert(withTitle: "SignUp", message: "Please enter Name")

        } else if(emailField.text?.isEmpty == true) {
            presentAlert(withTitle: "SignUp", message: "Please enter EmailID")
        }
        else if (validate(YourEMailAddress: emailField.text!) == false){
            presentAlert(withTitle: "SignUp", message: "Please enter valid Email ID")
        }
        else if (mobileNmbrField.text?.isEmpty == true) {
            presentAlert(withTitle: "SignUp", message: "Please enter Mobile Number")
        }
        else if( passwordField.text?.isEmpty == true)
        {
            presentAlert(withTitle: "SignUp", message: "Please enter Password")
        }
        else if (passwordField.text!.count < 5)
        {
            presentAlert(withTitle: "SignUp", message: "Please enter 5 digit password")
        }
        else if (termsBool == false)
        {
            presentAlert(withTitle: "SignUp", message: "Please accept Terms & Conditions")
        }
        else
        {
            self.signUpApiCalling()
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
      self.performSegue(withIdentifier: "signin", sender: nil)
    }
    
    @IBAction func termsButtonAction(_ sender: Any) {
        if termsBool == false {
            termsBool = true
            self.termsButton.setImage(UIImage(named: "fill-1"), for: .normal)
        }else {
            termsBool = false
            self.termsButton.setImage(UIImage(named: "checkbox"), for: .normal)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
             {
                 if(textField == mobileNmbrField)
                 {
                     let maxLength = 10
                     let currentString: NSString = mobileNmbrField.text! as NSString
                     let newString: NSString =
                         currentString.replacingCharacters(in: range, with: string) as NSString
                     return newString.length <= maxLength
                 }
                 return true;
             }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
