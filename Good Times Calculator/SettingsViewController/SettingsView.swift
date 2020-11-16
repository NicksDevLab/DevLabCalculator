//
//  File.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit



class SettingsView: UIView {
  
  var tableView: UITableView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.backgroundColor = .yellow
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal

    tableView = UITableView()
    tableView.backgroundColor = Theme.viewBackgroundColor
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.sectionHeaderHeight = 25

    setupView()
  }
  
  
  func setupView() {
    
    self.addSubViews(tableView)
    
    NSLayoutConstraint.activate([
      tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
      tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
      tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
  }

  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}






