//
//  MainMenu.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        title
        Spacer()
            .background(Color.red)
        .padding(.top, 20);
        
    }
}

extension MainMenu {
    var title: some View {
        VStack {
            Text("DailyQuiz✏️")
                .font(.system(size: 50))
        }
    }
}

#Preview {
    MainMenu()
}
