//
//  MainTitleView.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


class MainTitleView: UIView {
  
  weak var textLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let textLabel = UILabel(frame: .zero)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.text = "Good X Calculator"
    textLabel.tintColor = Theme.navigationBarItemsColor
    self.addSubview(textLabel)
    
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: self.topAnchor),
      textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])
    
    self.textLabel = textLabel
    self.textLabel.textAlignment = .center

  }
  
//  func setColors() {
//    self.textLabel.tintColor = Theme.navigationBarItemsColor
//  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
