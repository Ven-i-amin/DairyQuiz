//
//  Question.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import Foundation

struct Question: Codable {
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
}
