//
//  UserHistory.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import Foundation

struct UserHistory: Codable {
    var quizTries: [QuizTry]
    
    init(quizTries: [QuizTry]? = nil) {
        guard quizTries != nil else {
            self.quizTries = []
            return
        }
        self.quizTries = quizTries!
    }
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case quizTries = "quiz_tries"
    }
}
