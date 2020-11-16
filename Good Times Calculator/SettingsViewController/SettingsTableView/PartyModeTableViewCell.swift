//
//  PartyModeTableViewCell.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 6/20/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


class PartyModeTableViewCell: SettingsViewTableViewCell {
  
  var soundLabel: UILabel!
  var soundToggle: UISwitch!
  var lightLabel: UILabel!
  var lightToggle: UISwitch!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    soundLabel = UILabel(frame: .zero)
    soundLabel.translatesAutoresizingMaskIntoConstraints = false
    soundLabel.textAlignment = .center
    soundLabel.text = "PARTY SOUND"
    soundLabel.font = UIFont.systemFont(ofSize: 16)
    
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
    
    if UserDefaults.standard.bool(forKey: "allSoundsOff") {
      soundToggle.setOn(false, animated: false)
    } else {
      soundToggle.setOn(true, animated: false)
    }
    soundToggle.isEnabled = UserDefaults.standard.bool(forKey: "allSoundsOff") ? false : true
    
    self.contentView.addSubview(soundToggle)
    NSLayoutConstraint.activate([
      soundToggle.topAnchor.constraint(equalTo: self.toggle.bottomAnchor, constant: 22),
      soundToggle.centerXAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40)
      ])
    
    soundLabel.isHidden = UserDefaults.standard.bool(forKey: "partyModeOn") ? false : true
    soundToggle.isHidden = UserDefaults.standard.bool(forKey: "partyModeOn") ? false : true
    
    
    lightLabel = UILabel(frame: .zero)
    lightLabel.translatesAutoresizingMaskIntoConstraints = false
    lightLabel.textAlignment = .center
    lightLabel.text = "PARTY LIGHT"
    lightLabel.font = UIFont.systemFont(ofSize: 16)
    
    self.contentView.addSubview(lightLabel)
    NSLayoutConstraint.activate([
      lightLabel.topAnchor.constraint(equalTo: self.soundLabel.bottomAnchor),
      lightLabel.heightAnchor.constraint(equalToConstant: 45),
      lightLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
      lightLabel.widthAnchor.constraint(equalToConstant: 200)
      ])
    
    lightToggle = UISwitch(frame: .zero)
    lightToggle.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    lightToggle.translatesAutoresizingMaskIntoConstraints = false
    lightToggle.setOn(true, animated: true)
    //lightToggle.isEnabled = UserDefaults.standard.bool(forKey: "allSoundsOff") ? false : true
    
    self.contentView.addSubview(lightToggle)
    NSLayoutConstraint.activate([
      lightToggle.topAnchor.constraint(equalTo: self.soundToggle.bottomAnchor, constant: 22),
      lightToggle.centerXAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40)
      ])
    
    lightLabel.isHidden = UserDefaults.standard.bool(forKey: "partyModeOn") ? false : true
    lightToggle.isHidden = UserDefaults.standard.bool(forKey: "partyModeOn") ? false : true
    
  }
  
  
  override func setColors() {
    if UserDefaults.standard.bool(forKey: "modeChanged") {
      UIView.animate(withDuration: 0.5) {
        self.backgroundColor = Theme.viewBackgroundColor
        self.label.textColor = Theme.navigationBarItemsColor
        self.label.font = Theme.screenFont
        self.soundLabel.textColor = Theme.navigationBarItemsColor
        self.soundLabel.font = UIFont.systemFont(ofSize: 16)
        self.lightLabel.textColor = Theme.navigationBarItemsColor
        self.lightLabel.font = UIFont.systemFont(ofSize: 16)
      }
    } else {
      self.backgroundColor = Theme.viewBackgroundColor
      self.label.textColor = Theme.navigationBarItemsColor
      self.label.font = Theme.screenFont
      self.soundLabel.textColor = Theme.navigationBarItemsColor
      self.soundLabel.font = UIFont.systemFont(ofSize: 16)
      self.lightLabel.textColor = Theme.navigationBarItemsColor
      self.lightLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
  }
  
  func randomColors() {
    UIView.animate(withDuration: 0.4, delay: 0, options: [.repeat, .autoreverse], animations: {
      self.backgroundColor = UIColor.random
    }, completion: nil)
  }
  
  func expandCellContents() {
    soundLabel.isHidden = false
    soundToggle.isHidden = false
    lightLabel.isHidden = false
    lightToggle.isHidden = false
  }
  
  
  func collapseCellContents() {
    soundLabel.isHidden = true
    soundToggle.isHidden = true
    lightLabel.isHidden = true
    lightToggle.isHidden = true
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
