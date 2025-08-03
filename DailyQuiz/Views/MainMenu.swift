//
//  MainMenu.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import SwiftUI

struct MainMenu: View {
    @State
    private var showMenu = true;
    
    @State
    private var failedGetQuiz = false;
    
    @State
    private var startQuiz = false;
    
    @StateObject
    private var quizManager: QuizManager = QuizManager();
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("App")
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        if showMenu {
                            history
                        } else {
                            history
                                .hidden()
                        }
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    LogoView()
                        .padding(.bottom, 30)
                        .padding(.leading, 48)
                        .padding(.trailing, 48)
                    
                    ZStack {
                        if showMenu {
                            menu
                        } else {
                            menu
                                .hidden()
                            
                            Image("Loader")
                        }
                    }
                    .padding(.bottom, 50)
                    
                    if failedGetQuiz {
                        Text("FailedQuiz")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(Color("View"))
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

extension MainMenu {
    
    var history: some View {
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
    
    var menu: some View {
        WhiteSquareView {
            Text("Welcome")
                .font(.system(size: 32))
                .bold()
                .multilineTextAlignment(.center)
            
            DefaultButton(
                buttonAction: startAction,
                buttonText: "Start",
                isActive: true
            )
            .padding(5)
            .navigationDestination(
                isPresented: $startQuiz,
                destination: {
                    QuizView(
                        quizManager: quizManager,
                        backButton: BackButton(backFunc: resetStates)
                    )
                }
            )
        }
        
    }
    
    // MARK: - State control
    
    private func startAction() {
        showMenu = false
        
        Network.getQuiz(
            failGetFunc: failGetQuiz,
            successGetFunc: successGetQuiz
        )
    }
    
    private func resetStates() {
        showMenu = true
        failedGetQuiz = false
    }
    
    private func failGetQuiz(){
        failedGetQuiz = true
        showMenu = true
    }
    
    private func successGetQuiz(quiz: Quiz){
        quizManager.quiz = quiz
        startQuiz = true
    }
}

#Preview {
    MainMenu()
}
