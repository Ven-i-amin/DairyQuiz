//
//  Case.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

class Variant {
    let name: String;
    let rightAnswer: Bool;
    let description: String;
    
    init(name: String, rightAnswer: Bool, description: String) {
        self.name = name;
        self.rightAnswer = rightAnswer;
        self.description = description;
    }
}
