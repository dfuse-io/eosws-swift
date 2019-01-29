//
//  AppDelegate.swift
//  eosws-example
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import UIKit
import eosws

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let token = "eyJhbGciOiJLTVNFUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NTIxMDkyMjAsImp0aSI6Ijc1NWViYmI4LTZhMTktNDBjZi1hMjlhLTU3MTY4MjRjOTM3ZSIsImlhdCI6MTU0NDEwOTIyMCwiaXNzIjoiZGZ1c2UuaW8iLCJzdWIiOiJDaVFBNmNieWU4WkZaWFIrVmJ3YkVVbFNsa0pHQXExTHFHWlZSUzh5ZFhwVmplOFIyVzRTT1FBL0NMUnRFU1hrS05vdzJsS3ZSR3NHQ1NTMnlHRmJidFRlY3lhOE54V3c4aksvUVdWYXMwNGJJbU5GY2IvNVI1VnRRNUdXeGIxd2NBPT0iLCJ0aWVyIjoiYmV0YS12MSIsInN0YmxrIjoxLCJ2IjoxfQ._VoD77DeMGqPb0FQWzEieP5wsF7fhP3hUYo0qxoW5U7MXDS9sG8hai_FGXUE81gGj1ofW97-6z1blVvQHs29YQ"
        
        guard let eosws = try? EOSWS(forEnpoint: "wss://mainnet.eos.dfuse.io/v1/stream", restEndpoint: "", token: token, origin: "origin.example.com") else{
            print("Error: failed to init EOSWS")
            return false
        }
        
        Context.shared.eosws = eosws
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

