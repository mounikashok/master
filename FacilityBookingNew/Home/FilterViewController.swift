//
//  FilterViewController.swift
//  FacilityBooking
//
//  Created by iso99 on 9/25/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit

protocol MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: NSArray)
}


class FilterViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var wifiButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var furnitureButton: UIButton!
    @IBOutlet weak var parkingButton: UIButton!
    @IBOutlet weak var transportButton: UIButton!
    @IBOutlet weak var fromDateImg: UIImageView!
    @IBOutlet weak var toDateImage: UIImageView!
    @IBOutlet weak var doDateTextField: UITextField!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet  var viw1: UIView!
    @IBOutlet  var viw2: UIView!
    @IBOutlet  var viw3: UIView!
    @IBOutlet  var viw4: UIView!
    @IBOutlet  var viw6: UIView!
    @IBOutlet  var viw5: UIView!
    var udf = UserDefaults.standard
    var priceStr: String = ""
    var ratingStr: String = ""
    var locationStr: String = ""
    var amentiesStr: String = ""
    var startDateStr: String = ""
    var endDateStr: String = ""
    var picker : UIDatePicker!
    var delegate: MyDataSendingDelegateProtocol? = nil
    var groundsArray: NSArray!
    var oneBool : Bool = false
    var twoBool : Bool = false
    var threeBool : Bool = false
    var fourBool : Bool = false
    var fiveBool : Bool = false
    let datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowVw()
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backMethod), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let home = UIButton(type: .custom)
        home.setTitle("Filter", for: .normal)
        home.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 21.0)
        home.setTitleColor(.white, for: .normal)
        home.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let homeItem = UIBarButtonItem(customView: home)
        self.navigationItem.setLeftBarButtonItems([item1,homeItem] , animated: true)
        
        priceStr = "lowtohigh"
        self.lowButton.setImage(UIImage(named: "ciremptyfill"), for: .normal)
        self.highButton.setImage(UIImage(named: "cirempty"), for: .normal)
        
        self.oneButton.setImage(UIImage(named: "fill-1"), for: .normal)
        self.twoButton.setImage(UIImage(named: "fl"), for: .normal)
        self.threeButton.setImage(UIImage(named: "fl"), for: .normal)
        self.fourButton.setImage(UIImage(named: "fl"), for: .normal)
        self.fiveButton.setImage(UIImage(named: "fl"), for: .normal)
        ratingStr = "1"
        
        amentiesStr = ""
        wifiButton.setImage(UIImage(named: "fl"), for: .normal)
        foodButton.setImage(UIImage(named: "fl"), for: .normal)
        transportButton.setImage(UIImage(named: "fl"), for: .normal)
        parkingButton.setImage(UIImage(named: "fl"), for: .normal)
        furnitureButton.setImage(UIImage(named: "fl"), for: .normal)
        
        fromDateTextField.setLeftPaddingPoints(10)
        doDateTextField.setLeftPaddingPoints(10)
    }
    /*
    
     func showDatePicker(){
       //Formate Date
       datePicker.datePickerMode = .date

      //ToolBar
      let toolbar = UIToolbar();
      toolbar.sizeToFit()
      let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
      let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
     let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

     txtDatePicker.inputAccessoryView = toolbar
     txtDatePicker.inputView = datePicker

    }
    */
    
    @IBAction func dateSelection(_ sender: Any) {
    }
    
    //MARK:- Api Callings
    func filtersApiCalling()
    {
           SVProgressHUD.show()
           let details:[Any] = ["filters",udf.value(forKey: "userID") as! String, priceStr,ratingStr,locationStr,amentiesStr,startDateStr,endDateStr]
           ApiManager.shared().filter(withDetails: details, success: { (NSURLSessionTask, responseObject) in
           let responseJSON:NSDictionary = responseObject as! NSDictionary
           print(responseJSON)
           SVProgressHUD.dismiss()
           let status:String = responseJSON.value(forKey: "status") as! String
           if status == "success" {
                self.groundsArray = (responseJSON.value(forKey: "grounds") as! NSArray)
                self.delegate?.sendDataToFirstViewController(myData: self.groundsArray)
                self.navigationController?.popViewController(animated: true)
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
    
    func shadowVw(){
       // ConstraintsBackground.setTextViewBorderMethod(viw1: self.viw1)
        viw1.backgroundColor = UIColor.white
        viw1.layer.shadowColor = UIColor.gray.cgColor
        viw1.layer.shadowOpacity = 0.2
        viw1.layer.borderWidth = 0.3
        viw1.layer.borderColor = UIColor.gray.cgColor
        viw1.layer.cornerRadius = 0
        viw1.layer.shadowOffset = CGSize.zero
        viw1.layer.shadowRadius = 4
        
        viw2.backgroundColor = UIColor.white
        viw2.layer.shadowColor = UIColor.gray.cgColor
        viw2.layer.shadowOpacity = 0.2
        viw2.layer.borderWidth = 0.3
        viw2.layer.borderColor = UIColor.gray.cgColor
        viw2.layer.cornerRadius = 0
        viw2.layer.shadowOffset = CGSize.zero
        viw2.layer.shadowRadius = 4
        
        viw3.backgroundColor = UIColor.white
        viw3.layer.shadowColor = UIColor.gray.cgColor
        viw3.layer.shadowOpacity = 0.2
        viw3.layer.borderWidth = 0.3
        viw3.layer.borderColor = UIColor.gray.cgColor
        viw3.layer.cornerRadius = 0
        viw3.layer.shadowOffset = CGSize.zero
        viw3.layer.shadowRadius = 4
        
        viw4.backgroundColor = UIColor.white
        viw4.layer.shadowColor = UIColor.gray.cgColor
        viw4.layer.shadowOpacity = 0.2
        viw4.layer.borderWidth = 0.3
        viw4.layer.borderColor = UIColor.gray.cgColor
        viw4.layer.cornerRadius = 5
        viw4.layer.shadowOffset = CGSize.zero
        viw4.layer.shadowRadius = 4
        
        viw5.backgroundColor = UIColor.white
        viw5.layer.shadowColor = UIColor.gray.cgColor
        viw5.layer.shadowOpacity = 0.2
        viw5.layer.borderWidth = 0.3
        viw5.layer.borderColor = UIColor.gray.cgColor
        viw5.layer.cornerRadius = 5
        viw5.layer.shadowOffset = CGSize.zero
        viw5.layer.shadowRadius = 4
        
        viw6.backgroundColor = UIColor.white
        viw6.layer.shadowColor = UIColor.gray.cgColor
        viw6.layer.shadowOpacity = 0.2
        viw6.layer.borderWidth = 0.3
        viw6.layer.borderColor = UIColor.gray.cgColor
        viw6.layer.cornerRadius = 5
        viw6.layer.shadowOffset = CGSize.zero
        viw6.layer.shadowRadius = 4
    }
    
    //MARK:- TextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 3 {
            locationStr = textField.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Date Picker Delegate Methods
    @objc func dueDateChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if (picker.tag == 15) {
            startDateStr = dateFormatter.string(from: sender.date)
            print(startDateStr)
            self.fromDateTextField.text = startDateStr
        }else if (picker.tag == 16)  {
            endDateStr = dateFormatter.string(from: sender.date)
            self.doDateTextField.text = endDateStr
        }
        picker.removeFromSuperview()
        toolBar.removeFromSuperview()
    }
    
    //MARK:- Button Actions
    @IBAction func lowHighbTNaCTION(_ sender: UIButton) {
        if sender.tag == 1 {
            priceStr = "lowtohigh"
            self.lowButton.setImage(UIImage(named: "ciremptyfill"), for: .normal)
            self.highButton.setImage(UIImage(named: "cirempty"), for: .normal)

        }else if sender.tag == 2 {
            priceStr = "hightolow"
            self.lowButton.setImage(UIImage(named: "cirempty"), for: .normal)
            self.highButton.setImage(UIImage(named: "ciremptyfill"), for: .normal)
        }
    }
    
    @IBAction func rateBtnAction(_ sender: UIButton) {
        if sender.tag == 3 {
            ratingStr = "1"
            oneButton.setImage(UIImage(named: "fill-1"), for: .normal)
            twoButton.setImage(UIImage(named: "fl"), for: .normal)
            threeButton.setImage(UIImage(named: "fl"), for: .normal)
            fourButton.setImage(UIImage(named: "fl"), for: .normal)
            fiveButton.setImage(UIImage(named: "fl"), for: .normal)

        }else if sender.tag == 4 {
            ratingStr = "2"
            oneButton.setImage(UIImage(named: "fl"), for: .normal)
            twoButton.setImage(UIImage(named: "fill-1"), for: .normal)
            threeButton.setImage(UIImage(named: "fl"), for: .normal)
            fourButton.setImage(UIImage(named: "fl"), for: .normal)
            fiveButton.setImage(UIImage(named: "fl"), for: .normal)
        }else if sender.tag == 5 {
            ratingStr = "3"
            oneButton.setImage(UIImage(named: "fl"), for: .normal)
            twoButton.setImage(UIImage(named: "fl"), for: .normal)
            threeButton.setImage(UIImage(named: "fill-1"), for: .normal)
            fourButton.setImage(UIImage(named: "fl"), for: .normal)
            fiveButton.setImage(UIImage(named: "fl"), for: .normal)
        }else if sender.tag == 6 {
            ratingStr = "4"
            oneButton.setImage(UIImage(named: "fl"), for: .normal)
            twoButton.setImage(UIImage(named: "fl"), for: .normal)
            threeButton.setImage(UIImage(named: "fl"), for: .normal)
            fourButton.setImage(UIImage(named: "fill-1"), for: .normal)
            fiveButton.setImage(UIImage(named: "fl"), for: .normal)
        }else if sender.tag == 7 {
            ratingStr = "5"
            oneButton.setImage(UIImage(named: "fl"), for: .normal)
            twoButton.setImage(UIImage(named: "fl"), for: .normal)
            threeButton.setImage(UIImage(named: "fl"), for: .normal)
            fourButton.setImage(UIImage(named: "fl"), for: .normal)
            fiveButton.setImage(UIImage(named: "fill-1"), for: .normal)
        }
    }
    
    @IBAction func amentiesBtnAction(_ sender: UIButton) {
        if sender.tag == 8 {
            if oneBool == false {
                oneBool = true
                amentiesStr = "Wifi"
                wifiButton.setImage(UIImage(named: "fill-1"), for: .normal)
            }else {
                amentiesStr = ""
                oneBool = false
                wifiButton.setImage(UIImage(named: "fl"), for: .normal)
            }
        }else if sender.tag == 9 {
            if twoBool == false {
                twoBool = true
                amentiesStr = "Food"
                foodButton.setImage(UIImage(named: "fill-1"), for: .normal)
            }else {
                amentiesStr = ""
                twoBool = false
                foodButton.setImage(UIImage(named: "fl"), for: .normal)
            }
            
        }else if sender.tag == 10 {
            if threeBool == false {
                threeBool = true
                amentiesStr = "Furniture"
                furnitureButton.setImage(UIImage(named: "fill-1"), for: .normal)
            }else {
                amentiesStr = ""
                threeBool = false
                furnitureButton.setImage(UIImage(named: "fl"), for: .normal)
            }
            
        }else if sender.tag == 11 {
            if fourBool == false {
                fourBool = true
                amentiesStr = "Parking"
                parkingButton.setImage(UIImage(named: "fill-1"), for: .normal)
            }else {
                amentiesStr = ""
                fourBool = false
                parkingButton.setImage(UIImage(named: "fl"), for: .normal)
            }
            
        }else if sender.tag == 12 {
            if fiveBool == false {
                fourBool = true
                amentiesStr = "Transport"
                transportButton.setImage(UIImage(named: "fill-1"), for: .normal)
            }else {
                amentiesStr = ""
                fiveBool = false
                transportButton.setImage(UIImage(named: "fl"), for: .normal)
            }
        }
    }
    
    @IBAction func filterBtnAction(_ sender: Any) {
        self.filtersApiCalling()
    }
    
    @objc func backMethod(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dateButton(_ sender: UIButton) {
            //Date Picker Functionality
            picker = UIDatePicker()
            picker.backgroundColor = UIColor.white
            picker.datePickerMode = UIDatePicker.Mode.date
            picker.tag = sender.tag
            picker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: .valueChanged)
         //   let pickerSize : CGSize = picker.sizeThatFits(CGSize.zero)
        //    picker.frame = CGRect(x:0.0, y:250, width:pickerSize.width, height:460)
        picker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)

            self.view.addSubview(picker)
        

            toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            toolBar.barStyle = .blackTranslucent
            toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
            toolBar.sizeToFit()
            self.view.addSubview(toolBar)
    }
    
    //Toolbar done button function
    @objc func onDoneButtonClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        if (picker.tag == 15) {
            startDateStr = dateFormatter1.string(from: self.picker.date)
            print(startDateStr)
            self.fromDateTextField.text = startDateStr
        }else if (picker.tag == 16)  {
            endDateStr = dateFormatter1.string(from: self.picker.date)
            self.doDateTextField.text = endDateStr
        }
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
}

