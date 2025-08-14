//
//  PagesTransition.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 14.08.2025.
//

import SwiftUI

struct ViewTransition {
    static func returnToLastScreen(path: Binding<NavigationPath>) -> () -> Void {
        guard !path.wrappedValue.isEmpty else {
            return {}
        }
        
        return {
            path.wrappedValue.removeLast()
        }
    }
    
    static func returnToMainMenu(path: Binding<NavigationPath>) -> () -> Void {
        guard !path.wrappedValue.isEmpty else {
            return {}
        }
        
        return {
            path.wrappedValue = NavigationPath()
        }
    }
}
