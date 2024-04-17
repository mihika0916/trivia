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
    // TODO: FETCH TRIVIA QUESTIONS HERE
      setupDummyQuestions()
      //getTriviaQuestions()
      fetchTriviaQuestions()
  }
    
    private func setupDummyQuestions() {
        // Dummy questions
        let question1 = TriviaQuestion(type: "General Knowledge", difficulty: "easy",
                                       categoryRaw: "Paris",
                                       questionRaw: "What is the capital of France?",
                                       correctAnswerRaw: "Berlin",
                                       incorrectAnswersRaw: ["Berlin", "London", "Rome"])
        
        // Add the dummy questions to the array
        questions = [question1]
        
        // Update the UI with the first question
        updateQuestion(withQuestionIndex: currQuestionIndex)
    }
  
  private func updateQuestion(withQuestionIndex questionIndex: Int) {
    currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
    let question = questions[questionIndex]
    configure(with: question)
    
  }
    
    private func configure (with question:TriviaQuestion) {
        questionLabel.text = question.question
        categoryLabel.text = question.category
        let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
//        if answers.count > 0 {
//          answerButton0.setTitle(answers[0], for: .normal)
//        }
//        if answers.count > 1 {
//          answerButton1.setTitle(answers[1], for: .normal)
//          answerButton1.isHidden = false
//        }
//        if answers.count > 2 {
//          answerButton2.setTitle(answers[2], for: .normal)
//          answerButton2.isHidden = false
//        }
//        if answers.count > 3 {
//          answerButton3.setTitle(answers[3], for: .normal)
//          answerButton3.isHidden = false
//        }
        
        let answerButtons = [answerButton0, answerButton1, answerButton2, answerButton3]
           for button in answerButtons {
               button?.setTitle("", for: .normal)
               button?.isHidden = true
           }

           // Now, set the titles for the available answers and make sure those buttons are visible.
           for (index, button) in answerButtons.enumerated() {
               if index < answers.count {
                   button?.setTitle(answers[index], for: .normal)
                   button?.isHidden = false
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
    let alertController = UIAlertController(title: "Game over!",
                                            message: "Final score: \(numCorrectQuestions)/\(questions.count)",
                                            preferredStyle: .alert)
    let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
      currQuestionIndex = 0
      numCorrectQuestions = 0
        fetchTriviaQuestions()
      //updateQuestion(withQuestionIndex: currQuestionIndex)
    }
    alertController.addAction(resetAction)
    present(alertController, animated: true, completion: nil)
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
    
    func fetchTriviaQuestions() {
        let triviaService = TriviaService() // Initialize your TriviaService
        triviaService.getTriviaQuestions { [weak self] (questions: [TriviaQuestion]?) in
            // Ensure the operation returns to the main thread, as UI updates must be on the main thread
            DispatchQueue.main.async {
                guard let questions = questions, !questions.isEmpty else {
                    // Handle error or empty questions case
                    print("Failed to fetch questions or no questions fetched")
                    return
                }
                self?.questions = questions
                
                print(questions)
                // Update the UI with the first question
                self?.updateQuestion(withQuestionIndex: 0)
            }
        }
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

