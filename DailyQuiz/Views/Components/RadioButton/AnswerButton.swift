//
//  SwiftUIView.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 02.08.2025.
//

import SwiftUI

struct AnswerButton: View, Hashable {
    // MARK: - Properties
    public enum States {
        case unselected
        case selected
        case right
        case wrong
    }
    
    private var id = UUID();
    
    private let buttonState: States;
    
    @Binding
    private var selectedAnswer: String;
    
    private let text: String;

    init(text: String, selectedAnswer: Binding<String>, buttonState: States) {
        self.text = text
        self._selectedAnswer = selectedAnswer
        self.buttonState = buttonState;
    }
    
    // MARK: - Body
    var body: some View {
        switch (buttonState) {
        case .unselected:
            unselectedButton
        case .selected:
            selectedButton
        case .right:
            rightButton
        case .wrong:
            wrongButton
        }
    }
    
    // MARK: - Unselected Button View
    private var unselectedButton: some View {
        Button(action: select) {
            HStack {
                Image("Radio/Default")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                
                Text(LocalizedStringResource(stringLiteral: text))
                    .font(.system(size: 14))
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(5)
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(Color("RegularText"))
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color("Default"))
        .containerShape(RoundedRectangle(cornerRadius: 16))
    }
    
    // MARK: - Selected Button View
    private var selectedButton: some View {
        ZStack {
            HStack {
                Image("Radio/Selected")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                
                Text(LocalizedStringResource(stringLiteral: text))
                    .font(.system(size: 14))
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(5)
        }
        .foregroundColor(Color("Selected"))
        .frame(maxWidth: .infinity)
        .padding(16)
        .containerShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("Selected"), lineWidth: 1)
        )
    }
    
    // MARK: - Right Button View
    private var rightButton: some View {
        ZStack {
            HStack {
                Image("Radio/Right")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                
                Text(LocalizedStringResource(stringLiteral: text))
                    .font(.system(size: 14))
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(5)
        }
        .foregroundColor(Color("Right"))
        .frame(maxWidth: .infinity)
        .padding(16)
        .containerShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("Right"), lineWidth: 1)
        )
    }
    
    // MARK: - Wrong Button View
    private var wrongButton: some View {
        ZStack {
            HStack {
                Image("Radio/Wrong")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                Text(LocalizedStringResource(stringLiteral: text))
                    .font(.system(size: 14))
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(5)
        }
        .foregroundColor(Color("Wrong"))
        .frame(maxWidth: .infinity)
        .padding(16)
        .containerShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("Wrong"), lineWidth: 1)
        )
    }
    
    // MARK: - Functions
    
    private func select(){
        selectedAnswer = text
    }
    
    // MARK: - Hashable

    static func == (lhs: AnswerButton, rhs: AnswerButton) -> Bool {
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
            AnswerButton(text: "test", selectedAnswer: $selectedAnswer, buttonState: AnswerButton.States.unselected)
        }
    }

    return PreviewWrapper()
}
