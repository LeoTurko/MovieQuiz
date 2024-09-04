//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 04.09.2024.
//

import UIKit

protocol AlertPresenterDelegate {
  func show(model: AlertModel)
}

final class AlertPresenter {

  private weak var delegate: UIViewController?
  
  init(delegate: UIViewController? = nil) {
    self.delegate = delegate
  }
}

extension AlertPresenter: AlertPresenterDelegate {
  func show(model: AlertModel) {
    let alert = UIAlertController(
      title: model.title,
      message: model.message,
      preferredStyle: .alert
    )
    
    let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
      model.buttonAction?()
    }
    
    alert.addAction(action)
    delegate?.present(alert, animated: true)
  }
}
