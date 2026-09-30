//
//  NetworkError.swift
//  FixedExercise4
//
//  Created by Lukas Brezina on 21.09.26.
//

enum NetworkError: Error {
    case internalServerError
    case serializationError
    case invalidEmail
    case wrongEmail
    case invalidCredentials
    case invalidApiUrl
    case noNetworkConnection(String)
    case unexpectedHttpFormat(Int)
    case httpError(statusCode: Int, message: String?)
    case unexpectedError(String)
    
    var message: String {
        switch self {
        case .internalServerError: "Internal Server Error"
        case .serializationError: "Serialization Error"
        case .invalidEmail: "Invalid Email"
        case .wrongEmail: "No account found for this email"
        case .invalidCredentials: "Invalid Credentials"
        case .invalidApiUrl: "Invalid API URL"
        case .noNetworkConnection(let text): "No Network Connection: \(text)"
        case .unexpectedHttpFormat(let code): "Unexpected response format (status \(code))"
        case .httpError(let code, let message): "Request failed (status \(code)): \(message ?? "unknown")"
        case .unexpectedError(let text): "Unexpected Error: \(text)"
        }
    }
}

