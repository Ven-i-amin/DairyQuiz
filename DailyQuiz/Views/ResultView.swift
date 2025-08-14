//
//  TestScreen.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject
    var historyManager: HistoryManager;
    
    @ObservedObject
    private var quizManager: QuizManager;
    
    @Binding
    private var userAnswers: [String];
    
    @Binding
    private var path: NavigationPath;
    
    @State
    private var reviewFinished = false;
    
    init(
        userAnswers: Binding<[String]>,
        quizManager: QuizManager,
        path: Binding<NavigationPath>
    ) {
        self._userAnswers = userAnswers
        self.quizManager = quizManager
        self._path = path
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
                
                QuizMarkView(
                    quizManager: quizManager,
                    userAnswers: userAnswers,
                ) {
                    DefaultButton(
                        buttonAction: finishReview,
                        buttonText: "StartAgain",
                        isActive: true
                    )
                    .padding(.top, 50)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            addQuizToHistory()
        }
    }
    
    private func addQuizToHistory(){
        guard let quiz = quizManager.quiz else {
            return
        }
        
        guard historyManager.userHistory != nil else {
            historyManager.createUserHistory()
            return
        }
        
        historyManager.addQuizTry(
            quizTry:
                QuizTry(
                    quiz: quiz,
                    userAnswers: userAnswers
                )
        )
    }
    
    private func finishReview(){
        ViewTransition.returnToMainPage(path: $path)()
    }
}

#Preview {
    ResultView(
        userAnswers: .constant(["incorrect1", "100"]),
        quizManager: QuizManager.previewInstance(),
        path: .constant(NavigationPath())
    ).environmentObject(HistoryManager.previewInstance())
}
