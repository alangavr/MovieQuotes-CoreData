//
//  AppDelegate.swift
//  MovieQuotes
//
//  Created by CSSE Department on 3/27/18.
//  Copyright © 2018 alangavr. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //TODO: pass the managed object context into the view controller once we do CoreData
        
       // controller.context = self.persistentContainer.viewContext
        return true
    }

   
}

