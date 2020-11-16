//
//  ColorThemeCell.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/27/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit



class ColorThemeCell: UICollectionViewCell {
  
  var button: ColorThemeButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.cornerRadius = frame.width / 2
    self.clipsToBounds = true
    
    button = ColorThemeButton(frame: self.frame)
    
    setupView()
  }
  
  func setupView() {
    self.addSubview(button)
    NSLayoutConstraint.activate([
      button.leftAnchor.constraint(equalTo: self.leftAnchor),
      button.topAnchor.constraint(equalTo: self.topAnchor),
      button.rightAnchor.constraint(equalTo: self.rightAnchor),
      button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
  }

  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
