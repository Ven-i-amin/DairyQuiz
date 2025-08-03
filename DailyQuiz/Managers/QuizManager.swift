//
//  QuizManager.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 02.08.2025.
//

import Foundation

class QuizManager: ObservableObject, Identifiable, Hashable {
    var id = UUID();
    
    @Published
    var quiz: Quiz?;
    
    init(quiz: Quiz? = nil) {
        self.quiz = quiz
    }
    
    public func getAllQuestionAnswers(index: Int) -> [String] {
        if (index < 0 || quiz!.results.count < index) {
            return []
        }
        
        var arr: [String] = []
        
        arr.append(quiz!.results[index].correctAnswer)
        arr.append(contentsOf: quiz!.results[index].incorrectAnswers)
        
        return arr;
    }
    
    public func getQuestionText(index: Int) -> String {
        return quiz?.results[index].question ?? "";
    }
    
    public func getQuestionCount() -> Int {
        return quiz?.results.count ?? 0;
    }
    
    public func countRightAnswers(userAnswers: [String]) -> Int {
        var count = 0
        for i in 0..<min(userAnswers.count, getQuestionCount()) {
            if userAnswers[i] == quiz!.results[i].correctAnswer {
                count += 1
            }
        }
        return count
    }
    
    // MARK: - Hashable
    
    static func == (lhs: QuizManager, rhs: QuizManager) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension QuizManager {
    // MARK: - Make preview working
    
    static func previewInstance() -> QuizManager {
        return QuizManager(quiz: Quiz(
            id: 0,
            results: [
                Question(
                    type: "multiple",
                    difficulty: "easy",
                    category: "General Knowledge",
                    question: "text of your question",
                    correctAnswer: "correct",
                    incorrectAnswers: ["incorrect1", "incorrect2", "incorrect3"]
                ),
                Question(
                    type: "multiple",
                    difficulty: "medium",
                    category: "Science",
                    question: "What is the boiling point of water?",
                    correctAnswer: "100",
                    incorrectAnswers: ["90", "80", "70"]
                )
            ]
        ))
    }
}
