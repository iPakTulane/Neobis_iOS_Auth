//
//  APIService.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 14/12/23.
//

import Foundation

class APIService {
    
    let baseURL = "http://146.190.232.227:8000"

    func post(endpoint: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = URL(string: baseURL + endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
