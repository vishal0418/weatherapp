//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Vishal Patel on 26/10/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    static let APIKEY = "318448face4c7030a4fa7d02caf22b1d"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Create a UIWindow instance
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Load the initial view controller from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        
        // Set the root view controller
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        
        
        return true
    }
}

