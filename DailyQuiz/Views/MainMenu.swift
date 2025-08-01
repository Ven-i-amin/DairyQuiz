//
//  MainMenu.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        ZStack {
            Color("App")
                .ignoresSafeArea()
            
            VStack {
                history
                    .padding(.top, 40)
                
                Spacer()
                
                VStack {
                    logo
                        .padding(.bottom, 30)
                    
                    
                    menu
                }
                .padding(.bottom, 70)
                
                Spacer()
            }
        }
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
        VStack {
            Text("Welcome")
                .font(.system(size: 32))
                .bold()
                .multilineTextAlignment(.center)
            
            Button(action: {
                print("todo")
            }) {
                Text("Start")
                    .fontWeight(.heavy)
                    .textCase(.uppercase)
            }
            .foregroundColor(Color("View"))
            .padding(16)
            .background(Color("Active"))
            .containerShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.top, 32)
        .padding(.bottom, 32)
        .padding(.leading, 24)
        .padding(.trailing, 24)
        .background(Color("View"))
        .containerShape(RoundedRectangle(cornerRadius: 46))
        .padding(.leading, 2)
        .padding(.trailing, 2)
    }
}

#Preview {
    MainMenu()
}
