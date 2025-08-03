//
//  BackButton.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 02.08.2025.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>;
    
    public let backFunc: () -> Void;
    
    init(backFunc: @escaping () -> Void) {
        self.backFunc = backFunc
    }
    
    
    var body: some View {
        ZStack {
            Button(action: {
                backFunc()
                //            self.presentationMode.wrappedValue.dismiss()
            }) {
                
                Image("Back")
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    BackButton(backFunc: {return})
}
