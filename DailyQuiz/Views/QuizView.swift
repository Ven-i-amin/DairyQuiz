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
    
    @Binding
    private var userAnswers: [String];
    
    @Binding
    private var path: NavigationPath;
    
    @State
    private var selectedAnswer = "";
    
    @State
    private var questionIndex = 1;
    
    private let questionCount: Int;
    
    init (
        quizManager: QuizManager,
        userAnswers: Binding<[String]>,
        path: Binding<NavigationPath>
    ) {
        self.quizManager = quizManager
        self.questionCount = quizManager.getQuestionCount()
        self._userAnswers = userAnswers
        self._path = path
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("App")
                .ignoresSafeArea()
            
            ScrollView {
                ToolBarView(backButton: BackButton(
                    backFunc: ViewTransition.returnToLastScreen(path: $path)
                )) {
                    LogoView()
                        .frame(width: 180)
                        .fixedSize()
                }
                
                VStack {
                    Spacer()
                    
                    questionAnswer
                        .padding(10)
                    
                    miniText
                }
                .padding(.bottom, 100)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension QuizView {
    var questionAnswer: some View {
        WhiteSquareView {
            VStack {
                questionCounter
                    .padding(.bottom, 10)
                
                questionText
                    .padding(.bottom, 10)
                
                RadioView(
                    answersTexts: quizManager.getAllQuestionAnswers(
                        index: questionIndex - 1
                    ),
                    selectedAnswer: $selectedAnswer
                )
            }
            .padding(.bottom, 50)
            
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
    
    var questionCounter: some View {
        Text(String(
            format: NSLocalizedString("QuestionCount", comment: ""),
            "\(questionIndex)",
            "\(questionCount)"
        ))
        .foregroundColor(Color("QuestionCount"))
        .font(.system(size:16))
        .bold()
    }
    
    var questionText: some View {
        Text(quizManager.getQuestionText(
            index: questionIndex - 1
        ))
        .foregroundColor(Color("RegularText"))
        .font(.system(size: 18))
        .bold()
        .multilineTextAlignment(.center)
        .lineLimit(nil)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var miniText: some View {
        Text("CantReturn")
            .foregroundStyle(Color("View"))
            .font(.system(size: 10))
    }
    
    private func isFinalQuestion() -> Bool{
        return questionCount == questionIndex;
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        userAnswers.append(selectedAnswer)
        
        selectedAnswer = ""
    }
    
    private func finishQuiz() {
        userAnswers.append(selectedAnswer)
        
        path.append(Navigation.result)
    }
    
    private func returnBack() {
    }
}

#Preview {
    QuizView(
        quizManager: QuizManager.previewInstance(),
        userAnswers: .constant([]),
        path: .constant(NavigationPath())
    )
}
