//
//  QuizManager.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 02.08.2025.
//

import Foundation

class QuizManager: ObservableObject, Identifiable, Hashable {
    // MARK: - Properties
    var id = UUID();
    
    @Published
    var quiz: Quiz?;
    
    init(quiz: Quiz? = nil) {
        self.quiz = quiz
    }
    
    // MARK: - Manager to Service
    
    func loadQuiz(byCompletion: @escaping (Quiz?) -> Void) {
        QuizService.get(completion: { quiz in
            self.setQuiz(quiz: quiz)
            byCompletion(quiz)
        })
    }
    
    // MARK: - Managment
    func setQuiz(quiz: Quiz?) {
        self.quiz = quiz
    }
    
    func getAllQuestionAnswers(index: Int) -> [String] {
        guard let quiz = self.quiz else {
            return [];
        }
        
        return Self.getAllQuestionAnswers(
            index: index,
            quiz: quiz
        )
    }
    
    func getQuestionText(index: Int) -> String {
        return quiz?.results[index].question ?? "";
    }
    
    func getCorrectAnswer(index: Int) -> String {
        return quiz?.results[index].correctAnswer ?? "";
    }
    
    func getQuestionCount() -> Int {
        return quiz?.results.count ?? 0;
    }
    
    func countRightAnswers(userAnswers: [String]) -> Int {
        var count = 0
        for i in 0..<min(userAnswers.count, getQuestionCount()) {
            if userAnswers[i] == quiz!.results[i].correctAnswer {
                count += 1
            }
        }
        return count
    }
    
    // MARK: - static
    
    static func getAllQuestionAnswers(index: Int, quiz: Quiz) -> [String] {
        if (index < 0 || quiz.results.count < index) {
            return []
        }
        
        var arr: [String] = []
        
        arr.append(quiz.results[index].correctAnswer)
        arr.append(contentsOf: quiz.results[index].incorrectAnswers)
        
        return arr.sorted {
            ($0.hashValue) < ($1.hashValue)
        }
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
    // MARK: - Preview
    
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
