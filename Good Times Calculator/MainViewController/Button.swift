//
//  Button.swift
//  WhoKnows
//
//  Created by Nicholas Church on 5/4/19.
//  Copyright © 2019 Nicholas Church. All rights reserved.
//

import UIKit
import AVFoundation





class Button: UIButton {
  
  var click: AVAudioPlayer!
  var beep:  AVAudioPlayer!
  var retroCalculationSound: AVAudioPlayer!
  var beep1: AVAudioPlayer!
  var beep2: AVAudioPlayer!
  var beep3: AVAudioPlayer!
  var beep4: AVAudioPlayer!
  
  var retroSoundsURLs: [URL] = []

  let generator = UIImpactFeedbackGenerator(style: .light)
  let animationTime = 0.1
  
  let defualts = UserDefaults.standard
  
  var isNumberButton: Bool?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  func setup() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    self.layer.borderWidth = 1
    
    self.addTarget(self, action: #selector(pressDownAnimation), for: [.touchDown, .touchDragEnter, .touchCancel])
    //self.addTarget(self, action: #selector(unpressAnimation), for: [.touchDragExit, .touchUpInside, .touchUpOutside])
    generator.prepare()
    
    if let beep1 = Bundle.main.url(forResource: "beep1", withExtension: "m4a", subdirectory: "ButtonSounds"),
      let beep2 = Bundle.main.url(forResource: "beep2", withExtension: "m4a", subdirectory: "ButtonSounds"),
      let beep3 = Bundle.main.url(forResource: "beep3", withExtension: "m4a", subdirectory: "ButtonSounds"),
      let beep4 = Bundle.main.url(forResource: "beep4", withExtension: "m4a", subdirectory: "ButtonSounds") {
        retroSoundsURLs.appendMultiple(beep1, beep2, beep3, beep4)
      }
    
    
  }
  
  
  func setColors() {
    if isNumberButton! {
      layer.borderColor = Theme.numberButtonBorderColor
      backgroundColor = Theme.numberButtonBackgroundColor
      setTitleColor(Theme.numberButtonTitleColor, for: .normal)
    } else {
      layer.borderColor = Theme.otherButtonBorderColor
      if self.title(for: .normal) == "AC" || self.title(for: .normal) == "C" {
        backgroundColor = Theme.clearAllButtonBackgroundColor
      } else if self.title(for: .normal) == "MS" || self.title(for: .normal) == "M+" || self.title(for: .normal) == "M-" || self.title(for: .normal) == "MR"{
        backgroundColor = Theme.memoryButtonBackgroundColor
      } else if self.title(for: .normal) == "%" {
        backgroundColor = Theme.percentageButtonBackgroundColor
      } else if self.title(for: .normal) == "+/-" {
        backgroundColor = Theme.plusMinusButtonBackgroundColor
      } else {
        backgroundColor = Theme.otherButtonBackgroundColor
        setTitleColor(Theme.otherButtonTitleColor, for: .normal)
      }
      
    }
    
  }
  
  
  func randomColors() {
    layer.borderColor = UIColor.random.cgColor
    backgroundColor = UIColor.random
    setTitleColor(Theme.otherButtonTitleColor, for: .normal)
  }
  
  
 
  var previousFont: UIFont?
  var previousColor: UIColor!
  
  @objc
  func pressDownAnimation() {
    
    generator.impactOccurred()
    
    if defualts.bool(forKey: "allSoundsOff") == false && defualts.bool(forKey: "partySoundOn") == false {
      if UserDefaults.standard.bool(forKey: "retroSoundsOff") == false {
        
        do {
          let randomIndex = Int.random(in: 0...3)
          beep = try AVAudioPlayer(contentsOf: retroSoundsURLs[randomIndex])
          beep.prepareToPlay()
        } catch {
          print("bad audio")
        }
        beep.play()
        
        if self.title(for: .normal) == "=" && defualts.bool(forKey: "equalsSelectedLast") == false {
          do {
            let url = Bundle.main.url(forResource: "retroCalculationSound2", withExtension: "m4a", subdirectory: "ButtonSounds")
            click = try AVAudioPlayer(contentsOf: url!)
            click.prepareToPlay()
          } catch {
            print("bad audio")
          }
          click.play()
        } else {
          do {
            let url = Bundle.main.url(forResource: "click4", withExtension: "m4a", subdirectory: "ButtonSounds")
            click = try AVAudioPlayer(contentsOf: url!)
            click.prepareToPlay()
          } catch {
            print("bad audio")
          }
          click.play()
        }
        
      } else {
        do {
          let url = Bundle.main.url(forResource: "click4", withExtension: "m4a", subdirectory: "ButtonSounds")
          click = try AVAudioPlayer(contentsOf: url!)
          click.prepareToPlay()
        } catch {
          print("bad audio")
        }
        click.play()
      }
      
    }

    
    previousFont = self.titleLabel?.font
    previousColor = self.backgroundColor

    UIView.animate(withDuration: animationTime, animations: {

      self.titleLabel?.font = self.titleLabel?.font.withSize(45)
      if self.defualts.bool(forKey: "partyModeOn") == false {
        self.backgroundColor = UIColor.white
      }
    }) { (true) in
      self.titleLabel?.font = self.previousFont
      if self.defualts.bool(forKey: "partyModeOn") == false {
        self.backgroundColor = self.previousColor
      }
    }
    
    if self.currentTitle == "=" &&
       defualts.bool(forKey: "retroModeOn") &&
       defualts.bool(forKey: "retroSoundsOff") == false &&
       defualts.bool(forKey: "equalsSelectedLast") == false {
      
      self.isUserInteractionEnabled = false
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
        self.isUserInteractionEnabled = true
        
      }
    }

    generator.prepare()
  }
  
  
  @objc
  func unpressAnimation() {
//    click.volume = 0.05
//    click.play()
//    click.prepareToPlay()
//    UIView.animate(withDuration: animationTime) {
//      self.backgroundColor = self.previousColor
//      self.titleLabel?.font = self.previousFont
//    }
  }
    
    
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
