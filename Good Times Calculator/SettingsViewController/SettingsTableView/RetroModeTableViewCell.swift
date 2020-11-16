//
//  RetroModeTableViewCell.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 6/11/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit



class RetroModeTableViewCell: UITableViewCell {
  
  weak var label: UILabel!
  var toggle: UISwitch!
  
  var soundLabel: UILabel!
  var soundToggle: UISwitch!
  
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
    toggle.setOn(UserDefaults.standard.bool(forKey: "retroModeOn"), animated: false)
    self.contentView.addSubview(toggle)
    NSLayoutConstraint.activate([
      toggle.centerYAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 32),
      toggle.centerXAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -35)
      ])
    self.toggle = toggle
    
    soundLabel = UILabel(frame: .zero)
    soundLabel.translatesAutoresizingMaskIntoConstraints = false
    soundLabel.textAlignment = .center
    soundLabel.text = "RETRO SOUND"
    soundLabel.font = Theme.screenFont
    
    self.contentView.addSubview(soundLabel)
    
    NSLayoutConstraint.activate([
      soundLabel.topAnchor.constraint(equalTo: self.label.bottomAnchor),
      soundLabel.heightAnchor.constraint(equalToConstant: 45),
      soundLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
      soundLabel.widthAnchor.constraint(equalToConstant: 200)
    ])
    
    soundToggle = UISwitch(frame: .zero)
    soundToggle.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    soundToggle.translatesAutoresizingMaskIntoConstraints = false
    
    if UserDefaults.standard.bool(forKey: "retroModeOn") {
      soundToggle.setOn(!UserDefaults.standard.bool(forKey: "retroSoundsOff"), animated: false)
      
    } else if UserDefaults.standard.bool(forKey: "allSoundsOff") {
      
      soundToggle.setOn(false, animated: false)
    }
    
    soundToggle.setOn(!UserDefaults.standard.bool(forKey: "retroSoundsOff"), animated: false)
    soundToggle.isEnabled = UserDefaults.standard.bool(forKey: "allSoundsOff") ? false : true
    
    self.contentView.addSubview(soundToggle)
    NSLayoutConstraint.activate([
      soundToggle.topAnchor.constraint(equalTo: self.toggle.bottomAnchor, constant: 22),
      soundToggle.centerXAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40)
      ])
    
    soundLabel.isHidden = UserDefaults.standard.bool(forKey: "retroModeOn") ? false : true
    soundToggle.isHidden = UserDefaults.standard.bool(forKey: "retroModeOn") ? false : true

  }
  
  
  func setColors() {
    if UserDefaults.standard.bool(forKey: "modeChanged") {
      UIView.animate(withDuration: 0.5) {
        self.backgroundColor = Theme.viewBackgroundColor
        self.label.textColor = Theme.navigationBarItemsColor
        self.label.font = Theme.screenFont
        self.soundLabel.textColor = Theme.navigationBarItemsColor
        self.soundLabel.font = Theme.screenFont
      }
    } else {
      self.backgroundColor = Theme.viewBackgroundColor
      self.label.textColor = Theme.navigationBarItemsColor
      self.label.font = Theme.screenFont
      self.soundLabel.textColor = Theme.navigationBarItemsColor
      self.soundLabel.font = Theme.screenFont
    }
    
  }
  
  
  func expandCellContents() {
    soundLabel.isHidden = false
    soundToggle.isHidden = false
  }
  
  
  func collapseCellContents() {
    soundLabel.isHidden = true
    soundToggle.isHidden = true
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

