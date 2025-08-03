//
//  Network.swift
//  DailyQuiz
//
//  Created by Вениамин Гребенёв on 03.08.2025.
//

import Foundation

struct Network {
    public static func getQuiz(failGetFunc: @escaping () -> Void, successGetFunc: @escaping (Quiz) -> Void){
        guard let url = URL(string: "https://opentdb.com/api.php?amount=5&type=multiple&category=9&difficulty=easy") else {
            print("url error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                failGetFunc()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("response error")
                failGetFunc()
                return
            }
            
            guard let data = data else {
                print("data error")
                failGetFunc()
                return
            }
            
            do {
                let quiz = try JSONDecoder().decode(Quiz.self, from: data)
                
                successGetFunc(quiz)
            } catch {
                print(error)
                failGetFunc()
            }
        }.resume()
    }
}
