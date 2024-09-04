//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 01.09.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
  func didReceiveNextQuestion(question: QuizQuestion?)
}
