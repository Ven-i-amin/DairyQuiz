//
//  TestScreen.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject
    private var quizManager: QuizManager;
    
    @Binding
    private var userAnswers: [String];
    
    @State
    private var reviewFinished = false;
    
    private let backButton: BackButton;
    
    init(
        userAnswers: Binding<[String]>,
        quizManager: QuizManager,
        backButton: BackButton
    ) {
        self._userAnswers = userAnswers
        self.quizManager = quizManager
        self.backButton = backButton
    }
    
    
    var body: some View {
        ZStack {
            Color("App")
                .ignoresSafeArea()
            ScrollView {
                ToolBarView {
                    Text("Results")
                        .foregroundStyle(Color("View"))
                        .font(.system(size: 32))
                        .fontWeight(.heavy)
                }
                
                menu
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension ResultView {
    var rightQuestionCount: Int {
        quizManager.countRightAnswers(userAnswers: userAnswers)
    }
    
    var questionCount: Int {
        quizManager.getQuestionCount()
    }

    var menu: some View {
        WhiteSquareView {
            stars
                .padding(.bottom, 20)
            
            rightAnswerCount
                .padding(.bottom, 20)
            
            cheers
                .padding(.bottom, 50)
            
            DefaultButton(
                buttonAction: finishReview,
                buttonText: "StartAgain",
                isActive: true
            )
        }
    }
    
    var stars: some View {
        return HStack {
            ForEach(0..<self.rightQuestionCount, id: \.self) { _ in
                Image("Active")
                    .padding(.leading, 5)
            }
            
            ForEach(self.rightQuestionCount..<self.questionCount, id: \.self) { _ in
                Image("Unactive")
                    .padding(.leading, 5)
            }
        }
    }
    
    var rightAnswerCount: some View {
        Text(String(
            format: NSLocalizedString("QuestionCount", comment: ""),
            "\(rightQuestionCount)",
            "\(self.questionCount)"
        ))
            .foregroundStyle(Color("RatingText"))
            .font(.system(size: 16))
            .bold()
    }
    
    var cheers: some View {
        return VStack {
            Text(LocalizedStringResource("CheeringTitle\(self.rightQuestionCount)"))
                .foregroundStyle(Color("RegularText"))
                .font(.system(size: 24))
                .bold()
                .padding(.bottom, 10)
            
            Text(LocalizedStringResource("CheeringText\(self.rightQuestionCount)"))
                .font(.system(size: 16))
        }
    }
    
    private func finishReview(){
        //todo save
        backButton.backFunc()
    }
}

#Preview {
    ResultView(
        userAnswers: .constant(["incorrect1", "100"]),
        quizManager: QuizManager.previewInstance(),
        backButton: BackButton(backFunc: {return})
    )
}
