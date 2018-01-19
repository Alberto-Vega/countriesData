//
//  AppDelegate.swift
//  BrowseCountries
//
//  Created by Alberto Vega Gonzalez on 1/17/18.
//  Copyright © 2018 Alberto Vega Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize the window
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        // Set Background Color of window
        window?.backgroundColor = UIColor.white
        
        let navigationController = UINavigationController()
        // Allocate memory for an instance of the 'MainViewController' class
        let countriesTableViewController = ViewController()
        
        navigationController.viewControllers = [countriesTableViewController]
        
        // Set the root view controller of the app's window
        window!.rootViewController = navigationController
        
        // Make the window visible
        window!.makeKeyAndVisible()
        
        return true
    }
}

