//
//  HistoryManager.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import Foundation

class HistoryManager: ObservableObject, Identifiable, Hashable {
    // MARK: - Properties
    var id = UUID();
    
    @Published
    var userHistory: UserHistory?;
    
    init(userHistory: UserHistory? = nil) {
        guard userHistory != nil else {
            loadHistory()
            return
        }
        self.userHistory = userHistory!
    }
    
    // MARK: - Manager to Service
    
    func createUserHistory() {
        userHistory = HistoryService.create()
    }
    
    func saveHistory() {
        guard let userHistory = userHistory else { return }
        HistoryService.save(userHistory: userHistory)
    }
    
    func loadHistory() {
        userHistory = HistoryService.load()
    }
    
    // MARK: - Managment
    func addQuizTry(quizTry: QuizTry) {
        guard userHistory != nil else { return }
        userHistory!.quizTries.append(quizTry)
    }
    
    func getQuizTries() -> [QuizTry]{
        return userHistory?.quizTries ?? []
    }
    
    func getQuizManager(index: Int) -> QuizManager{
        guard userHistory != nil else {
            return QuizManager()
        }
        
        return QuizManager(quiz: userHistory?.quizTries[index].quiz)
    }
    
    func getUserAnswers(index: Int) -> [String] {
        return userHistory?.quizTries[index].userAnswers ?? []
    }
    
    func getTime(index: Int) -> Date? {
        return userHistory?.quizTries[index].timestamp ?? nil
    }
    
    func isNotEmpty() -> Bool{
        return userHistory != nil
    }
    
    func quizCount() -> Int{
        return userHistory?.quizTries.count ?? 0;
    }
    
    // MARK: - Hashable
    
    static func == (lhs: HistoryManager, rhs: HistoryManager) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension HistoryManager {
    static func previewInstance() -> HistoryManager {
        let manager = HistoryManager()
        
        var userH = UserHistory()
        
        userH.quizTries = [
            QuizTry(
                quiz: Quiz(
                    id: 1,
                    results: [
                        Question(
                            type: "multiple",
                            difficulty: "easy",
                            category: "Geography",
                            question: "What is the capital of France?",
                            correctAnswer: "Paris",
                            incorrectAnswers: ["London", "Berlin", "Rome"]
                        ),
                        Question(
                            type: "multiple",
                            difficulty: "medium",
                            category: "Science",
                            question: "What planet is known as the Red Planet?",
                            correctAnswer: "Mars",
                            incorrectAnswers: ["Venus", "Saturn", "Jupiter"]
                        ),
                        Question(
                            type: "multiple",
                            difficulty: "easy",
                            category: "History",
                            question: "Who was the first president of the United States?",
                            correctAnswer: "George Washington",
                            incorrectAnswers: ["Abraham Lincoln", "Thomas Jefferson", "John Adams"]
                        )
                    ]
                ),
                userAnswers: ["Paris", "Venus", "George Washington"]
            ),
            QuizTry(
                quiz: Quiz(
                    id: 2,
                    results: [
                        Question(
                            type: "multiple",
                            difficulty: "medium",
                            category: "Literature",
                            question: "Who wrote '1984'?",
                            correctAnswer: "George Orwell",
                            incorrectAnswers: ["Aldous Huxley", "Ray Bradbury", "Ernest Hemingway"]
                        ),
                        Question(
                            type: "multiple",
                            difficulty: "hard",
                            category: "Math",
                            question: "What is the derivative of sin(x)?",
                            correctAnswer: "cos(x)",
                            incorrectAnswers: ["-cos(x)", "-sin(x)", "tan(x)"]
                        ),
                        Question(
                            type: "multiple",
                            difficulty: "easy",
                            category: "Movies",
                            question: "Who directed 'Jurassic Park'?",
                            correctAnswer: "Steven Spielberg",
                            incorrectAnswers: ["James Cameron", "Tim Burton", "George Lucas"]
                        )
                    ]
                ),
                userAnswers: ["George Orwell", "cos(x)", "Steven Spielberg"]
            )
        ]
        
        manager.userHistory = userH;
        
        return manager
    }
}
