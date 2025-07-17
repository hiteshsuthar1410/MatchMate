//
//  ViewModel.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import Foundation
import CoreData
@MainActor
class UserViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading = true
    @Published var toastConfig = (show: false, message: "Toast Message")
    @Published private var errorMessage: String?
    @Published private var isInitialLoad = true
    let persistence = Persistence()
    
    // For User Interacted List
    var filteredUsers: [User] {
        users
            .filter { $0.isActionTaken }
            .sorted { (lhs: User, rhs: User) in
                (lhs.lastUpdate) > (rhs.lastUpdate)
            }
    }
    
    // Fetch from server -> save in db -> retrieve
    func loadUsers(isRefresh: Bool = false) async {
        let shouldLoad = isRefresh || isInitialLoad
        guard shouldLoad else { return }
        
        isLoading = true
        errorMessage = nil
        
        let result = await NetworkService.shared.fetchUsers(limit: 10)
        
        switch result {
        case .success(let users):
            persistence.saveUsersToCoreData(users, context: persistence.container.viewContext)
            self.users = persistence.fetchUsersFromCoreData(context: persistence.container.viewContext)
            isInitialLoad = false
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            toastConfig = (show: true, errorMessage ?? NetworkError.requestFailed("Network Error. Please try again later.").localizedDescription)
            self.users = persistence.fetchUsersFromCoreData(context: persistence.container.viewContext)
        }
        isLoading = false
    }

    // Handle user action (accept or decline)
    func handleUserAction(uuid: String, isAccepted: Bool) {
        persistence.updateUserAction(uuid: uuid, isAccepted: isAccepted, context: persistence.container.viewContext)
        self.users = persistence.fetchUsersFromCoreData(context: persistence.container.viewContext)
        toastConfig = (show: true, message:  isAccepted ? "Accepted" : "Declined")
    }
}
