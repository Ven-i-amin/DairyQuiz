//
//  Navigation.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

enum Navigation: Hashable {
    case quiz
    case history
    case result
    case review(quizNumber: Int)
}
