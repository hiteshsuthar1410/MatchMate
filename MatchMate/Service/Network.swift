//
//  Network.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 17/07/25.
//

import Foundation
struct NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://randomuser.me/api/"

    private init() {}

    func fetchUsers(limit: Int = 10) async -> Result<[User], NetworkError> {
        let urlString = "\(baseURL)?results=\(limit)"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(UserResponse.self, from: data)
            return .success(decoded.results)
        } catch {
            return .failure(.requestFailed(error.localizedDescription))
        }
    }
}
