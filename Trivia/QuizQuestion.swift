//
//  QuizQuestion.swift
//  Trivia
//
//  Created by Mihika Sharma on 10/03/24.
//

import Foundation


struct QuizQuestion {
    let category: String
    let question: String
    let options: [String]
    let correctOptionIndex: Int

    var correctOption: String {
        return options[correctOptionIndex]
    }

    func isCorrect(option: String) -> Bool {
        return option == correctOption
    }
}

enum QuizCategory: String {
    case tech = "Tech"
    case sports = "Sports"
    case history = "History"
    case science = "Science"

    // Computed property to return a user-friendly description.
    var description: String {
        switch self {
        case .tech:
            return "Technology"
        case .sports:
            return "Sports"
        case .history:
            return "History"
        case .science:
            return "Science"
        }
    }
}

// Example of using QuizQuestion with QuizCategory
let sampleQuestion = QuizQuestion(
    category: QuizCategory.tech.description,
    question: "What was the first weapon pack for 'PAYDAY'?",
    options: [
        "The Gage Weapon Pack #1",
        "The Overkill Pack",
        "The Gage Chivalry Pack",
        "The Gage Historical Pack"
    ],
    correctOptionIndex: 0
)

