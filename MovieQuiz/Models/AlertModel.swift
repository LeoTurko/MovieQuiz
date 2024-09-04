//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 04.09.2024.
//

import Foundation

struct AlertModel {
  let title: String
  let message: String
  let buttonText: String
  let buttonAction: (() -> Void)?
}
