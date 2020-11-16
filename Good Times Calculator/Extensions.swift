//
//  Extensions.swift
//  WhoKnows
//
//  Created by Nicholas Church on 5/5/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit


extension UIView {
  func addSubViews(_ views: UIView...) {
    for eachView in views {
      addSubview(eachView)
    }
  }
}


extension Array {
  
  mutating func appendMultiple(_ items: Element...) {
    for each in items {
      append(each)
    }
  }
  
  mutating func removeItems(_ itemsFromEnd: Int) {
    var number = itemsFromEnd
    while number > 0 {
      removeLast()
      number -= 1
    }
  }
  
  mutating func removeItemsWithTitles(_ titles: String...) {
    var i = 0
    for each in self {
      let item = each as! Button
      for every in titles {
        if item.titleLabel?.text == every {
          remove(at: i)
          i -= 1
        }
      }
      i += 1
    }
  }
  
  mutating func appendItemsFromArray(_ withTitles: String..., from array: Array) {
    for each in withTitles {
      for every in array {
        let item = every as! Button
        if item.titleLabel?.text == each {
          self.append(every)
        }
      }
    }
  }
  
  func itemWithTitle(title: String) -> Button? {
    for every in self {
      let item = every as! Button
      if item.title(for: .normal) == title {
        return item
      }
    }
    return nil
  }
  
}


extension UIColor {
  static var random: UIColor {
    return UIColor(red: .random(in: 0...1),
                   green: .random(in: 0...1),
                   blue: .random(in: 0...1),
                   alpha: 1.0)
  }
  
  class var darkGreen: UIColor {
    return UIColor(red: 0.18, green: 0.6, blue: 0.25, alpha: 1.0)
  }
  
  class var lightBlue: UIColor {
    return UIColor(red: 0.22, green: 0.9, blue: 0.92, alpha: 1.0)
  }
  
  class var darkModeRed: UIColor {
    return UIColor(red: 0.9, green: 0.2, blue: 0.3, alpha: 1.0)
  }
}


