//
//  NetworkError.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 18/07/25.
//

import Foundation
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingFailed
    case requestFailed(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .decodingFailed:
            return "Failed to decode response"
        case .requestFailed(let reason):
            return "Request failed: \(reason)"
        }
    }
}
