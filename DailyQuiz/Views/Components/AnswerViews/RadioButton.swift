//
//  RadioButton.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import SwiftUI

struct RadioButton: View, Hashable {
    private var id = UUID();
    
    public let buttonState: AnswerView.States;
    
    @Binding
    private var selectedAnswer: String;
    
    private let text: String;
    
    init(text: String, selectedAnswer: Binding<String>, buttonState: AnswerView.States) {
        self.text = text
        self._selectedAnswer = selectedAnswer
        self.buttonState = buttonState;
    }
    
    var body: some View {
        switch buttonState {
        case .unselected, .right, .wrong:
            Button(action: select) {
                AnswerView(text: text, buttonState: buttonState)
            }
            .buttonStyle(PlainButtonStyle())
        case .selected:
            AnswerView(text: text, buttonState: buttonState)
        }
    }
    
    // MARK: - Functions
    
    private func select(){
        selectedAnswer = text
    }
    
    // MARK: - Hashable
    
    static func == (lhs: RadioButton, rhs: RadioButton) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedAnswer = ""

        var body: some View {
            RadioButton(text: "test", selectedAnswer: $selectedAnswer, buttonState: AnswerView.States.unselected)
        }
    }

    return PreviewWrapper()
}
