//
//  FlipToggleButton.swift
//  AnimationShowcase
//
//  Created by Tomas Trujillo on 2020-07-29.
//  Copyright © 2020 CodingWithTom. All rights reserved.
//

import UIKit

protocol FlipToggleButtonDelegate: class {
  func didTapToggle(isOn: Bool)
}

class FlipToggleButton: UIView {
  @IBInspectable
  var onImage: UIImage? {
    didSet {
      updateImage()
    }
  }
  @IBInspectable
  var offImage: UIImage? {
    didSet {
      updateImage()
    }
  }
  @IBInspectable
  var isOn: Bool = false {
    didSet {
      updateImage()
    }
  }
  weak var delegate: FlipToggleButtonDelegate?
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView(frame: bounds)
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
}

private extension FlipToggleButton {
  func setup() {
    backgroundColor = .clear
    addSubview(imageView)
    addTapGesture()
  }
  
  func addTapGesture() {
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
  }
  
  @objc
  func tappedView() {
    animateToggle()
    delegate?.didTapToggle(isOn: isOn)
  }
  
  func animateToggle() {
    UIView.transition(with: imageView, duration: 0.5, options: .transitionFlipFromBottom, animations: {
      self.isOn.toggle()
    }, completion: nil)
    UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: {
      self.transform = CGAffineTransform(translationX: 0.0, y: -50)
    }, completion: nil)
    UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseOut, animations: {
      self.transform = CGAffineTransform.identity
    }, completion: nil)
  }
  
  func updateImage() {
    imageView.image = isOn ? onImage : offImage
  }
}
