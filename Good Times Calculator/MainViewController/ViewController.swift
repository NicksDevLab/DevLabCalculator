//
//  ViewController.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
 
  let settingsVC = SettingsViewController()
  var titleView = MainTitleView()
  var rightNavBarItem: RightNavBarItem!
  var calculatorView: CalculatorView!
  var backButtonItem: SettingsVCBackButtonItem!
  
  var screenOne: ScreenLabel!
  var screenTwo: ScreenLabel!
  var screenThree: ScreenLabel!
  
  var firstRowButtons:  [Button]!
  var secondRowButtons: [Button]!
  var otherButtons:     [Button]!
  var numberButtons:    [Button]!
  
  let formatter = NumberFormatter()
  
  var defaultFont: UIFont!
  
  let defaults = UserDefaults.standard
  
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return Theme.statusBarColor
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    calculatorView = CalculatorView(frame: .zero, width: view.frame.width,
                                                  height: view.frame.height)
    self.view.addSubview(calculatorView)
    
    NSLayoutConstraint.activate([
      calculatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      calculatorView.topAnchor.constraint(equalTo: view.topAnchor),
      calculatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      calculatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    checkUserInterface()
//    for family: String in UIFont.familyNames {
//      print(family)
//      for names: String in UIFont.fontNames(forFamilyName: family) {
//        print("== \(names)")
//      }
//    }
    
    defaultFont = titleView.textLabel.font
    self.navigationItem.titleView = titleView
    
    rightNavBarItem = RightNavBarItem()
    rightNavBarItem.target = self
    rightNavBarItem.action = #selector(presentSettingsView)
    
    backButtonItem = SettingsVCBackButtonItem()
    
    self.navigationItem.backBarButtonItem = backButtonItem
    
    self.navigationItem.rightBarButtonItem = rightNavBarItem
    
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 6
    
    setupReferences()
  }
  
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    checkUserInterface()
  }
  
  
  func checkUserInterface() {
    
    switch self.traitCollection.userInterfaceStyle {
    case .light, .unspecified:
      let switched = UISwitch()
      switched.isOn = false
      settingsVC.darkModeToggled(switched)
      self.resetView()
    case .dark:
      let switched = UISwitch()
      switched.isOn = true
      settingsVC.darkModeToggled(switched)
      self.resetView()
    default:
      print("new case")
    }
  }
  
  // MARK: CalculatorView y origin changing in viewDidLayoutSubviews().
  //       Probably to account for navigationBar.
  //       This change effects the size of screenPortionOfScreen and buttonPortionOfScreen.
  
  
  override func viewWillAppear(_ animated: Bool) {
    
    setColors()
    
    if defaults.bool(forKey: "modeChanged") {
      
      resetView()
      
      defaults.set(false, forKey: "modeChanged")
    }
    
    if defaults.bool(forKey: "partyModeOn") {

      UIView.animate(withDuration: 0.4, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
        
        for each in self.firstRowButtons {
          each.backgroundColor = UIColor.random
        }
        for each in self.secondRowButtons {
          each.backgroundColor = UIColor.random
        }
        for each in self.numberButtons {
          each.backgroundColor = UIColor.random
        }
        for each in self.otherButtons {
          each.backgroundColor = UIColor.random
        }
        
        self.screenOne.textColor = UIColor.random
        self.screenTwo.textColor = UIColor.random
        
      }, completion: nil)

    }
    
  }

  
  func resetView() {
    
    self.view.backgroundColor = Theme.viewBackgroundColor
    self.navigationController?.navigationBar.barTintColor = Theme.viewBackgroundColor
    self.navigationController?.navigationBar.tintColor = Theme.navigationBarItemsColor
    self.titleView.textLabel.textColor = Theme.navigationBarItemsColor
    self.navigationController?.navigationBar.layoutIfNeeded() //Needs to be called to animate changes to navigationBar.
    self.navigationController?.setNeedsStatusBarAppearanceUpdate()
    
    for everyView in calculatorView.subviews {
      everyView.removeFromSuperview()
    }
    
    titleView.textLabel.font = UIFont.systemFont(ofSize: 18)
    
    calculatorView.firstRowButtons  = []
    calculatorView.secondRowButtons = []
    calculatorView.otherButtons     = []
    calculatorView.numberButtons    = []
    
    calculatorView.setupView()
    calculatorView.setColors()
    
    if calculatorView.screenThree.text?.isEmpty == false {
      calculatorView.firstRowButtons.itemWithTitle(title: "MS")?.isSelected = true
    }
    
    setupReferences()
  }
  
  
  override func viewDidLayoutSubviews() {

    if isFirstLoad {
      
      for everyView in calculatorView.subviews {
        everyView.removeFromSuperview()
      }
      
      titleView.textLabel.font = UIFont.systemFont(ofSize: 18)
      
      calculatorView.firstRowButtons  = []
      calculatorView.secondRowButtons = []
      calculatorView.otherButtons     = []
      calculatorView.numberButtons    = []

      calculatorView.setupView()
      calculatorView.setColors()
      
      setupReferences()
      
      isFirstLoad = false
    }
  }
  
  
  var isFirstLoad = true
  
  func setupReferences() {
    
    screenOne   = calculatorView.screenOne
    screenTwo   = calculatorView.screenTwo
    screenThree = calculatorView.screenThree
    
    firstRowButtons   = calculatorView.firstRowButtons
    secondRowButtons  = calculatorView.secondRowButtons
    otherButtons      = calculatorView.otherButtons
    numberButtons     = calculatorView.numberButtons

    for each in numberButtons {
      each.addTarget(self, action: #selector(numberButtonPressed), for: .touchUpInside)
    }
    for each in firstRowButtons {
      each.addTarget(self, action: #selector(memoryButtonPressed), for: .touchUpInside)
    }
    for each in secondRowButtons {
      each.addTarget(self, action: #selector(numberButtonPressed), for: .touchUpInside)
    }
    for each in otherButtons {
      each.addTarget(self, action: #selector(otherButtonPressed), for: .touchUpInside)
    }
  }
  
  
  func setColors() {
    self.view.backgroundColor     = Theme.viewBackgroundColor
    titleView.textLabel.textColor = Theme.navigationBarItemsColor
    calculatorView.setColors()
  }
  
  
  var currentNumber: Double = 0
  var displayNumber = ""
  
  var screenTwoNumbers: [String] = []
  
  var numberIsNew = true
  
  // MARK: numberButtonPressed
  @objc
  func numberButtonPressed(_ sender: UIButton) {
    
    if isPerformingMath {
      displayNumber = ""
      isPerformingMath = false
    }
    
    if screenTwoNumbers.last == "%" {
      screenTwoNumbers = []
    }
    
    if defaults.bool(forKey: "equalsSelectedLast") || defaults.bool(forKey: "plusMinusSelectedLast") {
      screenTwoNumbers = []
    }
    
    if sender.currentTitle != "+/-" {
      defaults.set(false, forKey: "plusMinusSelectedLast")
    }
    
    if sender.tag >= 0 && sender.tag <= 11 {
      
      var newDigit = ""
      
      if sender.tag == 11 {
        
        guard !displayNumber.contains(".") else { return }
        newDigit = displayNumber == "" ? "0." : "."
        displayNumber = displayNumber + newDigit
        
        if numberIsNew {
          currentNumber = 0
        }
        
        if numberIsNew == false {
          guard screenTwoNumbers.count > 0 else { return }
          screenTwoNumbers.removeLast()
        }
        
        screenTwoNumbers.insert(displayNumber, at: screenTwoNumbers.count)
        numberIsNew = false
        return
        
      } else {
        
        newDigit = String(sender.tag)
        
      }
      
      if mRselectedLast {
        currentNumber = 0
        displayNumber = ""
        mRselectedLast = false
        if screenTwoNumbers.isEmpty != true {
          screenTwoNumbers.removeLast()
        }
      }
      
      displayNumber = displayNumber + newDigit
      
      let text = displayNumber.filter { $0 != ","  }
      
      guard text.count <= 15 else { return }
      
      if text.contains(".") && newDigit == "0" {
        screenOne.text = displayNumber
        
      } else {
        
        //TODO: fix this.
        currentNumber = formatter.number(from: text) as? Double ?? 0
        displayNumber = formatter.string(from: NSNumber(value: currentNumber))!
        screenOne.text = displayNumber
        
        if numberIsNew == false {
          guard screenTwoNumbers.isEmpty == false else { return }
          screenTwoNumbers.removeLast()
        }
        screenTwoNumbers.insert(displayNumber, at: screenTwoNumbers.count)
        numberIsNew = false
      }
      
      var screenTwoText = ""
      for eachNumber in screenTwoNumbers {
        screenTwoText += "\(eachNumber) "
      }
      screenTwo.text = screenTwoText
    }
      
    else if sender.currentTitle == "AC" {

      displayNumber = ""
      operationType = ""
      previoiusNumber = 0
      currentNumber = 0
      displayNumber = formatter.string(from: NSNumber(value: currentNumber))!
      screenOne.text = displayNumber
      screenTwoNumbers = []
      screenTwo.text = displayNumber
    }
      
    else if sender.currentTitle == "C" {
      
      guard screenOne.text!.count > 0 else { return }
      
      screenOne.text!.removeLast()
      
      if screenOne.text!.count > 0 && screenOne.text != "-" {
        
        let text = screenOne.text!.filter { $0 != "," }
        currentNumber = formatter.number(from: text) as! Double
        displayNumber = formatter.string(from: NSNumber(value: currentNumber))!
        screenOne.text = displayNumber
        
        if screenTwoNumbers.count > 0 {
          if screenTwoNumbers.last == "%" {
            screenTwoNumbers.removeLast()
          }
          screenTwoNumbers.removeLast()
          screenTwoNumbers.insert(displayNumber, at: screenTwoNumbers.count)
        } else {
          screenTwoNumbers.insert(displayNumber, at: screenTwoNumbers.count)
        }
        
        var screenTwoText = ""
        for eachNumber in screenTwoNumbers {
          screenTwoText += "\(eachNumber) "
        }
        screenTwo.text = screenTwoText
        isPerformingMath = true
        numberIsNew = true
      } else {
        
        currentNumber = 0
        displayNumber = formatter.string(from: NSNumber(value: currentNumber))!
        screenOne.text = displayNumber

        //MARK: need to remove last item from screenTwoNumbers only once to prevent multiple taps on "C" from deleting more info in the array.
//
//        var screenTwoText = ""
//        for eachNumber in screenTwoNumbers {
//          screenTwoText += "\(eachNumber) "
//        }
        
        if screenTwoNumbers.last != "+" &&
          screenTwoNumbers.last != "-" &&
          screenTwoNumbers.last != "x" &&
          screenTwoNumbers.last != "/" {
          guard screenTwoNumbers.isEmpty == false else { return }
          screenTwoNumbers.removeLast()
        }
        var screenTwoText = ""
        for eachNumber in screenTwoNumbers {
          screenTwoText += "\(eachNumber) "
        }
        if screenTwoText.isEmpty {
          screenTwoText = "0"
        }
        screenTwo.text = screenTwoText
        numberIsNew = true
      }
      
      defaults.set(false, forKey: "equalsSelectedLast")
      isPerformingMath = true
    }
      
    else if sender.currentTitle == "+/-" {
      
      guard currentNumber != 0 else { return }
      
      currentNumber = currentNumber * -1
      displayNumber = formatter.string(from: NSNumber(value: currentNumber))!
      screenOne.text = displayNumber
      
      if defaults.bool(forKey: "percentSelectedLast") {
        screenTwoNumbers = [displayNumber]
        defaults.set(false, forKey: "percentSelectedLast")
      }
      
      if screenTwoNumbers.count > 0 {
        
        screenTwoNumbers.removeLast()
        screenTwoNumbers.insert(displayNumber, at: screenTwoNumbers.count)
        
        var screenTwoText = ""
        for eachNumber in screenTwoNumbers {
          screenTwoText += "\(eachNumber) "
        }
        screenTwo.text = screenTwoText
      }
      
      if defaults.bool(forKey: "equalsSelectedLast") {
        screenTwoNumbers = [displayNumber]
        screenTwo.text = displayNumber
        isPerformingMath = true
      }
      defaults.set(true, forKey: "plusMinusSelectedLast")
      numberIsNew = true
      isPerformingMath = true
    }
      
    else if sender.currentTitle == "%" {
      
      guard currentNumber != 0 else { return }
      
      defaults.set(true, forKey: "percentSelectedLast")
      
      let lastNumber = formatter.string(from: NSNumber(value: currentNumber))!

      currentNumber = currentNumber * 0.01
      displayNumber = formatter.string(from: NSNumber(value: currentNumber))!
      screenOne.text = displayNumber
      
      screenTwoNumbers = [displayNumber, "%"]

      screenTwo.text = lastNumber + "%" + " ="
      
      isPerformingMath = true
      numberIsNew = true
    }
    
    if defaults.bool(forKey: "equalsSelectedLast") {
      defaults.set(false, forKey: "equalsSelectedLast")
    }
    
    mRselectedLast = false
  }
  
  
  var memoryNumber: Double = 0
  var memoryNumbers: [String] = []
  
  var memoryRecallWasJustCalled = false
  
  //MARK: memoryButtonPressed
  @objc
  func memoryButtonPressed(_ sender: UIButton) {
    
    if sender.currentTitle != "MR" {
      mRselectedLast = false
    }

    if sender.isSelected {
      
      sender.isSelected = !sender.isSelected
      memoryNumber = 0
      memoryNumbers.removeAll()
      screenThree.text = ""
      
      return
    }
    else if sender.currentTitle == "MS" {
  
      sender.isSelected = !sender.isSelected
      
      if screenThree.text == "" {
        memoryNumber = currentNumber
        let number = formatter.string(from: NSNumber(value: currentNumber))!
        memoryNumbers.append("M: \(number)")
        screenThree.text = "M: \(number)"
      } else {
        memoryNumber = currentNumber
        let newNumber = formatter.string(from: NSNumber(value: memoryNumber))!
        memoryNumbers.append("M: \(newNumber)")
        
        screenThree.text = "M: \(newNumber)"
      }

      
      
      isPerformingMath = true
      numberIsNew = true
      screenOne.text = "0"
      screenTwo.text = "0"
      screenTwoNumbers = []
      operationType = ""

    }
    else if sender.currentTitle == "M+" {
      
      guard memoryNumbers.count > 0 else { return }
      
      memoryNumber += currentNumber
      
      let sum = formatter.string(from: NSNumber(value: memoryNumber))!
      
      if memoryNumbers.count == 1 {
        memoryNumbers.append("= \(sum)")
      } else {
        memoryNumbers.removeLast()
        memoryNumbers.append("= \(sum)")
      }
      
      let nextNumber = formatter.string(from: NSNumber(value: currentNumber))!
      memoryNumbers.insert("+ \(nextNumber)", at: memoryNumbers.count - 1)
      
      var screenThreeText = ""
      for eachItem in memoryNumbers {
        screenThreeText += "\(eachItem) "
      }
      screenThree.text = screenThreeText
      
      return
    }
    else if sender.currentTitle == "M-" {
      
      guard memoryNumbers.count > 0 else { return }
      
      memoryNumber -= currentNumber
      
      let sum = formatter.string(from: NSNumber(value: memoryNumber))!
      
      if memoryNumbers.count == 1 {
        memoryNumbers.append("= \(sum)")
      } else {
        memoryNumbers.removeLast()
        memoryNumbers.append("= \(sum)")
      }
      
      let nextNumber = formatter.string(from: NSNumber(value: currentNumber))!
      memoryNumbers.insert("- \(nextNumber)", at: memoryNumbers.count - 1)
      
      var screenThreeText = ""
      for eachItem in memoryNumbers {
        screenThreeText += "\(eachItem) "
      }
      screenThree.text = screenThreeText
      
      return
    }
    else if sender.currentTitle == "MR" {
      
      guard mRselectedLast == false else { return }
      guard memoryNumbers.count > 0 else { return }
      
      screenOne.text = formatter.string(from: NSNumber(value: memoryNumber))!
      isPerformingMath = false
      
      if numberIsNew == false {
        guard screenTwoNumbers.count > 0 else { return }
        
        screenTwoNumbers.removeLast()
        screenTwoNumbers.insert(formatter.string(from: NSNumber(value: memoryNumber))!, at: screenTwoNumbers.count)

        currentNumber = memoryNumber

        var screenTwoText = ""
        for eachNumber in screenTwoNumbers {
          screenTwoText += "\(eachNumber) "
        }
        screenTwo.text = screenTwoText
        numberIsNew = true
        
      } else {
        
        if defaults.bool(forKey: "equalsSelectedLast") {
          screenTwoNumbers = []
          defaults.set(false, forKey: "equalsSelectedLast")
        }
        
        screenTwoNumbers.insert(formatter.string(from: NSNumber(value: memoryNumber))!, at: screenTwoNumbers.count)
        currentNumber = memoryNumber
        
        var screenTwoText = ""
        for eachNumber in screenTwoNumbers {
          screenTwoText += "\(eachNumber) "
        }
        screenTwo.text = screenTwoText
        //isPerformingMath = true
        numberIsNew = true
      }
      
      mRselectedLast = true
      
    }
    
    defaults.set(false, forKey: "plusMinusSelectedLast")

  }
  
  var mRselectedLast = false
  
  var isPerformingMath = false
  var operationType = ""
  
  var numberOnScreen: Double = 0
  var previoiusNumber: Double = 0
  
  var equalsWasSelectedLast = false
  var oldNumbers: [String] = []
  
  
  // MARK: otherButtonPressed
  @objc
  func otherButtonPressed(_ sender: UIButton) {

    guard screenTwoNumbers.count != 0 else { return }
    
    mRselectedLast = false
    
    if sender.currentTitle == "=" && defaults.bool(forKey: "equalsSelectedLast") == true {
      return
    }
    
    if isPerformingMath == false {
     
      if operationType == "+" {
        currentNumber = currentNumber + previoiusNumber
      }
      else if operationType == "-" {
        currentNumber = previoiusNumber - currentNumber
      }
      else if operationType == "x" {
        currentNumber = previoiusNumber * currentNumber
      }
      else if operationType == "/" {
        currentNumber = previoiusNumber / currentNumber
      }
      
      previoiusNumber = currentNumber
      operationType = sender.currentTitle!
      screenOne.text = formatter.string(from: NSNumber(value: currentNumber))!
      screenTwoNumbers.insert(operationType, at: screenTwoNumbers.count)
      
      var screenTwoText = ""
      for eachNumber in screenTwoNumbers {
        screenTwoText += "\(eachNumber) "
      }
      screenTwo.text = screenTwoText
      
      if operationType == "=" {
        
        if defaults.bool(forKey: "retroModeOn") && defaults.bool(forKey: "retroSoundsOff") == false {
          
          calculatorView.startRetroAnimation()
          
          self.oldNumbers = self.screenTwoNumbers
          self.screenTwoNumbers = [self.formatter.string(from: NSNumber(value: self.currentNumber))!]
          self.previoiusNumber = 0
          self.defaults.set(true, forKey: "equalsSelectedLast")
          
        } else {
          oldNumbers = screenTwoNumbers
          screenTwoNumbers = [formatter.string(from: NSNumber(value: currentNumber))!]
          previoiusNumber = 0
          defaults.set(true, forKey: "equalsSelectedLast")
        }
        
      }
      
      isPerformingMath = true
      numberIsNew = true

      return
    }
    
    previoiusNumber = currentNumber
    operationType = sender.currentTitle!

    if screenTwoNumbers.last == "+" ||
       screenTwoNumbers.last == "-" ||
       screenTwoNumbers.last == "x" ||
       screenTwoNumbers.last == "/" ||
       screenTwoNumbers.last == "=" ||
       screenTwoNumbers.last == "%" {
      
      screenTwoNumbers.removeLast()
      screenTwoNumbers.insert(operationType, at: screenTwoNumbers.count)
      
      var screenTwoText = ""
      for eachNumber in screenTwoNumbers {
        screenTwoText += "\(eachNumber) "
      }
      screenTwo.text = screenTwoText
      
      isPerformingMath = true
      numberIsNew = true
      return
    }
    
    if screenTwoNumbers.last != "=" {
      screenTwoNumbers.insert(operationType, at: screenTwoNumbers.count)
    }

    var screenTwoText = ""
    for eachNumber in screenTwoNumbers {
      screenTwoText += "\(eachNumber) "
    }
    screenTwo.text = screenTwoText
    
    defaults.set(false, forKey: "equalsSelectedLast")
    isPerformingMath = true
    numberIsNew = true
    
    defaults.set(false, forKey: "plusMinusSelectedLast")
    
  }
  
  
  @objc
  func presentSettingsView() {
    navigationController?.pushViewController(settingsVC, animated: true)
  }

}

