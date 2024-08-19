//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 19.08.2024.
//

import UIKit

protocol AlertPresenterDelegate {
  func show(_ model: AlertModel)
}

class AlertPresenterImp {
  private weak var delegate: UIViewController?
  
  init(delegate: UIViewController? = nil) {
    self.delegate = delegate
  }
}

extension AlertPresenterImp: AlertPresenterDelegate {
  func show(_ model: AlertModel) {
    let controller = UIAlertController(
      title: model.title,
      message: model.message,
      preferredStyle: .alert
    )
    
    controller.addAction(.init(
      title: "Play one more time?",
      style: .default,
      handler: {_ in 
        model.action?()
      }
    ))
    
    delegate?.present(controller, animated: true)
  }
}
