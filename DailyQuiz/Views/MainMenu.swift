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
    
    @StateObject
    public var quizManager = QuizManager();
    
    @State
    private var startQuiz = false;
    
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
                    
                    logo
                        .padding(.bottom, 30)
                    
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
        .onAppear() {
            resetStates()
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=5&type=multiple&category=9&difficulty=easy") else {
            print("url error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                failedGet()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("response error")
                failedGet()
                return
            }
            
            guard let data = data else {
                print("data error")
                failedGet()
                return
            }
            
            do {
                quizManager.quiz = try JSONDecoder().decode(Quiz.self, from: data)
                print(quizManager.quiz?.id as Any)
                
                startQuiz = true;
            } catch {
                print(error)
                failedGet()
            }
        }.resume()
    }
    
    private func failedGet(){
        failedGetQuiz = true
        showMenu = true
    }
}

extension MainMenu {
    var logo: some View {
        VStack{
            Image("Logo")
        }
    }
    
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
                    );
                }
            )
        }
        
    }
    
    func startAction() {
        showMenu = false
        fetchData()
    }
    
    private func resetStates() {
        showMenu = true;
        failedGetQuiz = false;
    }
}

#Preview {
    MainMenu()
}
