//
//  ColorThemeButton.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/27/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit



class ColorThemeButton: UIButton {
  
  let generator = UIImpactFeedbackGenerator(style: .light)
  let animationTime = 0.15
  
  let defualts = UserDefaults.standard


  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  
  func setup() {
    
    translatesAutoresizingMaskIntoConstraints = false
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.borderWidth = 1
    self.addTarget(self, action: #selector(pressDownAnimation), for: [.touchDown, .touchDragEnter])
    self.addTarget(self, action: #selector(unpressAnimation), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    generator.prepare()
  }
  
  
  func randomColors() {
    UIView.animate(withDuration: 0.4, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
      self.layer.borderColor = UIColor.random.cgColor
    }, completion: nil)
//    layer.borderColor = UIColor.random.cgColor
//    backgroundColor = UIColor.random
//    setTitleColor(Theme.otherButtonTitleColor, for: .normal)
  }
  
  
  @objc
  func pressDownAnimation() {
    
    generator.impactOccurred()
    
    UIView.animate(withDuration: animationTime) {
      
    }
    
    generator.prepare()
  }
  
  
  @objc
  func unpressAnimation() {
    
    UIView.animate(withDuration: animationTime) {
      
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
