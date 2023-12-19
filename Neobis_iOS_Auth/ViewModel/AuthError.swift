//
//  AuthError.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 19/12/23.
//

import Foundation

// Enum to represent authentication errors
enum AuthError: Error {
    case invalidInput
    case invalidURL
    case serializationError
    case httpError(statusCode: Int)
    case emptyData
}
