//
//  Model.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 14/12/23.
//

import Foundation

// Replace with your Swagger-generated models
struct LoginResponse: Codable {
    let username: String
    let tokens: Tokens
    
    struct Tokens: Codable {
        let refresh: String
        let access: String
    }
}

// Replace with your Swagger-generated models
struct RegisterResponse: Codable {
    let username: String
    let email: String
}


// MARK: - Welcome
struct Welcome: Codable {
    let swagger: String
    let info: Info
    let host: String
    let schemes: [String]
    let basePath: String
    let consumes, produces: [String]
    let securityDefinitions: SecurityDefinitions
    let security: [Security]
    let paths: [String: Path]
    let definitions: Definitions
}

// MARK: - Definitions
struct Definitions: Codable {
    let login: Login
    let registration: Registration
    let tokenObtainPair: TokenObtainPair
    let tokenRefresh: TokenRefresh

    enum CodingKeys: String, CodingKey {
        case login = "Login"
        case registration = "Registration"
        case tokenObtainPair = "TokenObtainPair"
        case tokenRefresh = "TokenRefresh"
    }
}

// MARK: - Login
struct Login: Codable {
    let loginRequired: [String]
    let type: String
    let properties: LoginProperties

    enum CodingKeys: String, CodingKey {
        case loginRequired = "required"
        case type, properties
    }
}

// MARK: - LoginProperties
struct LoginProperties: Codable {
    let username, password: Password
    let tokens: Tokens
}

// MARK: - Password
struct Password: Codable {
    let title, type: String
    let maxLength: Int?
    let minLength: Int
    let format: String?
}

// MARK: - Tokens
struct Tokens: Codable {
    let title, type: String
    let readOnly: Bool?
    let minLength: Int?
}

// MARK: - Registration
struct Registration: Codable {
    let registrationRequired: [String]
    let type: String
    let properties: RegistrationProperties

    enum CodingKeys: String, CodingKey {
        case registrationRequired = "required"
        case type, properties
    }
}

// MARK: - RegistrationProperties
struct RegistrationProperties: Codable {
    let username, email, password: Password
}

// MARK: - TokenObtainPair
struct TokenObtainPair: Codable {
    let tokenObtainPairRequired: [String]
    let type: String
    let properties: TokenObtainPairProperties

    enum CodingKeys: String, CodingKey {
        case tokenObtainPairRequired = "required"
        case type, properties
    }
}

// MARK: - TokenObtainPairProperties
struct TokenObtainPairProperties: Codable {
    let username, password: Password
}

// MARK: - TokenRefresh
struct TokenRefresh: Codable {
    let tokenRefreshRequired: [String]
    let type: String
    let properties: TokenRefreshProperties

    enum CodingKeys: String, CodingKey {
        case tokenRefreshRequired = "required"
        case type, properties
    }
}

// MARK: - TokenRefreshProperties
struct TokenRefreshProperties: Codable {
    let refresh, access: Tokens
}

// MARK: - Info
struct Info: Codable {
    let title, description: String
    let termsOfService: String
    let contact: Contact
    let license: License
    let version: String
}

// MARK: - Contact
struct Contact: Codable {
    let email: String
}

// MARK: - License
struct License: Codable {
    let name: String
}

// MARK: - Path
struct Path: Codable {
    let post: Post
    let parameters: [JSONAny]
}

// MARK: - Post
struct Post: Codable {
    let operationID, description: String
    let parameters: [Parameter]
    let responses: Responses
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case operationID = "operationId"
        case description, parameters, responses, tags
    }
}

// MARK: - Parameter
struct Parameter: Codable {
    let name, parameterIn: String
    let parameterRequired: Bool
    let schema: Schema

    enum CodingKeys: String, CodingKey {
        case name
        case parameterIn = "in"
        case parameterRequired = "required"
        case schema
    }
}

// MARK: - Schema
struct Schema: Codable {
    let ref: String

    enum CodingKeys: String, CodingKey {
        case ref = "$ref"
    }
}

// MARK: - Responses
struct Responses: Codable {
    let the201: The201

    enum CodingKeys: String, CodingKey {
        case the201 = "201"
    }
}

// MARK: - The201
struct The201: Codable {
    let description: String
    let schema: Schema
}

// MARK: - Security
struct Security: Codable {
    let basic: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case basic = "Basic"
    }
}

// MARK: - SecurityDefinitions
struct SecurityDefinitions: Codable {
    let basic: Basic

    enum CodingKeys: String, CodingKey {
        case basic = "Basic"
    }
}

// MARK: - Basic
struct Basic: Codable {
    let type: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        // Implement the hash(into:) method
    }

    init() {}

    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                JSONNull.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Wrong type for JSONNull"
                )
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

