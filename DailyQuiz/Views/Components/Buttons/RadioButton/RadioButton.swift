//
//  SwiftUIView.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 02.08.2025.
//

import SwiftUI

struct RadioButton: View {
    @Binding
    private var selectedAnswer: String;
    private var answersTexts: [String]
    
    init(answersTexts: [String], selectedAnswer: Binding<String>) {
        self.answersTexts = answersTexts;
        self._selectedAnswer = selectedAnswer;
    }
    
    var body: some View {
        VStack {
            ForEach(answersTexts, id:\.self) { text in
                AnswerButton(
                    text: text,
                    selectedAnswer: $selectedAnswer,
                    buttonState: text == selectedAnswer ? AnswerButton.States.selected : AnswerButton.States.unselected)
            }
            }
        }
    }

#Preview {
    @Previewable @State var selectedAnswer = ""
    return RadioButton(answersTexts: ["1", "2", "3", "4"], selectedAnswer: $selectedAnswer)
}
