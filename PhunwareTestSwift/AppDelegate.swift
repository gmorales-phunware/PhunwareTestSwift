//
//  AppDelegate.swift
//  PhunwareTestSwift
//
//  Created by Gabriel Morales on 2/8/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    class func appDelegate() -> AppDelegate {
        
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        setAppearence()
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Orientation
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return (UI_USER_INTERFACE_IDIOM() == .Pad) ? .All : .Portrait
    }
    
    // MARK: - Appearence
    func setAppearence() {
        let navBar = UINavigationBar.appearance()
        navBar.translucent = false
        navBar.barTintColor = UIColor(red:0, green:0.56, blue:0.8, alpha:1)
        navBar.tintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Book", size: 18)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let barButtonItem = UIBarButtonItem.appearance()
        barButtonItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir-Book", size: 15)!, NSForegroundColorAttributeName: UIColor.blackColor()], forState: .Normal)
        barButtonItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], forState: .Highlighted)
        
        if #available(iOS 9.0, *) {
            UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UINavigationBar.self]).tintColor = UIColor.whiteColor()
        } else {
            // Fallback on earlier versions
        }
    }
    
}

