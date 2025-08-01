//
//  TestStatistic.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import Foundation

class Quiz {
    let name: String;
    let questions: [Question];
    
    var rightAnswersNumber: Int?
    var time: TimeInterval?
    
    init(name: String, questions: [Question]) {
        self.name = name
        self.questions = questions
    }
}
