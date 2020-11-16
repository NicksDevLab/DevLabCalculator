//
//  SettingsViewController.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit
import AVFoundation


class SettingsViewController: UIViewController {
  
  var settingsView = SettingsView()
  var settingsTitleView = SettingsTitleView()
  var tableView = UITableView()
  var selectedCells: [IndexPath : Bool] = [:]
  var collapsedCellHeight: CGFloat = 65
  var expandedCellHeight: CGFloat = 110
  
  let defaults = UserDefaults.standard
  
  var partySound: AVAudioPlayer?
  
  let device = AVCaptureDevice.default(for: .video)
  var lightOn = false
  
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    settingsTitleView = SettingsTitleView()
    self.navigationItem.titleView = settingsTitleView
    
    settingsView = SettingsView(frame: self.view.frame)
    
    tableView = settingsView.tableView
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: "SectionHeader")
    tableView.register(CollectionViewTableCell.self, forCellReuseIdentifier: "CollectionViewTableCell")
    tableView.register(SettingsViewTableViewCell.self, forCellReuseIdentifier: "SettingsViewTableViewCell")
    tableView.register(RetroModeTableViewCell.self, forCellReuseIdentifier: "RetroModeTableViewCell")
    tableView.register(PartyModeTableViewCell.self, forCellReuseIdentifier: "PartyModeTableViewCell")
    
    if defaults.bool(forKey: "retroModeOn") {
      selectedCells[IndexPath(item: 1, section: 1)] = true
    }
    
    let path = Bundle.main.path(forResource: "Boom_Chuk_130.mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)
    partySound = try! AVAudioPlayer(contentsOf: url)
    partySound?.numberOfLoops = -1
    
    checkUserInterface()
    
    setupView()

  }

  
  func setupView() {
    self.view.addSubview(settingsView)
    
    NSLayoutConstraint.activate([
      settingsView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      settingsView.topAnchor.constraint(equalTo: self.view.topAnchor),
      settingsView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      settingsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ])
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    if defaults.bool(forKey: "partyModeOn") {
      animateCollectionViewCellBorderWidth()
    }
  }
  
  
  func checkUserInterface() {
    
    switch self.traitCollection.userInterfaceStyle {
    case .light, .unspecified:
      let switched = UISwitch()
      switched.isOn = false
      darkModeToggled(switched)
    case .dark:
      let switched = UISwitch()
      switched.isOn = true
      darkModeToggled(switched)
    default:
      print("new case")
    }
  }
  
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    checkUserInterface()
  }
  
  
  @objc
  func darkModeToggled(_ sender: UISwitch) {
    
    defaults.set(true, forKey: "modeChanged")
 
    if sender.isOn {
      defaults.set(true, forKey: "darkModeOn")
    } else {
      defaults.set(false, forKey: "darkModeOn")
    }
    
    if defaults.bool(forKey: "greenThemeOn") {
      Theme.greenMode()
    }
    
    Theme.darkMode()
    UIView.animate(withDuration: 0.5) {
      self.navigationController?.navigationBar.barTintColor = Theme.viewBackgroundColor
      self.navigationController?.navigationBar.tintColor = Theme.navigationBarItemsColor
      self.navigationController?.navigationBar.layoutIfNeeded() //Needs to be called to animate changes to navigationBar.
      self.navigationController?.setNeedsStatusBarAppearanceUpdate()
      
      self.tableView.backgroundColor = Theme.viewBackgroundColor
      self.settingsTitleView.textLabel.textColor = Theme.navigationBarItemsColor
      self.tableView.reloadData()
    }
    
  }
  
  
  @objc
  func retroModeToggled(_ sender: UISwitch) {

    if sender.isOn {
      updateCellFont(retroOn: true)
      selectedCells[IndexPath(item: 1, section: 1)] = true
      if defaults.bool(forKey: "partyModeOn") {
        removeCollectionViewCellAnimations()
        animateCollectionViewCellBorderWidth()
      }
    } else {
      updateCellFont(retroOn: false)
      defaults.set(true, forKey: "retroSoundsOff")
      selectedCells[IndexPath(item: 1, section: 1)] = false
      if defaults.bool(forKey: "partyModeOn") {
        removeCollectionViewCellAnimations()
        animateCollectionViewCellBorderWidth()
      }
    }
    tableView.reloadData()
  }
  
  
  func updateCellFont(retroOn: Bool) {
    
    defaults.set(true, forKey: "modeChanged")
    defaults.set(retroOn, forKey: "retroModeOn")
    
    let darkModeCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! SettingsViewTableViewCell
    let partyModeCell = tableView.cellForRow(at: IndexPath.init(row: 2, section: 1)) as! PartyModeTableViewCell
    let retroModeCell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 1)) as! RetroModeTableViewCell
    let themeCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CollectionViewTableCell
    
    Theme.retroMode()
    
    settingsTitleView.textLabel.font = UIFont.systemFont(ofSize: 18)
    
    retroModeCell.label.font = Theme.screenFont
    darkModeCell.label.font = Theme.screenFont
    partyModeCell.label.font = Theme.screenFont
    
    if retroOn {
      retroModeCell.expandCellContents() // Shows sound toggle and text
      themeCell.retroModeOn() // Animate cell shape change
      retroModeCell.soundToggle.setOn(true, animated: false)
      retroSounds(retroModeCell.soundToggle)
    } else {
      retroModeCell.collapseCellContents() // Hides sound toggle and text
      themeCell.retroModeOff() // Animate cell shape change
    }
    
  }
  
  
  @objc
  func partyModeToggled(_ sender: UISwitch) {
    
    defaults.set(true, forKey: "modeChanged")
    
    let partyModeCell = tableView.cellForRow(at: IndexPath.init(row: 2, section: 1)) as! PartyModeTableViewCell
  
    if sender.isOn {
      
      defaults.set(true, forKey: "partyModeOn")
      defaults.set(true, forKey: "partyLightOn")
      partyModeCell.soundToggle.setOn(true, animated: false)
      partyModeCell.lightToggle.setOn(true, animated: false)
      if defaults.bool(forKey: "allSoundsOff") == false {
        partySound?.prepareToPlay()
        partySound?.play()
      }
      partyModeCell.expandCellContents()
      selectedCells[IndexPath(item: 2, section: 1)] = true
      toggleTorchOn()
      
      animateCollectionViewCellBorderWidth()
      
    } else {
      
      defaults.set(false, forKey: "partyModeOn")
      defaults.set(false, forKey: "partyLightOn")
      
      removeCollectionViewCellAnimations()
      
      partySound?.stop()
      partyModeCell.collapseCellContents()
      selectedCells[IndexPath(item: 2, section: 1)] = false
      
      if device!.hasTorch {
        do {
          try device!.lockForConfiguration()
          
          if lightOn {
            device!.torchMode = .off
            lightOn = !lightOn
          }
          device!.unlockForConfiguration()
        } catch {
          print("Torch could not be used")
        }
      }
    }
    tableView.reloadData()
  }
  
  
  func animateCollectionViewCellBorderWidth() {
    
    let collectionViewCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CollectionViewTableCell
    
    for each in collectionViewCell.collectionView.visibleCells {
      
      let eachCell = each as! ColorThemeCell
      
      let storkeLayer = CAShapeLayer()
      storkeLayer.fillColor = nil
      storkeLayer.strokeColor = UIColor.random.cgColor
      storkeLayer.lineWidth = 7
      // Create a rounded rect path using button's bounds.
      storkeLayer.path = CGPath.init(roundedRect: eachCell.bounds, cornerWidth: eachCell.layer.cornerRadius, cornerHeight: eachCell.layer.cornerRadius, transform: nil) // same path like the empty one ...
      storkeLayer.name = "stroke"
      // Add layer to the button
      eachCell.layer.addSublayer(storkeLayer)
      
      // Create animation layer and add it to the stroke layer.
      let animation = CABasicAnimation(keyPath: "lineWidth")
      animation.fromValue = CGFloat(0.0)
      animation.toValue = CGFloat(10.0)
      animation.duration = 0.4
      //animation.fillMode = CAMediaTimingFillMode.forwards
      animation.timeOffset = CFTimeInterval(Float.random(in: 0.0...0.5))
      animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      animation.autoreverses = true
      
      let bothAnimations = CAAnimationGroup()
      bothAnimations.animations = [animation]
      bothAnimations.duration = animation.duration * 2
      bothAnimations.repeatCount = Float.greatestFiniteMagnitude
      
      storkeLayer.add(bothAnimations, forKey: "bothAnimations")
    }
    
  }
  
  
  func removeCollectionViewCellAnimations() {
    
    let collectionViewCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CollectionViewTableCell
    
    for each in collectionViewCell.collectionView.visibleCells {
      let eachCell = each as! ColorThemeCell
      for each in eachCell.layer.sublayers! {
        if each.name == "stroke" {
          each.removeFromSuperlayer()
        }
      }
    }
  }
  
  
  @objc
  func partySoundToggled(_ sender: UISwitch) {
    
    if sender.isOn {
      defaults.set(true, forKey: "partySoundOn")
      partySound?.prepareToPlay()
      partySound?.play()
    } else {
      defaults.set(false, forKey: "partySoundOn")
      partySound?.stop()
    }
  }
  
  
  @objc
  func partyLightToggled(_ sender: UISwitch) {
    
    if sender.isOn {
      defaults.set(true, forKey: "partyLightOn")
      toggleTorchOn()
    } else {
      defaults.set(false, forKey: "partyLightOn")
      if device!.hasTorch {
        do {
          try device!.lockForConfiguration()
          
          if lightOn {
            device!.torchMode = .off
            lightOn = !lightOn
          }
          device!.unlockForConfiguration()
        } catch {
          print("Torch could not be used")
        }
      }
    }
  }
  
  
  func toggleTorchOn() {

    if device!.hasTorch {
      do {
        try device!.lockForConfiguration()

        if lightOn {
          device!.torchMode = .off
        } else {
          device!.torchMode = .on
        }
        lightOn = !lightOn
        device!.unlockForConfiguration()
      } catch {
        print("Torch could not be used")
      }
      DispatchQueue.main.asyncAfter(deadline:.now() + 0.15 ) {
        if self.defaults.bool(forKey: "partyLightOn") {
          self.toggleTorchOn()
        }
      }
    } else {
      print("Torch is not available")
    }
  }
  
  
  var retroSoundSwitch: UISwitch!
  var partySoundSwitch: UISwitch!
  
  @objc
  func allSounds(_ sender: UISwitch) {
    
    if sender.isOn {
      defaults.set(false, forKey: "allSoundsOff")
      retroSoundSwitch.isEnabled = true
      partySoundSwitch.isEnabled = true
    } else {
      defaults.set(true, forKey: "allSoundsOff")
      defaults.set(true, forKey: "retroSoundsOff")
      retroSoundSwitch.setOn(false, animated: true)
      retroSoundSwitch.isEnabled = false
      partySound?.stop()
      partySoundSwitch.setOn(false, animated: true)
      partySoundSwitch.isEnabled = false
    }
  }
  
  
  @objc
  func retroSounds(_ sender: UISwitch) {
    
    if sender.isOn {
      defaults.set(false, forKey: "retroSoundsOff")
    } else {
      defaults.set(true, forKey: "retroSoundsOff")
    }
  }

  
}





extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return 1
    } else if section == 1 {
      return 3
    } else {
      return 1
    }
  }
  
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let label: UILabel = {
      let label = UILabel()
      
      label.textAlignment = .left
      label.textColor = Theme.tableViewHeaderTextColor
      label.backgroundColor = Theme.tableViewHeaderBackgroundColor
      label.font = Theme.tableViewHeaderFont
      
      return label
    }()
    if section == 0 {
      label.text = " THEMES"
    } else if section == 1 {
      label.text = " MODES"
    } else {
      label.text = " SOUNDS"
    }
    return label
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if indexPath.section == 0 {
      return 130
    } else {
      if let isExpanded = selectedCells[indexPath] {
        if isExpanded {
          if indexPath.row == 2 {
            return 160
          } else {
            return expandedCellHeight
          }
        }
      }
      return collapsedCellHeight
    }
    
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section == 0 {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableCell", for: indexPath) as! CollectionViewTableCell
      cell.viewController = self
      cell.setColors()
     
      if defaults.bool(forKey: "retroModeOn") {
        cell.retroModeOn()
      }
      return cell
      
    } else if indexPath.section == 1 {
      
      if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsViewTableViewCell", for: indexPath) as! SettingsViewTableViewCell
        cell.setColors()
        cell.toggle.onTintColor = Theme.toggleHighlightColor
        cell.label.text = "DARK MODE"
        cell.toggle.addTarget(self, action: #selector(darkModeToggled), for: .touchUpInside)
        if defaults.bool(forKey: "darkModeOn") {
          cell.toggle.setOn(true, animated: false)
        }
        return cell
        
      } else if indexPath.row == 1 {
        
        let retroCell = tableView.dequeueReusableCell(withIdentifier: "RetroModeTableViewCell", for: indexPath) as! RetroModeTableViewCell
        retroCell.label.text = "RETRO MODE"
        retroCell.toggle.addTarget(self, action: #selector(retroModeToggled), for: .touchUpInside)
        retroCell.soundToggle.addTarget(self, action: #selector(retroSounds), for: .touchUpInside)

        retroCell.setColors()
        retroCell.toggle.onTintColor = Theme.toggleHighlightColor
        retroCell.soundToggle.onTintColor = Theme.toggleHighlightColor
        retroSoundSwitch = retroCell.soundToggle
        
        if defaults.bool(forKey: "allSoundsOff") {
          retroCell.soundToggle.setOn(false, animated: false)
        }
        
        return retroCell
        
      } else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyModeTableViewCell", for: indexPath) as! PartyModeTableViewCell
        cell.setColors()
        
        cell.toggle.onTintColor = Theme.toggleHighlightColor
        cell.toggle.addTarget(self, action: #selector(partyModeToggled), for: .touchUpInside)
        
        cell.soundToggle.onTintColor = Theme.toggleHighlightColor
        cell.soundToggle.addTarget(self, action: #selector(partySoundToggled), for: .touchUpInside)
        if defaults.bool(forKey: "allSoundsOff") {
          cell.soundToggle.setOn(false, animated: false)
        }
        partySoundSwitch = cell.soundToggle
        
        cell.lightToggle.onTintColor = Theme.toggleHighlightColor
        cell.lightToggle.addTarget(self, action: #selector(partyLightToggled), for: .touchUpInside)
        
        cell.label.text = "PARTY MODE"
        
        return cell
      }
      
    } else {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsViewTableViewCell") as! SettingsViewTableViewCell
      cell.setColors()
      cell.toggle.onTintColor = Theme.toggleHighlightColor
      if indexPath.row == 0 {
        cell.label.text = "ALL SOUNDS"
        cell.toggle.setOn(!defaults.bool(forKey: "allSoundsOff"), animated: false)
        cell.toggle.addTarget(self, action: #selector(allSounds), for: .touchUpInside)
      }

      return cell
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
  }
  
}
