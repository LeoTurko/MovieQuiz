//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 26.08.2024.
//

class QuestionFactory {
  
  private weak var delegate: QuestionFactoryDelegate?
  
  init(delegate: QuestionFactoryDelegate? = nil) {
    self.delegate = delegate
  }
  
  private let questions: [QuizQuestion] = [
    QuizQuestion(image: "The Godfather", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    QuizQuestion(image: "The Dark Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    QuizQuestion(image: "Kill Bill", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    QuizQuestion(image: "The Avengers", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    QuizQuestion(image: "Deadpool", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    QuizQuestion(image: "The Green Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    QuizQuestion(image: "Old", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
    QuizQuestion(image: "The Ice Age Adventures of Buck Wild", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
    QuizQuestion(image: "Tesla", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
    QuizQuestion(image: "Vivarium", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
  ]
  
  
}

extension QuestionFactory: QuestionFactoryProtocol {
  func requestNextQuestion() {
    guard let index = (0..<questions.count).randomElement() else {
      delegate?.didReceiveNextQuestion(question: nil)
      return
    }
    
    let question = questions[safe: index]
    delegate?.didReceiveNextQuestion(question: question)
  }
}
