//
//  AppDelegate.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/11/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instagram"
                configuration.clientKey = "fskdfjhsdfiuhewihiufhsdiufhsud" // set to nil assuming you have not set clientKey
                configuration.server = "https://instagram-app-ios.herokuapp.com/parse"
            })
        )
        
        // User persistence
        if PFUser.current() != nil {
            let vc = storyboard.instantiateViewController(withIdentifier: "tabBarController")
            window?.rootViewController = vc
        }
        
        //------------logOut
        NotificationCenter.default.addObserver(forName: Notification.Name("didLogout"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Logout notification received")
            // TODO: Logout the User
            logOut()
            // TODO: Load and show the login view controller
        }
       
        NotificationCenter.default.addObserver(forName: Notification.Name("didCancel"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Cancel Capture")
            // TODO: Cancel
            cancel()
            // TODO: Load and show the login view controller
            
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("didShare"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Picture Sharing Successfully")
            share()
            // TODO: Load and show the login view controller
        }
        func share(){
            if PFUser.current() != nil {
             let vc = storyboard.instantiateViewController(withIdentifier: "tabBarController")
             window?.rootViewController = vc
             }
        }
        func logOut() {
            // Logout the current user
            PFUser.logOutInBackground(block: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Successful loggout")
                    // Load and show the login view controller
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let LoginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewID")
                    self.window?.rootViewController = LoginViewController
                }
            })
        }
        func cancel(){

            if PFUser.current() != nil {
                let vc = storyboard.instantiateViewController(withIdentifier: "tabBarController")
                window?.rootViewController = vc
            }
        }
        
        return true
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


}

