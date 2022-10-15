//
//  UIView+Shadow.swift
//  HammerTest
//

import UIKit

extension UIView {
  func addShadow(offset: CGSize, radius: CGFloat, color: UIColor = .black, opacity: Float = 1) {
    layer.shadowOffset = offset
    layer.shadowRadius = radius
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
  }
}
