//
//  QuizManager.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 02.08.2025.
//

import Foundation

class QuizManager: ObservableObject, Identifiable, Hashable {
    var id = UUID();
    @Published var quiz: Quiz?
    
    public func getAllQuestions(index: Int) -> [String] {
        if (index < 0 || (quiz?.results.count)! < index) {
            return []
        }
        
        var arr: [String] = []
        
        arr.append((quiz?.results[0].correctAnswer)!)
        arr.append(contentsOf: (quiz?.results[0].incorrectAnswers)!)
        
        return arr;
    }
    
    public func getQuestionCount() -> Int {
        return (quiz?.results.count)!;
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
        let manager = QuizManager()
        manager.quiz = Quiz(
            id: 0,
            results: [
                Question(
                    type: "multiple",
                    difficulty: "easy",
                    category: "General Knowledge",
                    question: "What is 2 + 2?",
                    correctAnswer: "4",
                    incorrectAnswers: ["3", "5", "22"]
                )
            ]
        )
        return manager
    }
}
