//
//  Button.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 02.08.2025.
//

import SwiftUI

struct DefaultButton: View {
    private let buttonAction: () -> Void;
    private let buttonText: String;
    private let isActive: Bool;
    
    init(buttonAction: @escaping () -> Void, buttonText: String, isActive: Bool) {
        self.buttonAction = buttonAction
        self.buttonText = buttonText
        self.isActive = isActive
    }
    
    var body: some View {
        let backgroundColor = Color(isActive ? "Active" : "Unactive")
        
        Button(action: buttonAction) {
            VStack {
                Text(LocalizedStringKey(buttonText))
                    .fontWeight(.heavy)
                    .textCase(.uppercase)
            }
            .foregroundColor(Color("View"))
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(backgroundColor)
            .containerShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
