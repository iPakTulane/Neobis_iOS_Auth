//
//  ViewModel.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 14/12/23.
//

import Foundation
import UIKit


protocol RegistrationViewModelDelegate: AnyObject {
    func didRegister(user: RegisterBegin)
    func didFail(with error: Error)
}

protocol LoginViewModelDelegate: AnyObject {
    func didLogin(user: TokenObtainPair)
    func didFail(with error: Error)
}

protocol UserViewModelProtocol: AnyObject {
    var registrationDelegate: RegistrationViewModelDelegate? { get set }
    var loginDelegate: LoginViewModelDelegate? { get set }
    
    func registerUser(email: String, username: String, password: String)
    func loginUser(username: String, password: String)
}

class UserViewModel: UserViewModelProtocol {

    weak var registrationDelegate: RegistrationViewModelDelegate?
    weak var loginDelegate: LoginViewModelDelegate?
    
    let apiService = APIService()
    
    init(registrationDelegate: RegistrationViewModelDelegate? = nil,
         loginDelegate: LoginViewModelDelegate? = nil) {
        self.registrationDelegate = registrationDelegate
        self.loginDelegate = loginDelegate
    }
    
    func registerUser(email: String, username: String, password: String) {
        let parameters: [String: Any] = ["email": email, "username": username, "password": password]
        
        apiService.post(endpoint: "/api/register/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(RegisterBegin.self, from: data)
                    DispatchQueue.main.async {
                        self?.registrationDelegate?.didRegister(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.registrationDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.registrationDelegate?.didFail(with: error)
                }
            }
        }
    }
    
    func loginUser(username: String, password: String) {
        
        let parameters: [String: Any] = ["username": username, "password": password]
        
        apiService.post(endpoint: "/api/login/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let dataString = String(data: data, encoding: .utf8)
                print("Data received: \(dataString ?? "nil")")
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(TokenObtainPair.self, from: data)
                    DispatchQueue.main.async {
                        self?.loginDelegate?.didLogin(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.loginDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.loginDelegate?.didFail(with: error)
                }
            }
        }
    }
}
