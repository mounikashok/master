//
//  ForgotPasswordViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/24/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet  var submitBtn: UIButton!
    @IBOutlet  var forgotPasswrdField: UITextField!
    var udf = UserDefaults()
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        forgotPasswrdField.layer.cornerRadius = 5
        forgotPasswrdField.layer.masksToBounds = false
        forgotPasswrdField.layer.shadowRadius = 3.0
        forgotPasswrdField.layer.shadowColor = UIColor.black.cgColor
        forgotPasswrdField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        forgotPasswrdField.layer.shadowOpacity = 0.3
        forgotPasswrdField.setPadding()

        submitBtn.layer.shadowColor = UIColor.gray.cgColor
        submitBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        submitBtn.layer.shadowRadius = 3
        submitBtn.layer.shadowOpacity = 0.7
    }
    
    //MARK:- Email Verification Method
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

    // MARK: - Navigation
    func forgotApiCalling()
        {
            SVProgressHUD.show()
            let details:[Any] = ["forgotpassword",self.forgotPasswrdField.text!]
            ApiManager.shared().forgot(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:String = responseJSON.value(forKey: "status") as! String
            let message:String = responseJSON.value(forKey: "message") as! String

            print(responseJSON)
            if status == "success" {
                // Create the alert controller
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

                   // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                       UIAlertAction in
                       NSLog("OK Pressed")
                    self.dismiss(animated: true, completion: nil)
                   }
                   // Add the actions
                   alertController.addAction(okAction)

                   // Present the controller
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                self.presentAlert(withTitle: "Forgot Password", message: responseJSON.value(forKey: "message") as! String)
            }
        },failure: { (session, error) in
            print(error?.localizedDescription as Any)
            self.presentAlert(withTitle: "Forgot Password", message: error!.localizedDescription)
            SVProgressHUD.dismiss()
        })
    }
    
    //MARK:- bUTTON aCTIONS
    @IBAction func signInAction(_ sender: Any) {
        self.performSegue(withIdentifier: "forgotp", sender: nil)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        if (forgotPasswrdField.text?.isEmpty == true)
        {
            presentAlert(withTitle: "Forgot Password", message: "Please enter Email ID/ Mobile Number")
        }
        else if (validate(YourEMailAddress: forgotPasswrdField.text!) == false){
            presentAlert(withTitle: "Forgot Password", message: "please enter valid Email ID")
        }
        else
        {
            self.forgotApiCalling()
        }
    }

}
