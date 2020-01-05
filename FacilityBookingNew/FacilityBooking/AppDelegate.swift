//
//  AppDelegate.swift
//  FacilityBooking
//
//  Created by iso99 on 9/24/19.
//  Copyright © 2019 iso99. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import GoogleMaps


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    var rootController: UIViewController! = nil
    var window: UIWindow?
    var udf = UserDefaults()
    var initialViewControlleripad : UIViewController!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //For Facebook
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Adding Google Key
        //AIzaSyB19jB_v-7dlArtrsKihevMeqxtTjg0hNQ
         GMSServices.provideAPIKey("AIzaSyARloI7xYHrUDIUeKjIE2Dey_ecnKtoEjU")

        //For Initialize Google SignIn
        GIDSignIn.sharedInstance().clientID = "132380593085-cador7n0bson28sudhvqtv4gqitvtq4a.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if udf.bool(forKey: "LOGIN") {
            initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "AfterLogin") as UIViewController
        }else {
            initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "BrforeLogin") as UIViewController
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewControlleripad
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    // set the status bar color
    var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (url.scheme?.hasPrefix("fb"))! {
               return ApplicationDelegate.shared.application(app, open: url, options: options)
           }
           else
           {
            return GIDSignIn.sharedInstance().handle(url)
           }
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func errorMessage(messge: String) {
        let alert = UIAlertController(title: "Alert", message: messge, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.window?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {

    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

    }
}

extension UIApplication{
    var topViewController: UIViewController?{
        if keyWindow?.rootViewController == nil{
            return keyWindow?.rootViewController
        }

        var pointedViewController = keyWindow?.rootViewController

        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController

    }
}

