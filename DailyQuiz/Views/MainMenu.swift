//
//  MainMenu.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import SwiftUI

struct MainMenu: View {
    @EnvironmentObject
    var historyManager: HistoryManager;
    
    @State
    private var showMenu = true;
    
    @State
    private var failedGetQuiz = false;
    
    @State
    private var path = NavigationPath()
    
    @State
    private var userAnswers: [String] = []
    
    @StateObject
    private var quizManager: QuizManager = QuizManager();
    
    var body: some View {
        return NavigationStack(path: $path) {
            ZStack {
                Color("App")
                    .ignoresSafeArea()
                
                VStack {
                    historyShow
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    LogoView()
                        .padding(.bottom, 30)
                        .padding(.leading, 48)
                        .padding(.trailing, 48)
                    
                    menuShow
                        .padding(.bottom, 50)
                    
                    Spacer()
                }
                
                
            }
            .navigationDestination(for: Navigation.self) { screen in
                switch screen {
                case .quiz:
                    QuizView(
                        quizManager: quizManager,
                        userAnswers: $userAnswers,
                        path: $path
                    )
                case .history:
                    HistoryView(
                        path: $path
                    )
                case .result:
                    ResultView(
                        userAnswers: $userAnswers,
                        quizManager: quizManager,
                        path: $path
                    )
                case .review(let quizNumber):
                    QuizAnalysisView(
                        quizManager:
                            historyManager
                            .getQuizManager(index: quizNumber),
                        userAnswers:
                            historyManager
                            .getUserAnswers(index: quizNumber),
                        path: $path
                    )
                }
            }
            .onAppear() {
                resetStates()
            }
        }
    }
}

extension MainMenu {
    
    var history: some View {
        Button(action: { path.append(Navigation.history) }) {
            HStack {
                Text("History")
                    .bold()
                Image("History")
            }
            .foregroundColor(Color("App"))
            .padding(12)
            .background(Color("View"))
            .containerShape(RoundedRectangle(cornerRadius: 24))
        }
        .disabled(!showMenu)
    }
    
    var menu: some View {
        WhiteSquareView {
            Text("Welcome")
                .foregroundStyle(Color("RegularText"))
                .font(.system(size: 32))
                .bold()
                .multilineTextAlignment(.center)
            
            DefaultButton(
                buttonAction: {
                    showMenu = false
                    quizManager.loadQuiz { quiz in
                        guard quiz != nil else {
                            failGetQuiz()
                            return
                        }
                        path.append(Navigation.quiz)
                    }
                },
                buttonText: "Start",
                isActive: true
            )
            .padding(5)
        }
        
    }
    
    var historyShow: some View {
        ZStack {
            if showMenu {
                history
            } else {
                history
                    .hidden()
            }
        }
    }
    
    var menuShow: some View {
        ZStack {
            if showMenu {
                menu
            } else {
                menu
                    .hidden()
                
                Image("Loader")
            }
        }
    }
    
    // MARK: - State control
    
    private func resetStates() {
        showMenu = true
        failedGetQuiz = false
    }
    
    private func failGetQuiz(){
        failedGetQuiz = true
        showMenu = true
    }
}

#Preview {
    MainMenu()
}
