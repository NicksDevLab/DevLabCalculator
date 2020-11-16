//
//  ScreenLabel.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


class ScreenLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    layer.masksToBounds = true
    textAlignment = NSTextAlignment.center
    adjustsFontSizeToFitWidth = true
    text = "0"
    
    setColors()
  }
  
  func setColors() {
    layer.backgroundColor = Theme.screenBackgroundColor
    textColor = Theme.screenTextColor
    layer.borderColor = Theme.screenBorderColor
  }
  
  func randomColors() {
    backgroundColor = UIColor.random
    textColor = UIColor.random
    layer.borderColor = UIColor.random.cgColor
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
