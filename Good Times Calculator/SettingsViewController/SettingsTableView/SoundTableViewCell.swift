//
//  SoundTableViewCell.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 6/8/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


class SoundTableViewCell: UITableViewCell {
  
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
    self.contentView.addSubview(label)
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
      label.widthAnchor.constraint(equalToConstant: 200)
      ])
    self.label = label
    self.originalFont = self.label.font
    
    let toggle = UISwitch(frame: .zero)
    toggle.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(toggle)
    NSLayoutConstraint.activate([
      toggle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      toggle.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -25),
      ])
    self.toggle = toggle
  }
  
  
  func setColors() {
    if UserDefaults.standard.bool(forKey: "modeChanged") {
      UIView.animate(withDuration: 0.5) {
        self.backgroundColor = Theme.viewBackgroundColor

      }
    } else {
      self.backgroundColor = Theme.viewBackgroundColor

    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
