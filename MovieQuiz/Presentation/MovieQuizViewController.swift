//
//  MovieQuizViewController.swift
//  MovieQuiz
//
//  Created by Леонид Турко on 21.05.2024.
//

import UIKit

class MovieQuizViewController: UIViewController {
  
  // MARK: - UI-Elements
  private lazy var mainStackView: UIStackView = {
    let element = UIStackView()
    element.axis = .vertical
    element.distribution = .fill
    element.alignment = .fill
    element.spacing = 20
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var labelsStack: UIStackView = {
    let element = UIStackView()
    element.distribution = .fill
    element.alignment = .fill
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var questionTitleLabel: UILabel = {
    let element = UILabel()
    element.text = "Вопрос:"
    element.font = .ysBigMedium
    element.textColor = .ypWhite
    element.numberOfLines = 0
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var counterLabel: UILabel = {
    let element = UILabel()
    element.text = "1/10"
    element.textColor = .ypWhite
    element.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
    element.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var imageView: UIImageView = {
    let element = UIImageView()
    element.contentMode = .scaleAspectFill
    element.backgroundColor = .ypWhite
    element.layer.borderWidth = 8
    element.layer.cornerRadius = 20
    element.layer.masksToBounds = true
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var viewForQuestion: UIView = {
    let element = UIView()
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var questionLabel: UILabel = {
    let element = UILabel()
    element.text = "Рейтинг этого фильма меньше чем 5?"
    element.font = .ysBold
    element.textColor = .ypWhite
    element.numberOfLines = 2
    element.textAlignment = .center
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var buttonsStack: UIStackView = {
    let element = UIStackView()
    element.axis = .horizontal
    element.alignment = .fill
    element.distribution = .fillEqually
    element.spacing = 20
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var noButton: UIButton = {
    let element = UIButton(type: .system)
    element.setTitle("Нет", for: .normal)
    element.setTitleColor(.ypBlack, for: .normal)
    element.titleLabel?.font = .ysBigMedium
    element.backgroundColor = .ypWhite
    element.layer.cornerRadius = 15
    element.addTarget(self, action: #selector(noButtonClicked), for: .touchUpInside)
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var yesButton: UIButton = {
    let element = UIButton(type: .system)
    element.setTitle("Да", for: .normal)
    element.setTitleColor(.ypBlack, for: .normal)
    element.titleLabel?.font = .ysBigMedium
    element.backgroundColor = .ypWhite
    element.layer.cornerRadius = 15
    element.addTarget(self, action: #selector(yesButtonClicked), for: .touchUpInside)
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  // MARK: - Private Properties
  private let questionsAmount = 10
  private var currentQuestionIndex = 0
  private var correctAnswers = 0
  
  private var alertPresenter: AlertPresenterDelegate?
  private var questionFactory: QuestionFactoryProtocol?
  private var currentQuestion: QuizQuestion?
  
  init(questionFactory: QuestionFactoryProtocol) {
    self.questionFactory = questionFactory
    QuestionFactory(delegate: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    setConstraints()
    setDelegates()
    setFirstQuestion()
    
    questionFactory = QuestionFactory(delegate: self)
  }
}

// MARK: - QuestionFactoryDelegate
extension MovieQuizViewController: QuestionFactoryDelegate {
  func didReceiveNextQuestion(question: QuizQuestion?) {
    guard let question else { return }
    
    currentQuestion = question
    let viewModel = convert(model: question)
    
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      self.show(quiz: viewModel)
    }
  }
}

// MARK: - Actions
extension MovieQuizViewController {
  @objc private func noButtonClicked(_ sender: UIButton) { // Проверить
    guard let currentQuestion = questionFactory.requestNextQuestion() else { return }//questions[currentQuestionIndex]
    let givenAnswer = false
    buttonsIsEnabled(yesButton, noButton)
    
    showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
  }
  
  @objc private func yesButtonClicked(_ sender: UIButton) { // Проверить
    guard let currentQuestion = questionFactory.requestNextQuestion() else { return }//questions[currentQuestionIndex]
    let givenAnswer = true
    buttonsIsEnabled(yesButton, noButton)
    
    showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
  }
  
  private func convert(model: QuizQuestion) -> QuizStepViewModel {
    QuizStepViewModel(
      image: UIImage(named: model.image) ?? UIImage(),
      question: model.text,
      questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)"
    )
  }
  
  private func show(quiz step: QuizStepViewModel) {
    
    counterLabel.text = step.questionNumber
    imageView.image = step.image
    questionLabel.text = step.question
  }
  
  private func show(quiz result: QuizResultsViewModel) {
    
    let alertModel = AlertModel(title: result.title, message: result.text, buttonText: result.buttonText) { [weak self] in
      guard let self else { return }
      self.currentQuestionIndex = 0
      self.correctAnswers = 0
      
      questionFactory?.requestNextQuestion()
    }
    
    alertPresenter?.show(alertModel)
//    let alert = UIAlertController(
//      title: result.title,
//      message: result.text,
//      preferredStyle: .alert)
//    
//    let action = UIAlertAction(title: "Сыграть еще раз?", style: .default) {  [weak self] _ in
//      guard let self else { return }
//      
//      self.currentQuestionIndex = 0
//      self.correctAnswers = 0
//      
//      let firstQuestion = self.questions[self.currentQuestionIndex]
//      let viewModel = self.convert(model: firstQuestion)
//      self.show(quiz: viewModel)
//    }
//    
//    alert.addAction(action)
//    
//    self.present(alert, animated: true)
  }
  
  private func showAnswerResult(isCorrect: Bool) {
    if isCorrect {
      correctAnswers += 1
    }
    
    imageView.layer.borderColor = isCorrect
    ? UIColor.ypGreen.cgColor
    : UIColor.ypRed.cgColor
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
      guard let self else { return }
      
      self.buttonsIsEnabled(self.yesButton, self.noButton)
      self.showNextQuestionOrResult()
      self.imageView.layer.borderColor = UIColor.clear.cgColor
    }
  }
  
  private func showNextQuestionOrResult() {
    if currentQuestionIndex == questionsAmount - 1 {
      let text = correctAnswers == questionsAmount 
      ? "Congrats you answer 10 0f 10!"
      : "You answer \(correctAnswers) of 10, try more"
      let viewModel = QuizResultsViewModel(
        title: "Этот раунд окончен",
        text: text,
        buttonText: "Сыграть еще раз")
      
      show(quiz: viewModel)
    } else {
      currentQuestionIndex += 1
      
      questionFactory?.requestNextQuestion()
    }
  }
  
  private func buttonsIsEnabled(_ buttons: UIButton...) {
    buttons.forEach { $0.isEnabled.toggle() }
  }
}

extension MovieQuizViewController {
  func setViews() {
    view.backgroundColor = .ypBlack
    mainStackView.addArrangedSubview(labelsStack)
    mainStackView.addArrangedSubview(imageView)
    mainStackView.addArrangedSubview(viewForQuestion)
    mainStackView.addArrangedSubview(buttonsStack)
    buttonsStack.addArrangedSubview(noButton)
    buttonsStack.addArrangedSubview(yesButton)
    labelsStack.addArrangedSubview(questionTitleLabel)
    labelsStack.addArrangedSubview(counterLabel)
    viewForQuestion.addSubview(questionLabel)
    view.addSubviews([mainStackView])
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      // Main Stack
      mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
      
      // Image View
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 2/3),
      
      // Question Label
      questionLabel.topAnchor.constraint(equalTo: viewForQuestion.topAnchor, constant: 13),
      questionLabel.bottomAnchor.constraint(equalTo: viewForQuestion.bottomAnchor, constant: -13),
      questionLabel.leadingAnchor.constraint(equalTo: viewForQuestion.leadingAnchor, constant: 42),
      questionLabel.centerXAnchor.constraint(equalTo: viewForQuestion.centerXAnchor),
      questionLabel.centerYAnchor.constraint(equalTo: viewForQuestion.centerYAnchor),
      
      buttonsStack.heightAnchor.constraint(equalToConstant: 60),
    ])
  }
  
  func setDelegates() {
    alertPresenter = AlertPresenterImp(delegate: self)
  }
  
  func setFirstQuestion() {
    questionFactory?.requestNextQuestion()
  }
}






