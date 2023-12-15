//
//  UserModel.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 14/12/23.
//

import Foundation

// MARK: - Trial models
struct TokenObtainPair: Codable {
    let refresh: String
    let access: String
}

struct TokenRefresh: Codable {
    let refresh: String
    let access: String
}

struct RegisterBegin: Codable {
    let email: String
}

struct Register: Codable {
    let email: String
    let name: String
    let password: String
    let password2: String
}


// MARK: - Models per Nargiza swagger
struct Login: Codable {
    let username: String
    let password: String
}

struct Registration: Codable {
    let username: String
    let email: String
    let password: String
}

//struct TokenObtainPair: Codable {
//    let username: String
//    let password: String
//}
//
//struct TokenRefresh: Codable {
//    let refresh: String
//}
