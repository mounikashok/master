//
//  Extensions.swift
//  EventClap
//
//  Created by promm on 16/09/19.
//  Copyright © 2019 promm. All rights reserved.
//

import Foundation
import UIKit
extension UITextField
{
    func setPadding()
    {
        let paddingView = UIView(frame: CGRect(x: 50, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    //border line for textfield
    func underlined()
    {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
        func addBottomBorder(){
            let bottomLine = CALayer()
            bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
            bottomLine.backgroundColor = UIColor(red: 1/255, green: 38/255, blue: 103/255, alpha: 1.0).cgColor
            self.borderStyle = .none
            self.layer.addSublayer(bottomLine)
            
        }
}

extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}







extension UIViewController
{
    //alert controller
    func alert(withTitle title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //email vaildation
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
}
//gradient colour for button
extension UIButton
{
    func colourGradient(btn:UIButton)
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        // loginAction.translatesAutoresizingMaskIntoConstraints = true
        gradient.colors = [
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor,
            UIColor(red: 254/255, green: 246/255, blue: 225/255, alpha: 1).cgColor,
            UIColor(red: 254/255, green: 246/255, blue: 225/255, alpha: 1).cgColor,
            UIColor(red: 254/255, green: 246/255, blue: 225/255, alpha: 1).cgColor
        ]
        /* repeat the central location to have solid colors */
        gradient.locations = [0, 0.5, 0.5, 1]
        /* make it horizontal */
        //        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        //        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradient, at: 0)
    }
}
//adding bottom border for view
extension UIView
{
    func addBorders(edges: UIRectEdge = .all, color: UIColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1.0), width: CGFloat = 1.0) {
        
        func createBorder() -> UIView {
            let borderView = UIView(frame: CGRect.zero)
            borderView.translatesAutoresizingMaskIntoConstraints = false
            borderView.backgroundColor = color
            return borderView
        }
        if (edges.contains(.all) || edges.contains(.bottom)) {
            let bottomBorder = createBorder()
            self.addSubview(bottomBorder)
            NSLayoutConstraint.activate([
                bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                bottomBorder.heightAnchor.constraint(equalToConstant: width)
                ])
        }
    }
}
enum VerticalLocation: String {
    case bottom
    case top
}
extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .lightGray, opacity: Float = 0.5, radius: CGFloat = 2.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -3), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .lightGray, opacity: Float = 0.5, radius: CGFloat = 2.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
extension UITextField {
    
    func addShadowToTextField(color: UIColor = UIColor.gray, cornerRadius: CGFloat) {
        
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
    }
}
extension UITextField {
    
    func applyCustomEffect() {
        self.borderStyle = .none
        self.backgroundColor = UIColor.groupTableViewBackground // Use anycolor that give you a 2d look.
        
        //To apply corner radius
        self.layer.cornerRadius = self.frame.size.height / 2
        
        //To apply border
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.white.cgColor
        
        //To apply Shadow
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSize.zero // Use any CGSize
        self.layer.shadowColor =
            UIColor.lightGray.cgColor
        
        self.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
    }
}
