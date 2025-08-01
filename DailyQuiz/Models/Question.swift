//
//  Question.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import Foundation

public class Question{
    let type: String;
    let difficulty: String;
    let category: String;
    let question: String;
    let correctAnswer: String;
    let incorrectAnswers: [String];
    
    init(type: String, difficulty: String, category: String, question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.type = type
        self.difficulty = difficulty
        self.category = category
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}
