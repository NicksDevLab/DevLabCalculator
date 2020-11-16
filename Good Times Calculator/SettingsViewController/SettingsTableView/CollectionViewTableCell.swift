//
//  CollectionViewTableCell.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/27/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit



class CollectionViewTableCell: UITableViewCell {
  
  var viewController: SettingsViewController?
  
  var collectionView: UICollectionView!
  
  let defaults = UserDefaults.standard
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.selectionStyle = .none
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = Theme.viewBackgroundColor
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(ColorThemeCell.self, forCellWithReuseIdentifier: "colorCell")
    
    setupView()
  }
  
  
  func setupView() {
    
    self.contentView.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
      collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      collectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
      ])
  }
  
  
  func setColors() {
    
    UIView.animate(withDuration: 0.5) {
      
      if self.defaults.bool(forKey: "partyModeOn") == false {
        for cell in self.collectionView.visibleCells {
          let eachCell = cell as! ColorThemeCell
          eachCell.button.layer.borderColor = Theme.numberButtonBorderColor
        }
      }
      
      self.collectionView.backgroundColor = Theme.viewBackgroundColor
      self.collectionView.reloadData()
    }
  }
  

  func retroModeOn() {
    
    UIView.animate(withDuration: 0.5) {
      for cell in self.collectionView.visibleCells {
        let eachCell = cell as! ColorThemeCell
        eachCell.layer.cornerRadius = eachCell.frame.height / 10
        eachCell.button.layer.cornerRadius = eachCell.button.frame.height / 10
      }
      self.collectionView.setNeedsLayout()
    }
  }
  
  
  func retroModeOff() {
    
    UIView.animate(withDuration: 0.5) {
      for cell in self.collectionView.visibleCells {
        let eachCell = cell as! ColorThemeCell
        eachCell.layer.cornerRadius = eachCell.frame.height / 2
        eachCell.button.layer.cornerRadius = eachCell.button.frame.height / 2
      }
      self.collectionView.setNeedsLayout()
    }
  }
  

  func updateColorTheme() {
    self.viewController?.navigationController?.navigationBar.barTintColor = Theme.viewBackgroundColor
    self.viewController?.navigationController?.navigationBar.tintColor = Theme.navigationBarItemsColor
    self.viewController?.settingsTitleView.textLabel.textColor = Theme.navigationBarItemsColor
    self.viewController?.navigationController?.navigationBar.layoutIfNeeded() //Needs to be called
    self.viewController?.tableView.reloadData()
  }
  
  
  @objc
  func blackAndWhiteTheme() {
    Theme.blackAndWhite()
    updateColorTheme()
  }
  
  
  @objc
  func greenMode() {
    Theme.greenMode()
    updateColorTheme()
  }
  
  
  @objc
  func redMode() {
    Theme.redMode()
    updateColorTheme()
  }
  
  
  @objc
  func blueMode() {
    Theme.blueMode()
    updateColorTheme()
  }

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}







extension CollectionViewTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let defaultBorderColor = defaults.bool(forKey: "darkModeOn") ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorThemeCell
    if indexPath.row == 0 {
      cell.button.addTarget(self, action: #selector(blackAndWhiteTheme), for: .touchUpInside)
      let image = defaults.bool(forKey: "darkModeOn") ?
        (defaults.bool(forKey: "retroModeOn") ? UIImage(named: "BWRMode-Dark") : UIImage(named: "BWMode-Dark")) :
        (defaults.bool(forKey: "retroModeOn") ? UIImage(named: "BWRMode-Light") : UIImage(named: "BWMode-Light"))
      cell.button.setImage(image, for: .normal)
      cell.button.layer.borderColor = defaults.bool(forKey: "blackAndWhiteThemeOn") ? Theme.numberButtonBorderColor : defaultBorderColor
      cell.button.layer.borderWidth = defaults.bool(forKey: "blackAndWhiteThemeOn") ? 3 : 1
    }
    if indexPath.row == 1 {
      cell.button.addTarget(self, action: #selector(greenMode), for: .touchUpInside)
      let image = defaults.bool(forKey: "darkModeOn") ?
          (defaults.bool(forKey: "retroModeOn") ? UIImage(named: "GreenRMode-Dark") : UIImage(named: "GreenMode-Dark")) :
          (defaults.bool(forKey: "retroModeOn") ? UIImage(named: "GreenRMode-Light") : UIImage(named: "GreenMode-Light"))
      cell.button.setImage(image, for: .normal)
      cell.button.layer.borderColor = defaults.bool(forKey: "greenThemeOn") ? Theme.numberButtonBorderColor : defaultBorderColor
      cell.button.layer.borderWidth = defaults.bool(forKey: "greenThemeOn") ? 3 : 1
    }
    if indexPath.row == 2 {
      cell.button.addTarget(self, action: #selector(redMode), for: .touchUpInside)
      let image = defaults.bool(forKey: "darkModeOn") ?
        (defaults.bool(forKey: "retroModeOn") ? UIImage(named: "RedRMode-Dark") : UIImage(named: "RedMode-Dark")) :
        (defaults.bool(forKey: "retroModeOn") ? UIImage(named: "RedRMode-Light") : UIImage(named: "RedMode-Light"))
      cell.button.setImage(image, for: .normal)
      cell.button.layer.borderColor = defaults.bool(forKey: "redThemeOn") ? Theme.numberButtonBorderColor : defaultBorderColor
      cell.button.layer.borderWidth = defaults.bool(forKey: "redThemeOn") ? 3 : 1
    }
    if indexPath.row == 3 {
      cell.button.addTarget(self, action: #selector(blueMode), for: .touchUpInside)
      let image = defaults.bool(forKey: "darkModeOn") ?
        (defaults.bool(forKey: "retroModeOn") ? UIImage(named: "BlueRMode-Dark") : UIImage(named: "BlueMode-Dark")) :
        (defaults.bool(forKey: "retroModeOn") ? UIImage(named: "BlueRMode-Light") : UIImage(named: "BlueMode-Light"))
      cell.button.setImage(image, for: .normal)
      cell.button.layer.borderColor = defaults.bool(forKey: "blueThemeOn") ? Theme.numberButtonBorderColor : defaultBorderColor
      cell.button.layer.borderWidth = defaults.bool(forKey: "blueThemeOn") ? 3 : 1
    }
    if defaults.bool(forKey: "retroModeOn") {
      cell.layer.cornerRadius = cell.frame.height / 10
      cell.button.layer.cornerRadius = cell.button.frame.height / 10
    }
    
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: 100)
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
  }
}


