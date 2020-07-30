//
//  SkewableTextfield.swift
//  AnimationShowcase
//
//  Created by Tomas Trujillo on 2020-07-29.
//  Copyright © 2020 CodingWithTom. All rights reserved.
//

import UIKit

class SkewableTextfield: UITextField {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
}

private extension SkewableTextfield {
  func setup() {
    let clearButton = UIButton()
    clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
    clearButton.addTarget(self, action: #selector(tappedClearButton), for: .touchUpInside)
    rightView = clearButton
    rightViewMode = .whileEditing
  }
  
  @objc
  func tappedClearButton() {
    let skew: CGFloat = 0.25
    UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: .calculationModeLinear, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
        let transform = self.transform
        self.transform = CGAffineTransform(a: transform.a, b: transform.b, c: skew,
                                           d: transform.d, tx: transform.tx, ty: transform.ty)
      }
      UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
        let transform = self.transform
        self.transform = CGAffineTransform(a: transform.a, b: transform.b, c: -skew,
                                           d: transform.d, tx: transform.tx, ty: transform.ty)
      }
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
        let transform = self.transform
        self.transform = CGAffineTransform(a: transform.a, b: transform.b, c: skew / 2,
                                           d: transform.d, tx: transform.tx, ty: transform.ty)
      }
      UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
        let transform = self.transform
        self.transform = CGAffineTransform(a: transform.a, b: transform.b, c: -skew / 2,
                                           d: transform.d, tx: transform.tx, ty: transform.ty)
      }
    }) { _ in
      self.text = nil
      self.transform = CGAffineTransform.identity
    }
  }
}
