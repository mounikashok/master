//
//  LoginViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/24/19.
//  Copyright © 2019 iso99. All rights reserved.
//2541654652560581 - FaceBook ID
//132380593085-cador7n0bson28sudhvqtv4gqitvtq4a.apps.googleusercontent.com - GoogleClientID

import Foundation
import UIKit

import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate, UITextFieldDelegate {

    @IBOutlet  var signInBtn: UIButton!
    @IBOutlet  var usernameField: UITextField!
    @IBOutlet  var passwordField: UITextField!
    @IBOutlet  var loginWthGoogleBtn: UIButton!
    @IBOutlet  var loginWthFaceBook: UIButton!
    
    var udf = UserDefaults()
    var appDelegate: AppDelegate!
    var fbDcit: NSDictionary!
    var otpStr = ""
    var emptyDictionary = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        shadow()
    }
    
    private func styleTextField(textField: UITextField) {
        textField.borderStyle = .none
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5.0;
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowRadius = 4.0
    }

    func shadow(){
        loginWthGoogleBtn.layer.shadowColor = UIColor.gray.cgColor
        loginWthGoogleBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        loginWthGoogleBtn.layer.shadowRadius = 4
        loginWthGoogleBtn.layer.shadowOpacity = 0.7
        
        loginWthFaceBook.layer.shadowColor = UIColor.gray.cgColor
        loginWthFaceBook.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        loginWthFaceBook.layer.shadowRadius = 4
        loginWthFaceBook.layer.shadowOpacity = 0.7
        
        signInBtn.layer.shadowColor = UIColor.gray.cgColor
        signInBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        signInBtn.layer.shadowRadius = 3
        signInBtn.layer.shadowOpacity = 0.7
        usernameField.layer.cornerRadius = 5
        usernameField.layer.masksToBounds = false
        usernameField.layer.shadowRadius = 3.0
        usernameField.layer.shadowColor = UIColor.black.cgColor
        usernameField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        usernameField.layer.shadowOpacity = 0.3
        passwordField.layer.cornerRadius = 5
        passwordField.layer.masksToBounds = false
        passwordField.layer.shadowRadius = 3.0
        passwordField.layer.shadowColor = UIColor.black.cgColor
        passwordField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        passwordField.layer.shadowOpacity = 0.3
        usernameField.setPadding()
        passwordField.setPadding()
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
    
    //MARK:Google SignIn Delegate
     func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
      // myActivityIndicator.stopAnimating()
        }

    // Present a view that prompts the user to sign in with Google
       func sign(_ signIn: GIDSignIn!,
                  present viewController: UIViewController!) {
            self.present(viewController, animated: true, completion: nil)
        }

    // Dismiss the "Sign in with Google" view
     func sign(_ signIn: GIDSignIn!,
                  dismiss viewController: UIViewController!) {
            self.dismiss(animated: true, completion: nil)
        }

    //completed sign In
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

            if (error == nil) {
          // Perform any operations on signed in user here.
               let userId = user.userID                  // For client-side use only!
               let idToken = user.authentication.idToken // Safe to send to the server
               let fullName = user.profile.name
               let givenName = user.profile.givenName
               let familyName = user.profile.familyName
               let email = user.profile.email
               print(userId!,idToken!,fullName!,givenName!,familyName!,email!)
               self.emptyDictionary = ["Name" : fullName!, "Email" : email!, "image" : "", "type" : "google"]
               print(self.emptyDictionary)
               self.socialSignUpApiCalling(dict: self.emptyDictionary as NSDictionary)
            } else {
                print("\(error.localizedDescription)")
            }
        }
    
    //MARK:- Api Callings
    //Normal Login
    func lgoinApiCalling()
        {
            SVProgressHUD.show()
            let details:[Any] = ["login",self.usernameField.text!,self.passwordField.text!]
            ApiManager.shared().login(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:String = responseJSON.value(forKey: "status") as! String
            if status == "success" {
                let userID:String = responseJSON.value(forKey: "userid") as! String
                let userName:String = responseJSON.value(forKey: "name") as! String
                let userEmail:String = responseJSON.value(forKey: "email") as! String
                let userPH:String = responseJSON.value(forKey: "phone") as! String

                self.udf.set(userID, forKey: "userID")
                self.udf.set(responseJSON, forKey: "loginDict")
                self.udf.set(true, forKey: "LOGIN")
                self.udf.set(userPH, forKey: "phone")
                self.udf.set(userEmail, forKey: "email")
                self.udf.set(userName, forKey: "name")
                self.udf.synchronize()
                self.performSegue(withIdentifier: "home", sender: nil)
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
    
    //Socail Login
    func socialSignUpApiCalling(dict: NSDictionary)
    {
        SVProgressHUD.show()
        let details:[Any] = ["sociallogin",emptyDictionary["Name"]!,emptyDictionary["Email"]!, emptyDictionary["image"]!,emptyDictionary["type"]!]
        print(details)
        ApiManager.shared().socialLogin(withDetails: details, success: { (NSURLSessionTask, responseObject) in
        let responseJSON:NSDictionary = responseObject as! NSDictionary
        print(responseJSON)
        SVProgressHUD.dismiss()
        let status:String = responseJSON.value(forKey: "status") as! String

        if status == "success" {
            /*
             {
                 "status": "success",
                 "userdetails": {
                     "id": "22",
                     "name": "mounika",
                     "email": "aradadi.mounika21@gmail.com"
                 }
             }
             */
            let userID:String = responseJSON.value(forKey: "id") as! String
            self.udf.set(userID, forKey: "userID")
            self.udf.set(true, forKey: "LOGIN")
            self.udf.synchronize()
            self.performSegue(withIdentifier: "home", sender: nil)
        }
        else if status == "failure" {
            self.presentAlert(withTitle: "Socila Login", message: responseJSON.value(forKey: "message") as! String)
        }
        },failure: { (session, error) in
            print(error?.localizedDescription as Any)
            self.presentAlert(withTitle: "Social Login", message: error!.localizedDescription)
            SVProgressHUD.dismiss()
        })
    }
    
    //MARK:- Button Actions
    @IBAction func signIn(_ sender: Any) {
        if (usernameField.text?.isEmpty == true)
        {
            presentAlert(withTitle: "Login", message: "Please enter Email ID/ Mobile Number")
        }
        else if (passwordField.text?.isEmpty == true)
        {
            presentAlert(withTitle: "Login", message: "Please enter Password")
        }
        else if (passwordField.text!.count < 5)
        {
            presentAlert(withTitle: "Login", message: "please enter 5 digit password")
        }
        else
        {
            self.lgoinApiCalling()
        }
    }
    
    @IBAction func googleLoginBtn(_ sender: Any) {

        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        self.performSegue(withIdentifier: "signUp", sender: nil)
    }
    
    @IBAction func forgotPassswordAction(_ sender: Any) {
         self.performSegue(withIdentifier: "forgot", sender: nil)
    }
    
    
    @IBAction func fbLoginBtn(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
      fbLoginManager.logOut()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
        if (error == nil){
            let fbloginresult : LoginManagerLoginResult = result!
          // if user cancel the login
          if (result?.isCancelled)!{
                  return
          }
          if(fbloginresult.grantedPermissions.contains("email"))
          {
            self.getFBUserData()
          }
        }
      }
    }

    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
          if (error == nil){
            //everything works print the user data
            print(result as Any)
            self.fbDcit = NSDictionary()
            self.fbDcit = (result as! NSDictionary)
            print(self.fbDcit as NSDictionary)
            let userID = self.fbDcit.value(forKey: "id") as! String
            let facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
            self.emptyDictionary = ["Name" : self.fbDcit.value(forKey: "name") as! String, "Email" : self.fbDcit.value(forKey: "email") as! String, "image" : facebookProfileUrl, "type" : "facebook"]
            self.socialSignUpApiCalling(dict: self.emptyDictionary as NSDictionary)
            /*
            let email = self.fbDcit["email"] as! String?
            let userID = self.fbDcit["id"] as! String
            print("The result dict[id] of fb profile::: \(userID)")
            let facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
            */

            /*
             Optional({
                 email = "aradadi.mounika21@gmail.com";
                 "first_name" = Mounika;
                 id = 1392143390943858;
                 "last_name" = Aradadi;
                 name = "Mounika Aradadi";
                 picture =     {
                     data =         {
                         height = 200;
                         "is_silhouette" = 1;
                         url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=1392143390943858&height=200&width=200&ext=1574671089&hash=AeTC6vdWOX6lsvUp";
                         width = 200;
                     };
                 };
             })
             */
          }
        })
      }
    }
    
    /*
    
    //facebook
    
     @IBAction func btnClickFBLogin(_ sender: Any) {
            self.facebooklogin()
        }
        
        func facebooklogin() {
            let fbLoginManager : LoginManager = LoginManager()
            fbLoginManager.logIn(permissions: ["email"], from: self, handler: { (result, error) -> Void in
                if (error == nil) {
                    let fbloginresult : LoginManagerLoginResult = result!
                    if(fbloginresult.isCancelled) {
                        //Show Cancel alert
                    } else if(fbloginresult.grantedPermissions.contains("email")) {
                        self.returnUserData()
                        //fbLoginManager.logOut()
                    }
                }
            })
        }
        
        
        func returnUserData() {
            let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                if ((error) != nil) {
                } else {
                    let resultDic = result as! NSDictionary
                    if (resultDic.value(forKey:"name") != nil) {
                        let userName = resultDic.value(forKey:"name")! as! String as NSString?
                    }
                    else if (resultDic.value(forKey:"email") != nil) {
                        let userEmail = resultDic.value(forKey:"email")! as! String as NSString?

                    }
                    self.facebookServiceMethod()
                }
            })
        }
      
        func facebookServiceMethod(){
            
        }
        
        func loginManagerDidComplete(result: LoginResult) {
          //let alertController: UIAlertController
          switch result {
          case .cancelled:
            break
          case .failed(let error):
            break
          case .success(let grantedPermissions, let declinedPermissions, let accessToken):
           
             print(accessToken)
            let connection = GraphRequestConnection()
           connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"email,name"])) { httpResponse, result, error   in
                if error != nil {
                    NSLog(error.debugDescription)
                    return
                }

            let result = result as? [String:Any]
            let email = result!["email"] as? String
            let fullName = result!["name"] as? String

            SVProgressHUD.show()
            let details:[Any] = ["sociallogin",result!["email"] as? String,result!["name"] as? String, result!["image"] as? String,"facebook"]
            print(details)
            ApiManager.shared().socialLogin(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:String = responseJSON.value(forKey: "status") as! String

            if status == "success" {
                /*
                 {
                     "status": "success",
                     "userdetails": {
                         "id": "22",
                         "name": "mounika",
                         "email": "aradadi.mounika21@gmail.com"
                     }
                 }
                 */
                let userID:String = responseJSON.value(forKey: "id") as! String
                self.udf.set(userID, forKey: "userID")
                self.udf.set(true, forKey: "LOGIN")
                self.udf.synchronize()
                self.performSegue(withIdentifier: "home", sender: nil)
            }
            else if status == "failure" {
                self.presentAlert(withTitle: "Socila Login", message: responseJSON.value(forKey: "message") as! String)
            }
            },failure: { (session, error) in
                print(error?.localizedDescription as Any)
                self.presentAlert(withTitle: "Social Login", message: error!.localizedDescription)
                SVProgressHUD.dismiss()
            })
                
             }
            connection.start()
          }
         // self.present(alertController, animated: true, completion: nil)
        }
       

        @IBAction private func loginWithReadPermissions() {
          let loginManager = LoginManager()
            loginManager.logIn(permissions: [], from: self) { result in
            self.loginManagerDidComplete(result)
          }
        }

        @IBAction private func logOut() {
          let loginManager = LoginManager()
          loginManager.logOut()

    //      let alertController = UIAlertController(title: "Logout", message: "Logged out.")
    //      present(alertController, animated: true, completion: nil)
        }
 */
}
