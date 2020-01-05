//
//  BackgroundView.swift
//  HubShield
//
//  Created by Anjankumar on 23/04/19.
//  Copyright © 2019 DATA-SOFT. All rights reserved.
//

import Foundation
import UIKit
class ConstraintsBackground {
    
//    static func setService(string)
//    {
//
//    }
    
    static func setTextViewBorderMethod(viw1 : UIView)
    {
        viw1.backgroundColor = UIColor.white
        viw1.layer.shadowColor = UIColor.gray.cgColor
        viw1.layer.shadowOpacity = 0.2
        viw1.layer.borderWidth = 0.5
        viw1.layer.borderColor = UIColor.gray.cgColor
        viw1.layer.cornerRadius = 0
        viw1.layer.shadowOffset = CGSize.zero
        viw1.layer.shadowRadius = 4
    }
    static func setBorderColorMethod(academicLevelView : UIView)
    {
       academicLevelView.layer.cornerRadius = 5.0;
      academicLevelView.layer.borderColor = UIColor(red:170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 1.0).cgColor;
      academicLevelView.layer.borderWidth = 0.6;
     academicLevelView.layer.masksToBounds = true
    }
    static func setButtonColorMethod(button : UIButton)
    {
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.colors = [UIColor(red:23 / 255, green: 108 / 255, blue: 22 / 255, alpha: 1.0).cgColor, UIColor(red:42 / 255, green: 174 / 255, blue: 47 / 255, alpha: 1.0).cgColor]
        gradient1.locations = [0.0 , 1.0]
        gradient1.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient1.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient1.frame = CGRect(x: 0.0, y: 0.0, width: 315, height: 40)
        button.layer.insertSublayer(gradient1, at: 0)
    }
    static func setSideview(sideView : UIView)
    {
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.colors = [UIColor(red:136 / 255, green: 96 / 255, blue: 208 / 255, alpha: 1.0).cgColor, UIColor(red:90 / 255, green: 184 / 255, blue: 235 / 255, alpha: 1.0).cgColor]
        gradient1.locations = [0.0 , 1.0]
        gradient1.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient1.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient1.frame = CGRect(x: 0.0, y: 0.0, width: 414, height: 10)
        sideView.layer.insertSublayer(gradient1, at: 0)
    }
    
    static func cornerMethod(view : UIView){
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor(red:221 / 255, green: 218 / 255, blue: 242 / 255, alpha: 1.0).cgColor
        view.layer.borderWidth = 1.0;
    }
    static func setViewBackgroundColorMethod(view : UIView){
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        let colorTop = UIColor(red:90 / 255, green: 184 / 255, blue: 235 / 255, alpha: 1.0).cgColor
        let colorBottom =  UIColor(red:136 / 255, green: 96 / 255, blue: 208 / 255, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static func dashBoardBacground1(view1 : UIView){
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.colors = [UIColor(red:53 / 255, green: 74 / 255, blue: 139 / 255, alpha: 1.0).cgColor, UIColor(red:105 / 255, green: 87 / 255, blue: 199 / 255, alpha: 1.0).cgColor]
        gradient1.locations = [0.0 , 1.0]
        gradient1.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient1.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient1.frame = CGRect(x: 0.0, y: 0.0, width: 335, height: 150)
        view1.layer.insertSublayer(gradient1, at: 0)
    }
    static func dashBoardBacground2(view2 : UIView){
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.colors = [UIColor(red:201 / 255, green: 64 / 255, blue: 110 / 255, alpha: 1.0).cgColor, UIColor(red:238 / 255, green: 92 / 255, blue: 111 / 255, alpha: 1.0).cgColor]
        gradient1.locations = [0.0 , 1.0]
        gradient1.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient1.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient1.frame = CGRect(x: 0.0, y: 0.0, width: 335, height: 150)
        view2.layer.insertSublayer(gradient1, at: 0)
    }
    static func dashBoardBacground3(view3 : UIView){
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.colors = [UIColor(red:0 / 255, green: 122 / 255, blue: 136 / 255, alpha: 1.0).cgColor, UIColor(red:0 / 255, green: 189 / 255, blue: 205 / 255, alpha: 1.0).cgColor]
        gradient1.locations = [0.0 , 1.0]
        gradient1.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient1.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient1.frame = CGRect(x: 0.0, y: 0.0, width: 335, height: 150)
        view3.layer.insertSublayer(gradient1, at: 0)
    }
    static func dashBoardBacground4(view4 : UIView){
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.colors = [UIColor(red:135 / 255, green: 71 / 255, blue: 245 / 255, alpha: 1.0).cgColor, UIColor(red:208 / 255, green: 107 / 255, blue: 237 / 255, alpha: 1.0).cgColor]
        gradient1.locations = [0.0 , 1.0]
        gradient1.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient1.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient1.frame = CGRect(x: 0.0, y: 0.0, width: 335, height: 150)
        view4.layer.insertSublayer(gradient1, at: 0)
    }
}
