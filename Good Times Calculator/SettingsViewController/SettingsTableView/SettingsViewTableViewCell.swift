//
//  File.swift
//  WhoKnows
//
//  Created by Nicholas Church on 5/25/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit



class SettingsViewTableViewCell: UITableViewCell {
  
  weak var label: UILabel!
  var toggle: UISwitch!
  
  var originalFont: UIFont!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.selectionStyle = .none
    
    translatesAutoresizingMaskIntoConstraints = false
    
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = Theme.screenFont
  
    self.contentView.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      label.heightAnchor.constraint(equalToConstant: 65),
      label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
      label.widthAnchor.constraint(equalToConstant: 200)
    ])
    
    self.label = label
    self.originalFont = self.label.font
    
    let toggle = UISwitch(frame: .zero)
    toggle.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(toggle)
    
    NSLayoutConstraint.activate([
      toggle.centerYAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 32),
      toggle.centerXAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -35)
    ])
    
    self.toggle = toggle

  }
  
  
  func setColors() {
    if UserDefaults.standard.bool(forKey: "modeChanged") {
      UIView.animate(withDuration: 0.5) {
        self.backgroundColor = Theme.viewBackgroundColor
        self.label.textColor = Theme.navigationBarItemsColor
        self.label.font = Theme.screenFont
      }
    } else {
      self.backgroundColor = Theme.viewBackgroundColor
      self.label.textColor = Theme.navigationBarItemsColor
      self.label.font = Theme.screenFont
    }
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
