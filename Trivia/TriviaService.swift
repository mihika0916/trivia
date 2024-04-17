import Foundation
class TriviaService {
    //
    //  TriviaService.swift
    //  Trivia
    //
    //  Created by Mihika Sharma on 20/03/24.
    //
    
    
    
    
    let url = URL(string: "https://opentdb.com/api.php?amount=10")!
    func getTriviaQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching trivia questions: \(error?.localizedDescription ?? "Unknown error")")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(apiResponse.results)
                    }
                } catch {
                    print("Error decoding trivia questions: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            task.resume()
        
    }
    private struct ApiResponse: Decodable {
            let response_code: Int
            let results: [TriviaQuestion]
        }
    
    
}
