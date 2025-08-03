//
//  TestAnswering.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import SwiftUI

struct QuizView: View {
    
    @ObservedObject
    private var quizManager: QuizManager;
    
    @State
    private var selectedAnswer = "";
    
    private let backButton: BackButton;
    
    @State private var questionIndex = 1;
    
    private let questionCount: Int;
    
    init(quizManager: QuizManager, backButton: BackButton) {
        self.quizManager = quizManager
        self.backButton = backButton
        
        self.questionCount = quizManager.getQuestionCount()
    }
    
    var body: some View {
        ZStack {
            Color("App")
                .ignoresSafeArea()
            
            VStack {
                menu
                
                Text("CantReturn")
                    .foregroundStyle(Color("View"))
                    .font(.system(size: 10))
            }
        }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
    }
}

extension QuizView {
    var menu: some View {
        WhiteSquareView {
            Text("QuestionCount")
            
            Text("Question")
            
//            RadioButton(
//                answersTexts: quizManager.getAllQuestions(index: questionIndex - 1),
//            selectedAnswer: $selectedAnswer)
            
            RadioButton(
                answersTexts: ["1", "2", "3", "4"],
            selectedAnswer: $selectedAnswer
            )
            
            if isFinalQuestion() {
                DefaultButton(
                    buttonAction: finishQuiz,
                    buttonText: "Finish",
                    isActive: selectedAnswer != "")
            } else {
                DefaultButton(
                    buttonAction: nextQuestion,
                    buttonText: "Next",
                    isActive: selectedAnswer != "")
            }
        }
    }
    
    private func isFinalQuestion() -> Bool{
        return questionCount == questionIndex;
    }
    
    private func nextQuestion() {
        questionIndex += 1
    }
    
    private func finishQuiz() {
        //todo
    }
}

#Preview {
    QuizView(
        quizManager: QuizManager.previewInstance(),
        backButton: BackButton(backFunc: {return})
    )
}
