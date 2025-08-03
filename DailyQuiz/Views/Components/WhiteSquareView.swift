//
//  ContentView.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 02.08.2025.
//

import SwiftUI

struct WhiteSquareView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 32)
        .padding(.bottom, 32)
        .padding(.leading, 24)
        .padding(.trailing, 24)
        .background(Color("View"))
        .containerShape(RoundedRectangle(cornerRadius: 46))
        .padding(.top, 32)
        .padding(.bottom, 32)
        .padding(.leading, 24)
        .padding(.trailing, 24)
    }
}
