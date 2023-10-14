//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Camila Castaneda on 10/13/23.
//

import Foundation

enum TriviaError: Error {
    case networkError
    case decodingError
}

class TriviaQuestionService {
    
    static let shared = TriviaQuestionService()
    
    private init() {}
    
    func fetchQuestions(completion: @escaping (Result<[TriviaQuestion], TriviaError>) -> Void) {
        let urlString = "https://opentdb.com/api.php?amount=10"
        guard let url = URL(string: urlString) else {
            completion(.failure(.networkError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TriviaApiResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

struct TriviaApiResponse: Decodable {
    let results: [TriviaQuestion]
}
