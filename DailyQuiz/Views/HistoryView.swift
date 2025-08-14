//
//  HistoryView.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject
    var historyManager: HistoryManager;
    
    @Binding
    private var path: NavigationPath;
    
    @State
    private var searchQuiz = false;
    
    @State
    private var quizChoosen = false;
    
    @State
    private var quizNumber = -1;
    
    init(
        path: Binding<NavigationPath>
    ) {
        self._path = path
    }
    
    var body: some View {
        ZStack {
            Color("App")
                .ignoresSafeArea()
            
            ScrollView {
                ToolBarView(backButton: BackButton(
                    backFunc: ViewTransition.returnToLastScreen(path: $path)
                )) {
                    Text("History")
                        .foregroundStyle(Color("View"))
                        .font(.system(size: 32))
                        .fontWeight(.heavy)
                }
                
                if historyManager.isNotEmpty() {
                    history
                } else {
                    goBack
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension HistoryView {
    private var goBack: some View {
        WhiteSquareView {
            Text("ZeroQuiz")
                .foregroundStyle(Color("RegularText"))
                .font(.system(size: 20))
                .padding(.bottom, 30)
            
            DefaultButton(
                buttonAction: blockAndGoBack,
                buttonText: "Start",
                isActive: !searchQuiz
            )
        }
    }
    
    private func blockAndGoBack(){
        searchQuiz = true;
        ViewTransition.returnToLastScreen(path: $path)()
    }
    
    var history: some View {
        ForEach(0..<historyManager.quizCount(), id: \.self) { index in
            quizMenu(index: index)
                .padding(.bottom, 20)
        }
    }
    
    func quizMenu(index: Int) -> some View {
        VStack{
            Button(action: {goToQuizAnalysis(index: index)}) {
                VStack {
                    nameAndStars(index: index)
                        .padding(.bottom, 10)
                    quizTime(index: index)
                }
                .frame(maxWidth: .infinity)
                .padding(22)
                .background(Color("View"))
                .containerShape(RoundedRectangle(cornerRadius: 40))
                .padding(.leading, 24)
                .padding(.trailing, 24)
            }
        }
    }
    
    func nameAndStars(index: Int) -> some View {
        HStack {
            Text("Quiz \(index)")
                .foregroundStyle(Color("Category"))
                .font(.system(size: 24))
                .fontWeight(.bold)
            
            Spacer()
            
            StarsView(
                quizManager: historyManager.getQuizManager(index: index),
                userAnswers: historyManager.getUserAnswers(index: index),
                starGap: 1
            )
            .frame(height: 16)
            .fixedSize()
        }
    }
    
    func quizTime(index: Int) -> some View {
        HStack {
            let date = historyManager.getTime(index: index)
            
            if (date != nil) {
                Text(date!.formatted(.dateTime.day().month(.wide)))
                    .foregroundStyle(Color("RegularText"))
                    .font(.system(size: 12))
                
                Spacer()
                
                Text(date!.formatted(date: .omitted, time: .shortened))
                    .foregroundStyle(Color("RegularText"))
                    .font(.system(size: 12))
            }
        }
    }
    
    private func goToQuizAnalysis(index: Int){
        quizChoosen = true;
        path.append(Navigation.review(quizNumber: index))
    }
    
    private func resetStates(){
        searchQuiz = false;
        quizChoosen = false;
        quizNumber = -1;
    }
}

#Preview {
    HistoryView(
        path: .constant(NavigationPath())
    )
    .environmentObject(HistoryManager.previewInstance())
}
