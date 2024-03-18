//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Mihika Sharma on 17/02/24.
//

import UIKit

class TriviaViewController: UIViewController {
    private var allquizquestions = [QuizQuestion]()
    private var selectedQuestion = 0
    private var score = 0
    
    @IBOutlet weak var questionType: UILabel!
    
    @IBOutlet weak var questionNumber: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var Option1: UIButton!
    
    @IBOutlet weak var Option2: UIButton!
    
    @IBOutlet weak var Option3: UIButton!
    @IBOutlet weak var Option4: UIButton!
    
    
    
    @IBAction func optionClicked(_ sender: UIButton) {
        let selectedOptionIndex = sender.tag
            let currentQuestion = allquizquestions[selectedQuestion]

            
            if currentQuestion.isCorrect(option: currentQuestion.options[selectedOptionIndex]) {
                // Increase the score by 1 if the answer is correct
                score += 1
                //sender.backgroundColor = .systemGreen // Visual feedback for correct answer
                
                
            } else {
                //sender.backgroundColor = .systemRed // Visual feedback for incorrect answer
                
            }
        showNextQuestionOrScore()
    }
    
    
    
    @IBAction func didClickOption1(_ sender: UIButton) {
        
    }
    
    @IBAction func didClickOption2(_ sender: UIButton) {
    }
    
    
    @IBAction func didClickOption3(_ sender: UIButton) {
    }
    
    @IBAction func didClickOption4(_ sender: UIButton) {
    }
    
    private func showNextQuestionOrScore() {
        if selectedQuestion < allquizquestions.count - 1 {
            // There are more questions to display
            selectedQuestion += 1
            configure(with: allquizquestions[selectedQuestion])
        } else {
            // No more questions, show the score
            let alert = UIAlertController(title: "Quiz Complete", message: "You've answered \(score) out of \(allquizquestions.count) questions correctly.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Reset for a new round of questions if desired
            alert.addAction(UIAlertAction(title: "Start Over", style: .default) { [weak self] _ in
                self?.startNewQuizRound()
            })
            
            present(alert, animated: true)
        }
    }
    
    private func startNewQuizRound() {
        score = 0
        selectedQuestion = 0
        configure(with: allquizquestions[selectedQuestion])
    }
    
    
    @IBAction func didClickBackButton(_ sender: UIButton) {
        selectedQuestion = max(0, selectedQuestion - 1)
        configure(with: allquizquestions[selectedQuestion])
    }
    
    @IBAction func didClickNextButton(_ sender: UIButton) {
        selectedQuestion = min(allquizquestions.count - 1, selectedQuestion + 1)
        configure(with: allquizquestions[selectedQuestion])
    }
    
//    @IBOutlet weak var Option2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        allquizquestions = createMockData()
        configure(with: allquizquestions[0])
        // Do any additional setup after loading the view.
        
    }
    
    private func configure(with question: QuizQuestion) {
        // Set the category and question text
            questionType.text = question.category
            questionLabel.text = question.question
            
            // Update the question number label
            questionNumber.text = "Question \(selectedQuestion + 1)/\(allquizquestions.count)"

            // Assuming you have four option buttons, we'll set the titles of these buttons.
            // Also reset the appearance of the buttons for the new question
            let optionButtons = [Option1, Option2, Option3, Option4]
            for (index, button) in optionButtons.enumerated() {
                if index < question.options.count {
                    button?.setTitle(question.options[index], for: .normal)
                    button?.isHidden = false
                    button?.tag = index // Tag the button to identify it later
                    button?.layer.cornerRadius = 10 // Optional, for rounded corners
                    button?.backgroundColor = .systemBlue // Use your app's theme color
                    button?.setTitleColor(.white, for: .normal)
                } else {
                    button?.isHidden = true // Hide the button if there are less than four options
                }
            }
        
    }
    
    
    private func createMockData() -> [QuizQuestion] {
        let mockData1 = QuizQuestion(
            category: QuizCategory.science.description,
            question: "Which element on the periodic table is represented by the symbol 'Au'?",
            options: [
                "Silver",
                "Gold",
                "Oxygen",
                "Platinum"
            ],
            correctOptionIndex: 1
        )
        let mockData2 = QuizQuestion(
            category: QuizCategory.history.description,
            question: "Who was the first president of the United States?",
            options: [
                "Thomas Jefferson",
                "Abraham Lincoln",
                "George Washington",
                "John Adams"
            ],
            correctOptionIndex: 2
            )
        let mockData3 = QuizQuestion(
            category: QuizCategory.sports.description,
            question: "In which year were the first modern Olympic Games held?",
            options: [
                "1896",
                "1900",
                "1912",
                "1920"
            ],
            correctOptionIndex: 0
        )
        
        let mockData4 = QuizQuestion(
            category: "Tech",
            question: "Which programming language was developed by Apple Inc. for iOS and OS X development?",
            options: [
                "Swift",
                "Objective-C",
                "Ruby",
                "Java"
            ],
            correctOptionIndex: 0
        )
        return [mockData1, mockData2, mockData3]
    }
    

}
