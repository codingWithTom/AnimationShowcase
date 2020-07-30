//
//  RefreshButton.swift
//  AnimationShowcase
//
//  Created by Tomas Trujillo on 2020-07-29.
//  Copyright © 2020 CodingWithTom. All rights reserved.
//

import UIKit

protocol RefreshButtonDelegate: class {
  func didTapView(isAnimating: Bool)
}

class RefreshButton: UIView {
  
  private let padding: CGFloat = 8.0
  private var leftEdgePoint: CGPoint { return CGPoint(x: 0.0 + padding, y: 0.0 + padding) }
  private var rightEdgePoint: CGPoint { return CGPoint(x: bounds.width - padding, y: bounds.height - padding) }
  private var centerPoint: CGPoint { return CGPoint(x: bounds.midX, y: bounds.midY) }
  private var arrowLength: CGFloat { return bounds.width / 12}
  var isAnimating: Bool = false {
    didSet {
      if isAnimating == false {
        stopAnimating()
      }
    }
  }
  weak var delegate: RefreshButtonDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  override func draw(_ rect: CGRect) {
    let upperArrowPath = UIBezierPath()
    let arrowPadding: CGFloat = .pi / 12
    upperArrowPath.move(to: CGPoint(x: leftEdgePoint.x, y: centerPoint.y))
    upperArrowPath.addArc(withCenter: centerPoint, radius: centerPoint.x - leftEdgePoint.x,
                          startAngle: .pi, endAngle: 0.0 - arrowPadding,
                          clockwise: true)
    var arrowPoint = upperArrowPath.currentPoint
    upperArrowPath.move(to: CGPoint(x: arrowPoint.x - arrowLength, y: arrowPoint.y - arrowLength / 2))
    upperArrowPath.addLine(to: arrowPoint)
    upperArrowPath.move(to: CGPoint(x: arrowPoint.x + arrowLength / 3, y: arrowPoint.y - arrowLength))
    upperArrowPath.addLine(to: arrowPoint)
    
    let lowerArrowPath = UIBezierPath()
    
    lowerArrowPath.move(to: CGPoint(x: rightEdgePoint.x, y: centerPoint.y))
    lowerArrowPath.addArc(withCenter: centerPoint, radius: centerPoint.x - leftEdgePoint.x,
                          startAngle: 0.0, endAngle: .pi - arrowPadding,
                          clockwise: true)
    arrowPoint = lowerArrowPath.currentPoint
    lowerArrowPath.move(to: CGPoint(x: arrowPoint.x - arrowLength / 2, y: arrowPoint.y + arrowLength))
    lowerArrowPath.addLine(to: arrowPoint)
    lowerArrowPath.move(to: CGPoint(x: arrowPoint.x + arrowLength, y: arrowPoint.y + arrowLength * 2 / 3))
    lowerArrowPath.addLine(to: arrowPoint)
    UIColor.blue.setStroke()
    upperArrowPath.lineWidth = 4.0
    lowerArrowPath.lineWidth = 4.0
    upperArrowPath.lineCapStyle = .round
    lowerArrowPath.lineCapStyle = .round
    upperArrowPath.stroke()
    lowerArrowPath.stroke()
  }
}

private extension RefreshButton {
  func setup() {
    backgroundColor = .clear
    addTapGesture()
  }
  
  func addTapGesture() {
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
  }
  
  @objc
  func tappedView(gesture: UITapGestureRecognizer) {
    isAnimating.toggle()
    delegate?.didTapView(isAnimating: isAnimating)
    if isAnimating {
      addAnimations()
    } else {
      stopAnimating()
    }
  }
  
  func stopAnimating() {
    layer.removeAllAnimations()
  }
  
  func addAnimations() {
    addRotatingAnimation()
    addScalingAnimation()
  }
  
  func addRotatingAnimation() {
    let rotatingAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotatingAnimation.duration = 1.0
    rotatingAnimation.fromValue = 0.0
    rotatingAnimation.toValue = CGFloat.pi * 2
    rotatingAnimation.repeatCount = .infinity
    layer.add(rotatingAnimation, forKey: "Rotation animation")
  }
  
  func addScalingAnimation() {
    let scaleXAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
    scaleXAnimation.values = [1.0, 1.2, 1.0]
    scaleXAnimation.repeatCount = .infinity
    scaleXAnimation.duration = 1.5
    layer.add(scaleXAnimation, forKey: "Scaling X animation")
    
    let scaleYAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
    scaleYAnimation.values = [1.0, 1.2, 1.0]
    scaleYAnimation.repeatCount = .infinity
    scaleYAnimation.duration = 1.5
    layer.add(scaleYAnimation, forKey: "Scaling Y animation")
  }
}
