//
//  TestStatistic.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import Foundation

struct Quiz: Codable, Hashable {
    let id: Int
    let results: [Question]
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case id = "response_code"
        case results
    }
    
    // MARK: - Hashable
    
    static func == (lhs: Quiz, rhs: Quiz) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(results)
    }
}
