//
//  QuizTry.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import Foundation

struct QuizTry: Codable {
    let quiz: Quiz
    let userAnswers: [String]
    let timestamp: Date = Date()
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case quiz, timestamp
        case userAnswers = "user_answer"
    }
}
