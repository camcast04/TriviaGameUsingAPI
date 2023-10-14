//
//  ViewController.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

class TriviaViewController: UIViewController {
  
  @IBOutlet weak var currentQuestionNumberLabel: UILabel!
  @IBOutlet weak var questionContainerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
  
  private var questions = [TriviaQuestion]()
  private var currQuestionIndex = 0
  private var numCorrectQuestions = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    questionContainerView.layer.cornerRadius = 8.0
    fetchTriviaQuestions()
  }
    
    private func fetchTriviaQuestions() {
        TriviaQuestionService.shared.fetchQuestions { [weak self] result in
            switch result {
            case .success(let questions):
                self?.questions = questions
                self?.updateQuestion(withQuestionIndex: 0)
            case .failure(let error):
                print("Failed to fetch trivia questions with error: \(error)")
                // Optionally, display an alert to the user
                let alertController = UIAlertController(title: "Error", message: "Failed to fetch trivia questions. Please try again.", preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
                    self?.fetchTriviaQuestions()
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alertController.addAction(retryAction)
                alertController.addAction(cancelAction)
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true, completion: nil)
                }
                // Handle the error, for example, by displaying an alert
            }
        }
    }
  
    private func updateQuestion(withQuestionIndex questionIndex: Int) {
        DispatchQueue.main.async {
            self.currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(self.questions.count)"
            let question = self.questions[questionIndex]
            self.questionLabel.text = question.question
            self.categoryLabel.text = question.category
            let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
            if answers.count > 0 {
                self.answerButton0.setTitle(answers[0], for: .normal)
            }
            if answers.count > 1 {
                self.answerButton1.setTitle(answers[1], for: .normal)
                self.answerButton1.isHidden = false
            }
            if answers.count > 2 {
                self.answerButton2.setTitle(answers[2], for: .normal)
                self.answerButton2.isHidden = false
            }
            if answers.count > 3 {
                self.answerButton3.setTitle(answers[3], for: .normal)
                self.answerButton3.isHidden = false
            }
        }
    }
  
  private func updateToNextQuestion(answer: String) {
    if isCorrectAnswer(answer) {
      numCorrectQuestions += 1
    }
    currQuestionIndex += 1
    guard currQuestionIndex < questions.count else {
      showFinalScore()
      return
    }
    updateQuestion(withQuestionIndex: currQuestionIndex)
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correctAnswer
  }
  
    private func showFinalScore() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Game over!",
                                                    message: "Final score: \(self.numCorrectQuestions)/\(self.questions.count)",
                                                    preferredStyle: .alert)
            let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
                self.currQuestionIndex = 0
                self.numCorrectQuestions = 0
                self.updateQuestion(withQuestionIndex: self.currQuestionIndex)
            }
            alertController.addAction(resetAction)
            self.present(alertController, animated: true, completion: nil)
            let newGameAction = UIAlertAction(title: "New Game", style: .default) { [unowned self] _ in
                self.fetchTriviaQuestions()
            }
            alertController.addAction(newGameAction)
        }
    }
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
}

