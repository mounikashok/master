//
//  AlertViewController.swift
//  OFA
//
//  Created by mounika on 05/09/19.
//  Copyright © 2019 Mounika Ashok. All rights reserved.
//

import UIKit

protocol NotifyReloadCoreData {
    func notifyDelegate(_ str: String, playerIndex: Int)
}

class AlertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var transImageView: UIImageView!
    @IBOutlet var vw_language: UIView!
    @IBOutlet var tbl_language: UITableView!
    @IBOutlet var vw_alert: UIView!
    @IBOutlet var const_vw_lang_width: NSLayoutConstraint!
    @IBOutlet var const_vw_lang_height: NSLayoutConstraint!
    var arr_languages : NSMutableArray = NSMutableArray()
    var delegate: NotifyReloadCoreData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_language.register(UINib(nibName: "LanguageTableCell", bundle: nil), forCellReuseIdentifier: "LanguageTableCell")
        tbl_language.delegate = self
        tbl_language.dataSource = self
        vw_language.clipsToBounds = true
        vw_language.layer.cornerRadius = 20.0
        vw_alert.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 59.0/255.0, alpha: 0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView(_:)))
        self.transImageView.addGestureRecognizer(tap)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK:- tableviewDelegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1;
        if (arr_languages.count>0)
        {
            count = arr_languages.count
            return count
        }else
        {
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : LanguageTableCell = tbl_language.dequeueReusableCell(withIdentifier: "LanguageTableCell") as! LanguageTableCell
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if (arr_languages.count>0)
        {
            cell.textLabel?.text = ""
            cell.lbl_language.text = arr_languages.object(at: indexPath.row) as? String
            cell.lbl_language.textColor = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell : LanguageTableCell = tbl_language.dequeueReusableCell(withIdentifier: "LanguageTableCell") as! LanguageTableCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.notifyDelegate((arr_languages.object(at: indexPath.row) as? String)!, playerIndex: indexPath.row)
        self.dismiss(animated: true, completion: nil)
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
    
    @objc func dismissView(_ sender:UITapGestureRecognizer)
    {
//        self.dismiss(animated: true) {
//            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
//        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
  /*  //MARK:- rotateDevice
    
    @objc func rotateDevice(sender : Notification)
    {
        enableOrDisableScrollView()
    }
    
    //enable or disable scrollview ....
    
    //MARK: - enableOrDisableScrollView
    
    func enableOrDisableScrollView()
    {
        switch UIDevice.current.orientation
        {
        case .landscapeLeft, .landscapeRight:
            applyLandScapeConstarints()
            break
        case .portrait:
            applyPortraitConstarints()
            break
        default:
            print("other")
            break
        }
    }
    
    //MARK: - applyLandScapeConstarints
    
    func applyLandScapeConstarints()
    {
        self.view.removeConstraint(const_vw_lang_width)
        self.view.removeConstraint(const_vw_lang_height)
       
        const_vw_lang_width = NSLayoutConstraint(item: vw_language, attribute: .width, relatedBy: .equal, toItem: vw_alert, attribute: .width
            , multiplier: 0.8, constant: 0.0)
        vw_alert.addConstraint(const_vw_lang_width)
        
        const_vw_lang_height = NSLayoutConstraint(item: vw_language, attribute: .width, relatedBy: .equal, toItem: vw_alert, attribute: .width
            , multiplier: 0.4, constant: 0.0)
        vw_alert.addConstraint(const_vw_lang_height)
        
        vw_alert.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    //MARK: - applyPortraitConstarints
    
    func applyPortraitConstarints()
    {
        self.view.removeConstraint(const_vw_lang_width)
        self.view.removeConstraint(const_vw_lang_height)
        vw_alert.removeConstraint(const_vw_lang_width)
        vw_alert.removeConstraint(const_vw_lang_height)
        
        const_vw_lang_width = NSLayoutConstraint(item: vw_language, attribute: .width, relatedBy: .equal, toItem: vw_alert, attribute: .width
            , multiplier: 0.8, constant: 0.0)
        vw_alert.addConstraint(const_vw_lang_width)
        
        const_vw_lang_height = NSLayoutConstraint(item: vw_language, attribute: .width, relatedBy: .equal, toItem: vw_alert, attribute: .width
            , multiplier: 0.4, constant: 0.0)
        vw_alert.addConstraint(const_vw_lang_height)
        
        vw_alert.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    //MARK:- dismissView
    
    @objc func dismissView(_ sender:UITapGestureRecognizer)
    {
        self.dismiss(animated: true) {
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
    }*/
    
}
