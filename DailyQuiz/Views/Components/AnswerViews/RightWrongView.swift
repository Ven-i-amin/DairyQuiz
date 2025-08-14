//
//  RightWrongList.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import SwiftUI

struct RightWrongView: View {
    private let answersTexts: [String]
    private let userAnswer: String;
    private let rightAnswered: Bool;
    
    init(userAnswer: String,
         rightAnswered: Bool,
         answersTexts: [String]) {
        self.userAnswer = userAnswer;
        self.rightAnswered = rightAnswered;
        self.answersTexts = answersTexts;
    }
    
    var body: some View {
        VStack {
            ForEach(answersTexts, id:\.self) { text in
                AnswerView(
                    text: text,
                    buttonState: setState(text: text))
            }
        }
    }
    
    private func setState(text: String) -> AnswerView.States {
        if (text != userAnswer) {
            return AnswerView.States.unselected
        }
        
        if (rightAnswered) {
            return AnswerView.States.right
        } else {
            return AnswerView.States.wrong
        }
    }
    
}

#Preview {
    RightWrongView(
        userAnswer: "4",
        rightAnswered: true,
        answersTexts: ["1", "2", "3", "4"]
    )
}
