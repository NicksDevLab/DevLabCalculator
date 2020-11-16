//
//  NavController.swift
//  Good Times Calculator
//
//  Created by Nicholas Church on 5/29/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


class NavController: UINavigationController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return Theme.statusBarColor
  }
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
}
