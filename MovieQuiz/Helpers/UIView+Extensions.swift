//
//  Extension+UIView.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 24.05.2024.
//

import UIKit

extension UIView {
  func addSubviews(_ subviews: [UIView]) {
    subviews.forEach { addSubview($0) }
  }
  
  @discardableResult func edgesToSuperview() -> Self {
    guard let superview = superview else {
      fatalError("View не в иерархии!")
    }
    
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superview.topAnchor),
      leftAnchor.constraint(equalTo: superview.leftAnchor),
      rightAnchor.constraint(equalTo: superview.rightAnchor),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor)
    ])
    return self
  }
}

