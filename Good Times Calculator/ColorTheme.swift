//
//  ColorTheme.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


struct Theme {
  

  static var statusBarColor: UIStatusBarStyle = .default
  
  static var navigationBarItemsColor = UIColor.black
  
  static var viewBackgroundColor = UIColor.white
  
  static var screenBackgroundColor = UIColor.white.cgColor
  static var screenTextColor = UIColor.black
  static var screenFont = UIFont.systemFont(ofSize: 18)
  static var screenBorderColor = UIColor.white.cgColor
  
  static var memoryScreenTextColor = UIColor.black
  
  static var numberButtonBorderColor = UIColor.black.cgColor
  static var numberButtonBackgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
  static var numberButtonTitleColor = UIColor.black
  
  static var otherButtonBorderColor = UIColor.black.cgColor
  static var otherButtonBackgroundColor = UIColor.lightGray
  static var otherButtonTitleColor = UIColor.white
  
  static var settingsButtonBorderColor = UIColor.black.cgColor
  static var settingsButtonBackgroundColor = UIColor.white
  static var settingsButtonTitleColor = UIColor.black
  
  static var tableViewHeaderBackgroundColor = UIColor.lightGray
  static var tableViewHeaderTextColor = UIColor.darkGray
  
  static var clearAllButtonBackgroundColor = UIColor.lightGray
  static var clearCurrentButtonBackgroundColor = UIColor.lightGray
  static var backspaceButtonBackgroundColor = UIColor.lightGray
  static var memoryButtonBackgroundColor = UIColor.lightGray
  static var percentageButtonBackgroundColor = UIColor.lightGray
  static var plusMinusButtonBackgroundColor = UIColor.lightGray
  
  static var colorThemeButtonBackgroundColor = UIColor.black
  
  static var tableViewHeaderFont = UIFont.systemFont(ofSize: 16)
  //static var tableViewHeaderFont = UIFont(name: "Helvetica", size: 16)
  
  static var topRowButtonsGreenModeTextColor = UIColor.black
  
  static var toggleHighlightColor = UIColor.green
  
  
  static func blackAndWhite() {
    
    let defaults   = UserDefaults.standard
    let darkModeOn = defaults.bool(forKey: "darkModeOn")
    
    defaults.set(true,  forKey: "blackAndWhiteThemeOn")
    defaults.set(false, forKey: "greenThemeOn")
    defaults.set(false, forKey: "redThemeOn")
    defaults.set(false, forKey: "blueThemeOn")
    
    navigationBarItemsColor         = darkModeOn ?          UIColor.white : UIColor.black
    screenTextColor                 = darkModeOn ?          UIColor.white : UIColor.black
    screenBorderColor               = darkModeOn ?  UIColor.black.cgColor : UIColor.white.cgColor
    memoryScreenTextColor           = darkModeOn ?      UIColor.lightBlue : UIColor.blue
    numberButtonBorderColor         = darkModeOn ?  UIColor.white.cgColor : UIColor.black.cgColor
    numberButtonTitleColor          = darkModeOn ?          UIColor.white : UIColor.black
    numberButtonBackgroundColor     = darkModeOn ? UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1) :                                                      UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
    otherButtonBorderColor          = darkModeOn ?  UIColor.white.cgColor : UIColor.black.cgColor
    otherButtonTitleColor           = darkModeOn ?          UIColor.white : UIColor.black
    settingsButtonBorderColor       = darkModeOn ?  UIColor.white.cgColor : UIColor.black.cgColor
    settingsButtonTitleColor        = darkModeOn ?          UIColor.white : UIColor.black
    tableViewHeaderTextColor        = darkModeOn ?      UIColor.lightGray : UIColor.darkGray
    colorThemeButtonBackgroundColor = darkModeOn ?          UIColor.white : UIColor.black
    toggleHighlightColor            = darkModeOn ?          UIColor.white : UIColor.black
    
    clearAllButtonBackgroundColor   = darkModeOn ? UIColor(red: 0.8, green: 0.3, blue: 0.17, alpha: 1) :
                                                   UIColor(red: 0.95, green: 0.45, blue: 0.2, alpha: 1)
    memoryButtonBackgroundColor     = darkModeOn ? UIColor(red: 0.12, green: 0.45, blue: 0.65, alpha: 1) :
                                                   UIColor(red: 0.2, green: 0.68, blue: 0.94, alpha: 1)
    percentageButtonBackgroundColor = darkModeOn ? UIColor(red: 0.18, green: 0.68, blue: 0.08, alpha: 1) :
                                                   UIColor(red: 0.24, green: 0.75, blue: 0.14, alpha: 1)
    plusMinusButtonBackgroundColor  = darkModeOn ? UIColor(red: 0.85, green: 0.8, blue: 0.08, alpha: 1) :
                                                   UIColor(red: 0.94, green: 0.84, blue: 0.26, alpha: 1)
  }
  
  static func greenMode() {
    
    let defaults   = UserDefaults.standard
    let darkModeOn = defaults.bool(forKey: "darkModeOn")
    
    defaults.set(false, forKey: "blackAndWhiteThemeOn")
    defaults.set(true,  forKey: "greenThemeOn")
    defaults.set(false, forKey: "redThemeOn")
    defaults.set(false, forKey: "blueThemeOn")
    
    navigationBarItemsColor         = darkModeOn ?          UIColor.green : UIColor.darkGreen
    screenTextColor                 = darkModeOn ?          UIColor.green : UIColor.darkGreen
    screenBorderColor               = darkModeOn ?  UIColor.green.cgColor : UIColor.darkGreen.cgColor
    memoryScreenTextColor           = darkModeOn ?      UIColor.lightBlue : UIColor.blue
    numberButtonBorderColor         = darkModeOn ?  UIColor.green.cgColor : UIColor.darkGreen.cgColor
    numberButtonTitleColor          = darkModeOn ?          UIColor.green : UIColor.darkGreen
    otherButtonBorderColor          = darkModeOn ?  UIColor.green.cgColor : UIColor.darkGreen.cgColor
    otherButtonTitleColor           = darkModeOn ?          UIColor.green : UIColor.darkGreen
    settingsButtonBorderColor       = darkModeOn ?  UIColor.green.cgColor : UIColor.darkGreen.cgColor
    settingsButtonTitleColor        = darkModeOn ?          UIColor.green : UIColor.darkGreen
    tableViewHeaderTextColor        = darkModeOn ?      UIColor.lightGray : UIColor.darkGray
    topRowButtonsGreenModeTextColor = darkModeOn ?       UIColor.darkGray : UIColor.darkGreen
    toggleHighlightColor            = darkModeOn ?          UIColor.green : UIColor.darkGreen
    
    clearAllButtonBackgroundColor   = darkModeOn ? UIColor(red: 0.6, green: 0.8, blue: 0.15, alpha: 1) :
                                                   UIColor(red: 0.6, green: 0.8, blue: 0.15, alpha: 1)
    memoryButtonBackgroundColor     = darkModeOn ? UIColor(red: 0.15, green: 0.9, blue: 0.6, alpha: 1) :
                                                   UIColor(red: 0.15, green: 0.9, blue: 0.6, alpha: 1)
    percentageButtonBackgroundColor = darkModeOn ? UIColor(red: 0.18, green: 0.68, blue: 0.08, alpha: 1) :
                                                   UIColor(red: 0.24, green: 0.75, blue: 0.14, alpha: 1)
    plusMinusButtonBackgroundColor  = darkModeOn ? UIColor(red: 0.85, green: 0.8, blue: 0.08, alpha: 1) :
                                                   UIColor(red: 0.94, green: 0.84, blue: 0.26, alpha: 1)
  }
  
  static func redMode() {
    
    let defaults   = UserDefaults.standard
    let darkModeOn = defaults.bool(forKey: "darkModeOn")
    
    defaults.set(false, forKey: "blackAndWhiteThemeOn")
    defaults.set(false, forKey: "greenThemeOn")
    defaults.set(true,  forKey: "redThemeOn")
    defaults.set(false, forKey: "blueThemeOn")
    
    navigationBarItemsColor   = darkModeOn ?         UIColor.red : UIColor.darkModeRed
    screenTextColor           = darkModeOn ?         UIColor.red : UIColor.darkModeRed
    screenBorderColor         = darkModeOn ? UIColor.red.cgColor : UIColor.darkModeRed.cgColor
    memoryScreenTextColor     = darkModeOn ?   UIColor.lightBlue : UIColor.blue
    numberButtonBorderColor   = darkModeOn ? UIColor.red.cgColor : UIColor.darkModeRed.cgColor
    numberButtonTitleColor    = darkModeOn ?         UIColor.red : UIColor.darkModeRed
    otherButtonBorderColor    = darkModeOn ? UIColor.red.cgColor : UIColor.darkModeRed.cgColor
    otherButtonTitleColor     = darkModeOn ?         UIColor.red : UIColor.darkModeRed
    settingsButtonBorderColor = darkModeOn ? UIColor.red.cgColor : UIColor.darkModeRed.cgColor
    settingsButtonTitleColor  = darkModeOn ?         UIColor.red : UIColor.darkModeRed
    tableViewHeaderTextColor  = darkModeOn ?   UIColor.lightGray : UIColor.darkGray
    toggleHighlightColor      = darkModeOn ?         UIColor.red : UIColor.darkModeRed
    //tableViewHeaderTextColor  = darkModeOn ?          UIColor.red : UIColor.darkModeRed
    
    clearAllButtonBackgroundColor   = darkModeOn ? UIColor(red: 0.97, green: 0.55, blue: 0.3, alpha: 0.7) :
                                                   UIColor(red: 0.97, green: 0.55, blue: 0.3, alpha: 1)
    memoryButtonBackgroundColor     = darkModeOn ? UIColor(red: 0.6, green: 0.35, blue: 0.65, alpha: 0.7) :
                                                   UIColor(red: 0.6, green: 0.35, blue: 0.65, alpha: 1)
    percentageButtonBackgroundColor = darkModeOn ? UIColor(red: 0.1, green: 0.73, blue: 0.5, alpha: 0.7) :
                                                   UIColor(red: 0.1, green: 0.73, blue: 0.5, alpha: 1)
    plusMinusButtonBackgroundColor  = darkModeOn ? UIColor(red: 0.98, green: 0.68, blue: 0.1, alpha: 0.7) :
                                                   UIColor(red: 0.98, green: 0.68, blue: 0.1, alpha: 1)
  }
  
  static func blueMode() {
    
    let defaults = UserDefaults.standard
    let darkModeOn = defaults.bool(forKey: "darkModeOn")
    
    defaults.set(false, forKey: "blackAndWhiteThemeOn")
    defaults.set(false, forKey: "greenThemeOn")
    defaults.set(false, forKey: "redThemeOn")
    defaults.set(true,  forKey: "blueThemeOn")
    
    navigationBarItemsColor   = darkModeOn ?  UIColor.lightBlue : UIColor.blue
    screenTextColor           = darkModeOn ?  UIColor.lightBlue : UIColor.blue
    screenBorderColor         = darkModeOn ?  UIColor.lightBlue.cgColor : UIColor.blue.cgColor
    memoryScreenTextColor     = darkModeOn ?  UIColor.lightBlue : UIColor.blue
    numberButtonBorderColor   = darkModeOn ?  UIColor.lightBlue.cgColor : UIColor.blue.cgColor
    numberButtonTitleColor    = darkModeOn ?  UIColor.lightBlue : UIColor.blue
    otherButtonBorderColor    = darkModeOn ?  UIColor.lightBlue.cgColor : UIColor.blue.cgColor
    otherButtonTitleColor     = darkModeOn ?  UIColor.lightBlue : UIColor.blue
    settingsButtonBorderColor = darkModeOn ?  UIColor.lightBlue.cgColor : UIColor.blue.cgColor
    settingsButtonTitleColor  = darkModeOn ?  UIColor.lightBlue : UIColor.blue
    tableViewHeaderTextColor  = darkModeOn ?  UIColor.lightGray : UIColor.darkGray
    toggleHighlightColor      = darkModeOn ?  UIColor.lightBlue : UIColor.blue
    //tableViewHeaderTextColor  = darkModeOn ?          UIColor.lightBlue : UIColor.blue
    
    clearAllButtonBackgroundColor   = darkModeOn ? UIColor(red: 0.65, green: 0.35, blue: 0.85, alpha: 0.7) :
                                                   UIColor(red: 0.65, green: 0.35, blue: 0.85, alpha: 1)
    memoryButtonBackgroundColor     = darkModeOn ? UIColor(red: 0.35, green: 0.48, blue: 0.9, alpha: 0.7) :
                                                   UIColor(red: 0.35, green: 0.48, blue: 0.9, alpha: 1)
    percentageButtonBackgroundColor = darkModeOn ? UIColor(red: 0.15, green: 0.8, blue: 0.58, alpha: 0.7) :
                                                   UIColor(red: 0.15, green: 0.8, blue: 0.58, alpha: 1)
    plusMinusButtonBackgroundColor  = darkModeOn ? UIColor(red: 0.8, green: 0.9, blue: 0.28, alpha: 0.7) :
                                                   UIColor(red: 0.8, green: 0.9, blue: 0.28, alpha: 1)
  }
  
  static func darkMode() {
    
    let defaults = UserDefaults.standard
    let darkModeOn = defaults.bool(forKey: "darkModeOn")
    
    if defaults.bool(forKey: "blackAndWhiteThemeOn") {
      Theme.blackAndWhite()
    }
    if defaults.bool(forKey: "greenThemeOn") {
      Theme.greenMode()
    }
    if defaults.bool(forKey: "blueThemeOn") {
      Theme.blueMode()
    }
    if defaults.bool(forKey: "redThemeOn") {
      Theme.redMode()
    }

    statusBarColor                  = darkModeOn ?         .lightContent : .default
    viewBackgroundColor             = darkModeOn ?         UIColor.black : UIColor.white
    screenBackgroundColor           = darkModeOn ? UIColor.black.cgColor : UIColor.white.cgColor
    numberButtonBackgroundColor     = darkModeOn ? UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1) :
                                                   UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
    otherButtonBackgroundColor      = darkModeOn ?      UIColor.darkGray : UIColor.lightGray
    settingsButtonBackgroundColor   = darkModeOn ?         UIColor.black : UIColor.white
    tableViewHeaderBackgroundColor  = darkModeOn ?      UIColor.darkGray : UIColor.lightGray
    colorThemeButtonBackgroundColor = darkModeOn ?         UIColor.black : UIColor.white
  }
  
  
  static func retroMode() {
    
    let defaults        = UserDefaults.standard
    let retroModeOn     = defaults.bool(forKey: "retroModeOn")
    
    let retroFont       = UIFont(name: "DS-Digital-BoldItalic", size: 22)
    let standardFont    = UIFont.systemFont(ofSize: 18)
    
    screenFont          = (retroModeOn ? retroFont : standardFont)!
    
    tableViewHeaderFont = (retroModeOn ? UIFont(name: "DS-Digital-BoldItalic", size: 22) :
                                         UIFont.systemFont(ofSize: 16))!
  }
  
}
