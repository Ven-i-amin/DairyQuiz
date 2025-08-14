//
//  QuizMarkView.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import SwiftUI

struct QuizMarkView <Content: View>: View {
    @ObservedObject
    var quizManager: QuizManager;
    
    private let userAnswers: [String];
    private let content: Content;

    init(
        quizManager: QuizManager,
        userAnswers: [String],
        @ViewBuilder content: () -> Content,
    ) {
        self.content = content();
        self.quizManager = quizManager
        self.userAnswers = userAnswers
    }
    
    var body: some View {
        WhiteSquareView {
            StarsView(
                quizManager: quizManager,
                userAnswers: userAnswers,
                starGap: 5
            )
            .frame(height: 52)
            .fixedSize()
            .padding(.bottom, 20)
            
            rightAnswerCount
                .padding(.bottom, 20)
            
            cheers
            
            content
        }
    }
    
    private var rightQuestionCount: Int {
        quizManager.countRightAnswers(userAnswers: userAnswers)
    }
    
    private var questionCount: Int {
        quizManager.getQuestionCount()
    }
    
    var rightAnswerCount: some View {
        Text(String(
            format: NSLocalizedString("QuestionCount", comment: ""),
            "\(rightQuestionCount)",
            "\(questionCount)"
        ))
        .foregroundStyle(Color("RatingText"))
        .font(.system(size: 16))
        .bold()
    }
    
    var cheers: some View {
        let cheeringTitle = "CheeringTitle\(rightQuestionCount)"
        let cheeringText = "CheeringText\(rightQuestionCount)"
        
        return VStack {
            Text(LocalizedStringKey(cheeringTitle))
                .foregroundStyle(Color("RegularText"))
                .font(.system(size: 24))
                .bold()
                .padding(.bottom, 10)
            
            Text(LocalizedStringKey(cheeringText)
            )
                .foregroundStyle(Color("RegularText"))
                .font(.system(size: 16))
        }
    }
}
