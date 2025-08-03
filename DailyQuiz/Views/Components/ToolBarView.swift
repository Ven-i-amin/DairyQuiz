//
//  SwiftUIView.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import SwiftUI

struct ToolBarView<Content: View>: View {
    private let backButton: BackButton?;
    private let content: Content;
    
    init(
        backButton: BackButton? = nil,
        @ViewBuilder content: () -> Content,
    ) {
        self.content = content()
        self.backButton = backButton
    }
    
    var body: some View {
            ZStack {
                if let backButton = backButton {
                    backButton
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                content
            }
            .padding(.horizontal, 24)
            .padding(.top, 60)
            .background(Color("App")
                .ignoresSafeArea(edges: .top))
            .padding(.bottom, 30)
    }
}

#Preview {
    ToolBarView(backButton: BackButton(backFunc: {return})) {
        Text("Crazy hamburger")
    }
}
