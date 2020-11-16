//
//  RightNavBarItem.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/26/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


class RightNavBarItem: UIBarButtonItem {
  
  override init() {
    super.init()
    self.title = ". . ."
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
