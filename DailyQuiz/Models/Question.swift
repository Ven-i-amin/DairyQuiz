//
//  Question.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import Foundation

struct Question: Codable, Hashable {
    let id = UUID()
    let type: String;
    let difficulty: String;
    let category: String;
    let question: String;
    let correctAnswer: String;
    let incorrectAnswers: [String];
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    // MARK: - Hashable
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(category)
        hasher.combine(question)
        hasher.combine(correctAnswer)
        hasher.combine(incorrectAnswers)
    }
}
