//
//  ViewModel.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 14/12/23.
//

import Foundation


class AuthViewModel {
    
    // Replace with your API base URL
    let baseURL = "http://146.190.232.227:8000"
    
    // MARK: - LOGIN
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        // Ensure that the username and password are not empty
        guard !username.isEmpty, !password.isEmpty else {
            completion(.failure(AuthError.invalidInput))
            return
        }
        
        // Define the authentication endpoint path from Swagger
        let endpoint = "/api/login/"
        
        // Create the request URL
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(AuthError.invalidURL))
            return
        }
        
        // Create authentication parameters based on your Swagger models
        let parameters: [String: Any] = [
            "username": username,
            "password": password
            // Add any other required parameters
        ]
        
        // Create the request body
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion(.failure(AuthError.serializationError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the HTTP response status code
            if let httpResponse = response as? HTTPURLResponse {
                if !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(AuthError.httpError(statusCode: httpResponse.statusCode)))
                    return
                }
            }
            
            // Check for empty or nil data
            guard let data = data else {
                completion(.failure(AuthError.emptyData))
                return
            }
            
            // Print the raw JSON data for debugging
            if let jsonDataString = String(data: data, encoding: .utf8) {
                print("Raw JSON Data: \(jsonDataString)")
            }
            
            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                // Handle the authentication response
                completion(.success(response))
            } catch let decodingError as DecodingError {
                completion(.failure(decodingError))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - REGISTER
    func register(email: String, username: String, password: String, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        // Ensure that the email, username, and password are not empty
        guard !email.isEmpty, !username.isEmpty, !password.isEmpty else {
            completion(.failure(AuthError.invalidInput))
            return
        }
        
        // Define the registration endpoint path from Swagger
        let endpoint = "/api/register/"
        
        // Create the request URL
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(AuthError.invalidURL))
            return
        }
        
        // Create registration parameters based on your Swagger models
        let parameters: [String: Any] = [
            "email": email,
            "username": username,
            "password": password
            // Add any other required parameters
        ]
        
        // Create the request body
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            completion(.failure(AuthError.serializationError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the HTTP response status code
            if let httpResponse = response as? HTTPURLResponse {
                if !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(AuthError.httpError(statusCode: httpResponse.statusCode)))
                    return
                }
            }
            
            // Check for empty or nil data
            guard let data = data else {
                completion(.failure(AuthError.emptyData))
                return
            }
            
            // Print the raw JSON data for debugging
            if let jsonDataString = String(data: data, encoding: .utf8) {
                print("Raw JSON Data: \(jsonDataString)")
            }
            
            do {
                let response = try JSONDecoder().decode(RegisterResponse.self, from: data)
                // Handle the registration response
                completion(.success(response))
            } catch let decodingError as DecodingError {
                completion(.failure(decodingError))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
