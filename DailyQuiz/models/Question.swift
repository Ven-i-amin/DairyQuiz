//
//  Question.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import Foundation

public class Question{
    let questionText: String;
    let variants: [Variant];
    
    init(questionText: String, variants: [Variant]) {
        self.questionText = questionText
        self.variants = variants
    }
}
