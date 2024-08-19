//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 19.08.2024.
//

struct AlertModel {
  let title: String
  let message: String
  let buttonText: String
  let action: (() -> Void)?
}
