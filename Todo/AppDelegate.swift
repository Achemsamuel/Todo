//
//  AppDelegate.swift
//  Todo
//
//  Created by Achem Samuel on 1/8/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do {
             _ = try Realm()
        } catch {
            print("Error initiatlising Realm class: \(error)")
        }
        

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
}

