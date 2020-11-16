//
//  TableViewHeader.swift
//  WhoKnows
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit



class TableViewHeader: UITableViewHeaderFooterView {
  
  var backgroundColorView: UIView!
  var label: UILabel!
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.textLabel?.textAlignment = .left
    backgroundColorView = UIView(frame: .zero)
    label = UILabel(frame: .zero)
    label.font = Theme.tableViewHeaderFont
    backgroundColorView.addSubview(label)
    self.backgroundView = backgroundColorView
  }
  
  func setColors() {
    
    UIView.animate(withDuration: 0.5) {
      self.backgroundColorView.backgroundColor = Theme.tableViewHeaderBackgroundColor
      self.label.textColor = Theme.tableViewHeaderTextColor
      self.label.font = Theme.tableViewHeaderFont
      self.layoutIfNeeded()
    }
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
