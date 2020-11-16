//
//  CalculatorView.swift
//  WhoKnows
//
//  Created by Nicholas Church on 5/4/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


class CalculatorView: UIView {
  
  var screenOne: ScreenLabel = {
    let item  = ScreenLabel(frame: .zero)
    item.textAlignment = .center
    return item
  }()  
  
  var screenTwo: ScreenLabel = {
    let item           = ScreenLabel(frame: .zero)
    item.font          = UIFont.systemFont(ofSize: 16)
    item.textAlignment = .left
    return item
  }()
  
  var screenThree: ScreenLabel = {
    let item           = ScreenLabel(frame: .zero)
    item.font          = UIFont.systemFont(ofSize: 16)
    item.textAlignment = .left
    item.text          = ""
    return item
  }()
  
  var viewHeight: CGFloat!
  var viewWidth: CGFloat!

  var firstRowButtonTitles = ["MS", "M+", "M-", "MR"]
  var seconRowButtonTitles = ["C", "+/-", "AC", "%"]
  var otherButtonTitles    = ["=", ".", "+", "-", "x", "/"]
  
  var firstRowButtons:  [Button] = []
  var secondRowButtons: [Button] = []
  var otherButtons:     [Button] = []
  var numberButtons:    [Button] = []
  
  let defaults  = UserDefaults.standard
  
  let formatter = NumberFormatter()
  
  var edgeOffset: CGFloat!
  
  var screenTwoHeightConstraint     : NSLayoutConstraint!
  var screenOneHeightConstraint     : NSLayoutConstraint!
  var screenThreeHeightConstraint   : NSLayoutConstraint!
  var firstRowHeightConstraint      : NSLayoutConstraint!
  var secondRowHeightConstraint     : NSLayoutConstraint!
  var number7ButtonHeightConstraint : NSLayoutConstraint!
  
  var centerDotYConstraint  = NSLayoutConstraint()
  var leftDotYConstraint    = NSLayoutConstraint()
  var rightDotYConstraint   = NSLayoutConstraint()

  var buttonHeight: CGFloat = 0 
  var buttonWidth:  CGFloat = 0
  
  var firstRowButtonHeight:   CGFloat!
  
  var verticalSeperation:     CGFloat!
  var horizontalSeperation:   CGFloat!
  var buttonHSeperation:      CGFloat!
  var buttonVSeperation:      CGFloat!
  
  var rowStartPositionOffset: CGFloat!
  
  var originalScreenOneFont = UIFont.systemFont(ofSize: 72)
  var originalScreenTwoFont: UIFont!
  
  var retroDotViews: [UIView] = []

  init(frame: CGRect, width: CGFloat, height: CGFloat) {
    
    self.viewHeight = height
    self.viewWidth = width
    super.init(frame: frame)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    
    formatter.numberStyle           = .decimal
    formatter.maximumFractionDigits = 6
    
    setVariables()
    setupView()
    
    originalScreenTwoFont = screenTwo.font
    
  }
  
  
  func setVariables() {
    let displaySize            = viewHeight * 0.9
    let displayPortionOfScreen = displaySize / 3.5
    let buttonPortionOfScreen  = displaySize - displayPortionOfScreen
    
    screenOne.font   = defaults.bool(forKey: "retroModeOn") ?
                       UIFont(name: "DS-Digital-BoldItalic", size: 92) : originalScreenOneFont
    screenTwo.font   = defaults.bool(forKey: "retroModeOn") ?
                       UIFont(name: "DS-Digital-BoldItalic", size: 20) : originalScreenTwoFont
    screenThree.font = defaults.bool(forKey: "retroModeOn") ?
                       UIFont(name: "DS-Digital-BoldItalic", size: 20) : originalScreenTwoFont
    
    screenOneHeightConstraint = screenOne.heightAnchor.constraint(equalToConstant: displayPortionOfScreen * 0.75)
    screenTwoHeightConstraint = screenTwo.heightAnchor.constraint(equalToConstant: displayPortionOfScreen * 0.125)
    screenThreeHeightConstraint = screenThree.heightAnchor.constraint(equalToConstant: displayPortionOfScreen * 0.125)
    
    buttonHeight = buttonPortionOfScreen / 7
    buttonWidth  = viewWidth / 4.5
    
    firstRowButtonHeight   = buttonHeight / 2
    
    verticalSeperation     = (buttonPortionOfScreen - (buttonHeight * 6)) / 7
    horizontalSeperation   = (viewWidth - (buttonWidth * 4)) / 5
    
    buttonHSeperation      = buttonWidth + horizontalSeperation
    buttonVSeperation      = buttonHeight + verticalSeperation
    
    rowStartPositionOffset = horizontalSeperation + (buttonWidth / 2)
  }

  
  func setupView() {
    
    let view  = UIView()
    let view2 = UIView()
    let view3 = UIView()

    retroDotViews.appendMultiple(view, view2, view3)
    
    screenOne.font = UserDefaults.standard.bool(forKey: "retroModeOn") ?
    UIFont(name: "DS-Digital-BoldItalic", size: 72) :
    UIFont.systemFont(ofSize: 72)
    screenTwo.font = UserDefaults.standard.bool(forKey: "retroModeOn") ?
    UIFont(name: "DS-Digital-BoldItalic", size: 16) :
    UIFont.systemFont(ofSize: 16)
    screenThree.font = UserDefaults.standard.bool(forKey: "retroModeOn") ?
    UIFont(name: "DS-Digital-BoldItalic", size: 16) :
    UIFont.systemFont(ofSize: 16)
    
    var k = 0
    for each in 20...23 {
      let item = Button(frame: .zero)
      item.heightAnchor.constraint(equalToConstant: firstRowButtonHeight).isActive = true
      item.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
      item.layer.cornerRadius = defaults.bool(forKey: "retroModeOn") ? firstRowButtonHeight / 10 : firstRowButtonHeight / 2
      item.tag = each
      item.setTitle(firstRowButtonTitles[k], for: .normal)
      if item.title(for: .normal) == "MS" {
        item.setTitle("MC", for: .selected)
      }
      item.titleLabel?.font   = defaults.bool(forKey: "retroModeOn") ? UIFont(name: "DS-Digital-BoldItalic", size: 24) : item.titleLabel?.font.withSize(20)
      item.layer.borderWidth  = defaults.bool(forKey: "retroModeOn") ? 2 : 1
      item.isNumberButton     = false
      firstRowButtons.append(item)
      k += 1
    }
    
    var j = 0
    for each in 16...19 {
      let item = Button(frame: .zero)
      item.heightAnchor.constraint(equalToConstant: firstRowButtonHeight).isActive = true
      item.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
      item.layer.cornerRadius = defaults.bool(forKey: "retroModeOn") ? firstRowButtonHeight / 10 : firstRowButtonHeight / 2
      item.tag = each
      item.setTitle(seconRowButtonTitles[j], for: .normal)
      item.titleLabel?.font  = defaults.bool(forKey: "retroModeOn") ? UIFont(name: "DS-Digital-BoldItalic", size: 24) : item.titleLabel?.font.withSize(20)
      item.layer.borderWidth = defaults.bool(forKey: "retroModeOn") ? 2 : 1
      item.isNumberButton    = false
      secondRowButtons.append(item)
      j += 1
    }
    
    var i = 0
    for each in 10...15 {
      let item = Button(frame: .zero)
      if each > 10 {
        item.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        item.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        item.layer.cornerRadius = defaults.bool(forKey: "retroModeOn") ? buttonHeight / 10 : buttonHeight / 2
        item.titleLabel?.font   = defaults.bool(forKey: "retroModeOn") ? UIFont(name: "DS-Digital-BoldItalic", size: 34) : item.titleLabel?.font.withSize(24)
      } else {
        item.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        item.layer.cornerRadius = defaults.bool(forKey: "retroModeOn") ? (buttonHeight *  0.8) / 10 : (buttonHeight * 0.8) / 2
        item.titleLabel?.font   = defaults.bool(forKey: "retroModeOn") ? UIFont(name: "DS-Digital-BoldItalic", size: 54) : item.titleLabel?.font.withSize(44)
      }
      item.layer.borderWidth = defaults.bool(forKey: "retroModeOn") ? 2 : 1
      item.tag               = each
      item.setTitle(otherButtonTitles[i], for: .normal)
      item.isNumberButton    = false
      otherButtons.append(item)
      i += 1
    }
    
    for each in 0...9 {
      let item = Button(frame: .zero)
      item.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
      if each > 0 {
        item.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
      }
      item.titleLabel?.font = defaults.bool(forKey: "retroModeOn") ?
                              UIFont(name: "DS-Digital-BoldItalic", size: 34) : item.titleLabel?.font.withSize(24)
      item.layer.cornerRadius = defaults.bool(forKey: "retroModeOn") ? buttonHeight / 10 : buttonHeight / 2
      item.layer.borderWidth = defaults.bool(forKey: "retroModeOn") ? 2 : 1
      item.setTitle("\(each)", for: .normal)
      item.tag = each
      item.isNumberButton = true
      numberButtons.append(item)
    }
    
    numberButtons.appendItemsFromArray(".", from: otherButtons)
    numberButtons.itemWithTitle(title: ".")?.isNumberButton = true
    otherButtons.removeItemsWithTitles(".")
    
    self.addSubViews(screenTwo, screenOne, screenThree)

    for each in firstRowButtons {
      addSubview(each)
    }
    for each in secondRowButtons {
      addSubview(each)
    }
    for each in otherButtons {
      addSubview(each)
    }
    for each in numberButtons {
      addSubview(each)
    }
    
    NSLayoutConstraint.activate([
      screenTwo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalSeperation),
      screenTwo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
      screenTwo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalSeperation),
      screenTwoHeightConstraint,
      
      screenOne.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalSeperation),
      screenOne.topAnchor.constraint(equalTo: screenTwo.bottomAnchor),
      screenOne.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalSeperation),
      //screenOneHeightConstraint,
      
      screenThree.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalSeperation),
      screenThree.topAnchor.constraint(equalTo: screenOne.bottomAnchor),
      screenThree.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalSeperation),
      screenThreeHeightConstraint,

      firstRowButtons.itemWithTitle(title: "MS")!.topAnchor.constraint(equalTo:
        screenThree.bottomAnchor),
      firstRowButtons.itemWithTitle(title: "MS")!.centerXAnchor.constraint(equalTo:
        self.leadingAnchor, constant: rowStartPositionOffset),

      firstRowButtons.itemWithTitle(title:   "M+")!.centerYAnchor.constraint(equalTo: firstRowButtons.itemWithTitle(title: "MS")!.centerYAnchor),
      firstRowButtons.itemWithTitle(title:   "M+")!.centerXAnchor.constraint(equalTo: firstRowButtons.itemWithTitle(title: "MS")!.centerXAnchor, constant: buttonHSeperation),

      firstRowButtons.itemWithTitle(title:   "M-")!.centerYAnchor.constraint(equalTo: firstRowButtons.itemWithTitle(title: "MS")!.centerYAnchor),
      firstRowButtons.itemWithTitle(title:   "M-")!.centerXAnchor.constraint(equalTo: firstRowButtons.itemWithTitle(title: "M+")!.centerXAnchor, constant: buttonHSeperation),

      firstRowButtons.itemWithTitle(title:   "MR")!.centerYAnchor.constraint(equalTo: firstRowButtons.itemWithTitle(title: "MS")!.centerYAnchor),
      firstRowButtons.itemWithTitle(title:   "MR")!.centerXAnchor.constraint(equalTo: firstRowButtons.itemWithTitle(title: "M-")!.centerXAnchor, constant: buttonHSeperation),

      secondRowButtons.itemWithTitle(title:  "AC")!.centerYAnchor.constraint(equalTo: firstRowButtons.itemWithTitle(title: "MS")!.centerYAnchor, constant: buttonVSeperation / 2),
      secondRowButtons.itemWithTitle(title:  "AC")!.centerXAnchor.constraint(equalTo: firstRowButtons.itemWithTitle(title: "MS")!.centerXAnchor),

      secondRowButtons.itemWithTitle(title:   "C")!.centerYAnchor.constraint(equalTo: secondRowButtons.itemWithTitle(title: "AC")!.centerYAnchor),
      secondRowButtons.itemWithTitle(title:   "C")!.centerXAnchor.constraint(equalTo:  secondRowButtons.itemWithTitle(title: "AC")!.centerXAnchor, constant: buttonHSeperation),

      secondRowButtons.itemWithTitle(title:   "%")!.centerYAnchor.constraint(equalTo: secondRowButtons.itemWithTitle(title: "C")!.centerYAnchor),
      secondRowButtons.itemWithTitle(title:      "%")!.centerXAnchor.constraint(equalTo:  secondRowButtons.itemWithTitle(title: "C")!.centerXAnchor, constant: buttonHSeperation),

      secondRowButtons.itemWithTitle(title:   "+/-")!.centerYAnchor.constraint(equalTo: secondRowButtons.itemWithTitle(title: "%")!.centerYAnchor),
      secondRowButtons.itemWithTitle(title:   "+/-")!.centerXAnchor.constraint(equalTo:  secondRowButtons.itemWithTitle(title: "%")!.centerXAnchor, constant: buttonHSeperation),

      numberButtons.itemWithTitle(title: "7")!.centerYAnchor.constraint(equalTo: secondRowButtons.itemWithTitle(title: "AC")!.topAnchor, constant: buttonVSeperation),
      numberButtons.itemWithTitle(title: "7")!.centerXAnchor.constraint(equalTo: secondRowButtons.itemWithTitle(title: "AC")!.centerXAnchor),

      numberButtons.itemWithTitle(title: "8")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "7")!.centerYAnchor),
      numberButtons.itemWithTitle(title: "8")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "7")!.centerXAnchor, constant: buttonHSeperation),

      numberButtons.itemWithTitle(title: "9")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "7")!.centerYAnchor),
      numberButtons.itemWithTitle(title: "9")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "8")!.centerXAnchor, constant: buttonHSeperation),

      otherButtons.itemWithTitle(title: "/")!.centerYAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "7")!.centerYAnchor),
      otherButtons.itemWithTitle(title: "/")!.centerXAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "9")!.centerXAnchor, constant: buttonHSeperation),

      numberButtons.itemWithTitle(title: "4")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "7")!.centerYAnchor, constant: buttonVSeperation),
      numberButtons.itemWithTitle(title: "4")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "7")!.centerXAnchor),

      numberButtons.itemWithTitle(title: "5")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "4")!.centerYAnchor),
      numberButtons.itemWithTitle(title: "5")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "4")!.centerXAnchor, constant: buttonHSeperation),

      numberButtons.itemWithTitle(title: "6")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "4")!.centerYAnchor),
      numberButtons.itemWithTitle(title: "6")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "5")!.centerXAnchor, constant: buttonHSeperation),

      otherButtons.itemWithTitle(title: "x")!.centerYAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "4")!.centerYAnchor),
      otherButtons.itemWithTitle(title: "x")!.centerXAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "6")!.centerXAnchor, constant: buttonHSeperation),

      numberButtons.itemWithTitle(title: "1")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "4")!.centerYAnchor, constant: buttonVSeperation),
      numberButtons.itemWithTitle(title: "1")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "4")!.centerXAnchor),

      numberButtons.itemWithTitle(title: "2")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "1")!.centerYAnchor),
      numberButtons.itemWithTitle(title: "2")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "1")!.centerXAnchor, constant: buttonHSeperation),

      numberButtons.itemWithTitle(title: "3")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "1")!.centerYAnchor),
      numberButtons.itemWithTitle(title: "3")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "2")!.centerXAnchor, constant: buttonHSeperation),

      otherButtons.itemWithTitle(title: "-")!.centerYAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "1")!.centerYAnchor),
      otherButtons.itemWithTitle(title: "-")!.centerXAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "3")!.centerXAnchor, constant: buttonHSeperation),

      numberButtons.itemWithTitle(title: "0")!.centerYAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "1")!.centerYAnchor, constant: buttonVSeperation),
      numberButtons.itemWithTitle(title: "0")!.leadingAnchor.constraint(equalTo:
        self.leadingAnchor, constant: horizontalSeperation),
      numberButtons.itemWithTitle(title: "0")!.trailingAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "2")!.trailingAnchor),

      numberButtons.itemWithTitle(title: ".")!.centerYAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "0")!.centerYAnchor),
      numberButtons.itemWithTitle(title: ".")!.centerXAnchor.constraint(equalTo: numberButtons.itemWithTitle(title: "3")!.centerXAnchor),

      otherButtons.itemWithTitle(title: "+")!.centerYAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "0")!.centerYAnchor),
      otherButtons.itemWithTitle(title: "+")!.centerXAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: ".")!.centerXAnchor, constant: buttonHSeperation),

      otherButtons.itemWithTitle(title: "=")!.leadingAnchor.constraint(equalTo:
        self.leadingAnchor, constant: horizontalSeperation),
      otherButtons.itemWithTitle(title: "=")!.centerYAnchor.constraint(equalTo:
        numberButtons.itemWithTitle(title: "0")!.centerYAnchor, constant: buttonVSeperation),
      otherButtons.itemWithTitle(title: "=")!.trailingAnchor.constraint(equalTo:
        otherButtons.itemWithTitle(title: "+")!.trailingAnchor),
      otherButtons.itemWithTitle(title: "=")!.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    
    for eachView in retroDotViews {
      eachView.translatesAutoresizingMaskIntoConstraints = false
      screenOne.addSubview(eachView)
      eachView.isHidden = true
    }
    
    centerDotYConstraint  = view.centerYAnchor.constraint(equalTo: screenOne.centerYAnchor)
    leftDotYConstraint    = view2.centerYAnchor.constraint(equalTo: screenOne.centerYAnchor)
    rightDotYConstraint   = view3.centerYAnchor.constraint(equalTo: screenOne.centerYAnchor)
    
    NSLayoutConstraint.activate([
      view.widthAnchor.constraint(equalToConstant: 5),
      view.heightAnchor.constraint(equalToConstant: 5),
      centerDotYConstraint,
      view.centerXAnchor.constraint(equalTo: screenOne.centerXAnchor),
      
      view2.widthAnchor.constraint(equalToConstant: 5),
      view2.heightAnchor.constraint(equalToConstant: 5),
      view2.centerXAnchor.constraint(equalTo: screenOne.centerXAnchor, constant: -15),
      leftDotYConstraint,
      
      view3.widthAnchor.constraint(equalToConstant: 5),
      view3.heightAnchor.constraint(equalToConstant: 5),
      view3.centerXAnchor.constraint(equalTo: screenOne.centerXAnchor, constant: 15),
      rightDotYConstraint
    ])
    
  }
  
  
  func setColors() {
    
    backgroundColor = Theme.viewBackgroundColor
    
    screenOne.setColors()
    screenTwo.setColors()
    screenThree.setColors()
    
    for eachButton in firstRowButtons {
      eachButton.setColors()
    }
    
    for eachButton in secondRowButtons {
         eachButton.setColors()
    }
    
    for eachButton in otherButtons {
      eachButton.setColors()
    }
    
    for eachButton in numberButtons {
      eachButton.setColors()
    }
    
  }
  
  
  func startRetroAnimation() {
    
    let screenText = screenOne.text
    screenOne.text = ""

    for eachView in retroDotViews {
      eachView.isHidden = false
      eachView.backgroundColor = Theme.screenTextColor
    }
    
    centerDotYConstraint.constant = 15
    leftDotYConstraint.constant = -8
    rightDotYConstraint.constant = 8
    
    UIView.animate(withDuration: 0.4, delay: 0, options: [.repeat, .autoreverse], animations: {
      self.screenOne.layoutIfNeeded()
    }, completion: nil)
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
      for eachView in self.retroDotViews {
        eachView.isHidden = true
      }
      self.screenOne.text = screenText
      self.centerDotYConstraint.constant = 0
      self.leftDotYConstraint.constant = 0
      self.rightDotYConstraint.constant = 0
    }
    
  }
  

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

