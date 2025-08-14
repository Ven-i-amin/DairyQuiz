//
//  StarsView.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import SwiftUI

struct StarsView: View {
    @ObservedObject
    var quizManager: QuizManager;
    
    private let userAnswers: [String];
    
    private let leadingPadding: CGFloat;
    
    init(quizManager: QuizManager, userAnswers: [String], starGap: CGFloat = 5) {
        self.quizManager = quizManager;
        self.userAnswers = userAnswers;
        self.leadingPadding = starGap;
    }
    
    var body: some View {
        let questionCount = quizManager.getQuestionCount()
        let rightQuestionCount = quizManager.countRightAnswers(userAnswers: userAnswers)
        
        HStack {
            ForEach(0..<rightQuestionCount, id: \.self) { _ in
                Image("Active")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, leadingPadding)
            }
            
            ForEach(rightQuestionCount..<questionCount, id: \.self) { _ in
                Image("Unactive")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, leadingPadding)
            }
        }
    }
}

//#Preview {
//    StarsView()
//}
