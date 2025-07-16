//
//  ViewModel.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import Foundation
@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        let urlString = "https://randomuser.me/api/?results=10"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            self.users = decodedResponse.results
        } catch {
            errorMessage = "Failed to load users: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
