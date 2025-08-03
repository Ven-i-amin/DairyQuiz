//
//  TestStatistic.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 01.08.2025.
//

import Foundation

struct Quiz: Codable {
    let id: Int
    let results: [Question]
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case id = "response_code"
        case results
    }
}
