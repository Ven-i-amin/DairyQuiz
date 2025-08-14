//
//  Network.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import Foundation

struct QuizService {
    static func get(completion: @escaping (Quiz?) -> Void) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=5&type=multiple&category=9&difficulty=easy") else {
            print("url error")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("response error")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("data error")
                completion(nil)
                return
            }
            
            do {
                let quiz = try JSONDecoder().decode(Quiz.self, from: data)
                
                completion(quiz)
            } catch {
                print(error)
                completion(nil)
                return
            }
        }.resume()
    }
}
