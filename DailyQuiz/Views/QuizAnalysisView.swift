//
//  QuizAnalysisView.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import SwiftUI

struct QuizAnalysisView: View {
    @Binding
    var path: NavigationPath;
    
    private var quizManager: QuizManager;
    private var userAnswers: [String];
    
    init(
        quizManager: QuizManager,
        userAnswers: [String],
        path: Binding<NavigationPath>
    ) {
        self.quizManager = quizManager
        self.userAnswers = userAnswers
        self._path = path
    }
    
    var body: some View {
        ZStack {
            Color("App")
                .ignoresSafeArea()
            
            ScrollView {
                ToolBarView(backButton: BackButton(backFunc: ViewTransition.returnToMainPage(path: $path))) {
                    Text("Results")
                        .foregroundStyle(Color("View"))
                        .font(.system(size: 32))
                        .fontWeight(.heavy)
                }
                
                QuizMarkView(
                    quizManager: quizManager,
                    userAnswers: userAnswers,
                ) {
                    
                }
                .padding(.bottom, 50)
                
                Text("YourAnswers")
                    .foregroundStyle(Color("View"))
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                    .padding(.bottom, 30)
                
                ForEach(0..<quizManager.getQuestionCount(), id: \.self) { index in
                    
                    question(index: index)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func isRightAnswered(index: Int) -> Bool {
        return userAnswers[index] == quizManager.getCorrectAnswer(index: index)
    }
}

extension QuizAnalysisView{
    func question(index: Int) -> some View {
        WhiteSquareView {
            HStack {
                Text(String(
                    format: NSLocalizedString("QuestionCount", comment: ""),
                    "\(index + 1)",
                    "\(quizManager.getQuestionCount())"
                ))
                .foregroundColor(Color("Unactive"))
                .font(.system(size:16))
                .bold()
                
                Spacer()
                
                Image(isRightAnswered(index: index) ?
                      "Radio/Right" : "Radio/Wrong")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
            }
            .padding(.bottom, 30)
            
            Text(quizManager.getQuestionText(index: index))
                .foregroundStyle(Color("RegularText"))
                .font(.system(size: 18))
                .bold()
                .padding(.bottom, 20)
            
            RightWrongView(
                userAnswer: userAnswers[index],
                rightAnswered: isRightAnswered(index: index),
                answersTexts: quizManager.getAllQuestionAnswers(index: index))
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    QuizAnalysisView(
        quizManager:
            QuizManager.previewInstance()
        , userAnswers: ["incorrect3", "100"],
        path: .constant(NavigationPath())
    )
}
