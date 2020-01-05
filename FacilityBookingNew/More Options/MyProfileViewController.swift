//
//  MyProfileViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet  var profileImg: UIImageView!
    @IBOutlet  var nameField: UITextField!
    @IBOutlet  var emailField: UITextField!
    @IBOutlet  var phoneFiled: UITextField!
    @IBOutlet  var updateProfileButton: UIButton!
    var picker = UIImagePickerController()
    var chosenImage  : UIImage!
    var udf = UserDefaults()
    var imgData: NSData!
    // var hud : MBProgressHUD!

    override func viewDidLoad() {
        super.viewDidLoad()
      //  hud = MBProgressHUD.showAdded(to: self.view, animated: true)
      //  hud.labelText = "Loading..."
        
        self.profileImg.layer.cornerRadius = self.profileImg.bounds.size.width / 2.0
        self.profileImg.layer.borderColor = UIColor.lightGray.cgColor
        self.profileImg.layer.borderWidth = 1.0;
        self.profileImg.clipsToBounds = true
        self.profileImg.layer.masksToBounds = true
        
        getProfile()

        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let home = UIButton(type: .custom)
        home.setTitle("Profile", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-BOLD", size: 18.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        
        let btn111 = UIButton(type: .custom)
        btn111.setImage(UIImage(named: "Logo"), for: .normal)
        btn111.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let item111 = UIBarButtonItem(customView: btn111)
        self.navigationItem.setLeftBarButtonItems([item1,item111,homeItem] , animated: true)
        profileImg.layer.cornerRadius = profileImg.frame.height/2
    }
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
    
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let image = info[.originalImage] as? UIImage{
             chosenImage = image
             self.profileImg.image = chosenImage
            self.imgData = self.profileImg.image?.pngData() as NSData?
            print(self.imgData as NSData)
         }
         self.picker.dismiss(animated: false, completion: nil)
     }
    
 @IBAction func addFilesMethod()
 {
     let otherAlert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
     let PhotoAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
           self.picker.allowsEditing = false
           self.picker.delegate = self
           self.picker.sourceType = .photoLibrary
          self.picker.modalPresentationStyle = .fullScreen
           self.present(self.picker,animated: true,completion: nil)
       //  self.launchController()
     }
     let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
         print("We can run a block of code." )
         self.picker.allowsEditing = false
         self.picker.delegate = self
         self.picker.sourceType = UIImagePickerController.SourceType.camera
         self.picker.cameraCaptureMode = .photo
         self.picker.modalPresentationStyle = .fullScreen
         self.present(self.picker,animated: true,completion: nil)
     }
     let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
     // relate actions to controllers
     otherAlert.addAction(PhotoAction)
     otherAlert.addAction(cameraAction)
     otherAlert.addAction(dismiss)
     self.present(otherAlert,animated: true,completion: nil)
 }
    
    //MARK:- Api Callings
    func getProfile() {
            SVProgressHUD.show()
         let details:[Any] = ["userprofile",udf.value(forKey: "userID") as! String]
            ApiManager.shared().userProfileApi(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:String = responseJSON.value(forKey: "status") as! String
            if status == "success" {
                let dataDict = responseJSON.value(forKey: "userdetails") as! NSDictionary
                self.nameField.text = (dataDict.value(forKey: "name") as! String)
                self.emailField.text = (dataDict.value(forKey: "email") as! String)
                self.phoneFiled.text = (dataDict.value(forKey: "phone") as! String)
                DispatchQueue.main.async{
                    self.profileImg.sd_setImage(with: URL(string: (dataDict.value(forKey: "image") as! String)))
                }
                self.profileImg.contentMode = .scaleAspectFill
                self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height/2
                self.profileImg.layer.masksToBounds = true
                

                self.imgData = self.profileImg.image?.pngData() as NSData?
                print(self.imgData as NSData)
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
    
    func updateProfile() {
            SVProgressHUD.show()
        let details:[Any] = ["editprofile",udf.value(forKey: "userID") as! String,self.nameField.text!,self.imgData!]
        //updateUserProfileWithDetails
            ApiManager.shared().updateUserProfile(withDetails: details, success: { (NSURLSessionTask, responseObject) in
            let responseJSON:NSDictionary = responseObject as! NSDictionary
            print(responseJSON)
            SVProgressHUD.dismiss()
            let status:String = responseJSON.value(forKey: "status") as! String
            if status == "success" {
                self.presentAlert(withTitle: "Profile", message: responseJSON.value(forKey: "message") as! String)
            }
            else if status == "error" {
                self.presentAlert(withTitle: "Profile", message: responseJSON.value(forKey: "message") as! String)
            }
        },failure: { (session, error) in
            print(error?.localizedDescription as Any)
            self.presentAlert(withTitle: "Error", message: error!.localizedDescription)
            SVProgressHUD.dismiss()
        })
    }

    //MARK:- Button Actions
    @IBAction func updateProfile(_ sender: Any) {
        if self.nameField.text?.isEmpty == true {
            self.presentAlert(withTitle: "Profile", message: "Please enter name")
        }else {
            self.updateProfile()
        }
    }
}

