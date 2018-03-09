//
//  AppDelegate.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 01/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        // Override point for customization after application launch.
        
        let parseConfig = ParseClientConfiguration{(ParseMutableClientConfiguration) in
            ParseMutableClientConfiguration.applicationId = "79d126f1a51b24eab599b49b87760cf59db02f36"
            ParseMutableClientConfiguration.clientKey = "6ee33511bd8b4d58e4ba9cce547f25738f5874ff"
            ParseMutableClientConfiguration.server = "http://13.58.147.34:80/parse"
            
        }
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        Parse.initialize(with: parseConfig)
        login()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("resign Active")
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
        print("become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func login(){
        let username:String? = UserDefaults.standard.string(forKey: "username")
        
        if username != nil{
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let myTabBar = storyboard.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController
            window?.rootViewController = myTabBar
        }
    }
}











