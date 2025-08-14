//
//  historyService.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import Foundation

struct HistoryService {
    static let historyFileName = "user_history.json"
    
    static func save(userHistory: UserHistory) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(userHistory)
            let url = Self.getDocumentsDirectory().appendingPathComponent(Self.historyFileName)
            try data.write(to: url)
        } catch {
            print("\(error)")
        }
    }
    
    static func load() -> UserHistory? {
        let url = Self.getDocumentsDirectory().appendingPathComponent(Self.historyFileName)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(UserHistory.self, from: data)
        } catch {
            print("\(error)")
            return nil;
        }
    }
    
    static func create() -> UserHistory {
        let userHistory = UserHistory()
        save(userHistory: userHistory)
        
        return userHistory
    }
    
    
    private static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
