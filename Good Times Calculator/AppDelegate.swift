//
//  AppDelegate.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  let defaults = UserDefaults.standard
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    if defaults.bool(forKey: "blueThemeOn") {
      Theme.blueMode()
    }
    else if defaults.bool(forKey: "greenThemeOn") {
      Theme.greenMode()
    }
    else if  defaults.bool(forKey: "redThemeOn") {
      Theme.redMode()
    }
    else {
      Theme.blackAndWhite()
    }
    
    if defaults.bool(forKey: "darkModeOn") {
      Theme.darkMode()
    }
    if defaults.bool(forKey: "retroModeOn") {
      Theme.retroMode()
    }
    
    defaults.set(false, forKey: "partyModeOn")
    defaults.set(true, forKey: "retroSoundsOff")
    
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = NavController(rootViewController: ViewController())
    window?.makeKeyAndVisible()
    
    UINavigationBar.appearance().tintColor = Theme.navigationBarItemsColor
    UINavigationBar.appearance().barTintColor = Theme.viewBackgroundColor
    
    

    return true
  }
  
}
