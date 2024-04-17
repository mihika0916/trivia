//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import Foundation
extension String {
    var temp: NSAttributedString? {
        guard let data = data(using: .utf8) else {return nil}
        return try? NSAttributedString(data: data, options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding:String.Encoding.utf8.rawValue
        ],
                                       documentAttributes:nil)
    }
    var htmlToString: String {
        return temp?.string ?? ""
    }
}



struct TriviaQuestion : Decodable{
    let type: String
    let difficulty: String
    let categoryRaw: String
    var category: String {
        categoryRaw.htmlToString
    }
    
    let questionRaw: String
    var question: String {
        questionRaw.htmlToString
    }
    
    let correctAnswerRaw: String
    var correctAnswer: String {
        correctAnswerRaw.htmlToString
    }
    
    let incorrectAnswersRaw: [String]
    var incorrectAnswers: [String] {
        incorrectAnswersRaw.map { $0.htmlToString }
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case difficulty = "difficulty"
        case categoryRaw = "category"
        case questionRaw = "question"
        case correctAnswerRaw = "correct_answer"
        case incorrectAnswersRaw = "incorrect_answers"
    }
    
    
    
}


