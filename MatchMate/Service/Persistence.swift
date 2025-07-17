//
//  Persistence.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import SwiftUI
import CoreData
import Foundation

class Persistence: ObservableObject {
    let container = NSPersistentContainer(name: "MatchMate")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveUsersToCoreData(_ users: [User], context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()

        for user in users {
            print("Saving user \(user.name.fullName)")
            fetchRequest.predicate = NSPredicate(format: "uuid == %@", user.login.uuid)

            do {
                let results = try context.fetch(fetchRequest)

                if let existing = results.first {
                    // Update all except isActionTaken and isAccepted
                    existing.title = user.name.title
                    existing.first = user.name.first
                    existing.last = user.name.last
                    
                    existing.email = user.email
                    existing.phone = user.phone
                    
                    existing.large = user.picture.large
                    existing.medium = user.picture.medium
                    existing.thumbnail = user.picture.thumbnail
                    
                    existing.number = Int16(user.location.street.number)
                    existing.name = user.location.street.name
                    existing.city = user.location.city
                    existing.state = user.location.state
                    existing.country = user.location.country
                    
                    existing.isOnline = user.isOnline
                } else {
                    // New entry
                    let newUser = CDUser(context: context)
                    newUser.uuid = user.login.uuid
                    newUser.title = user.name.title
                    newUser.first = user.name.first
                    newUser.last = user.name.last
                    
                    newUser.email = user.email
                    newUser.phone = user.phone
                    
                    newUser.large = user.picture.large
                    newUser.medium = user.picture.medium
                    newUser.thumbnail = user.picture.thumbnail
                    
                    newUser.number = Int16(user.location.street.number)
                    newUser.name = user.location.street.name
                    newUser.city = user.location.city
                    newUser.state = user.location.state
                    newUser.country = user.location.country
                    
                    newUser.isOnline = user.isOnline
                    newUser.isActionTaken = user.isActionTaken
                    newUser.isAccepted = user.isAccepted
                    
                    newUser.timestamp = user.timestamp
                    newUser.lastUpdate = user.lastUpdate
                }

            } catch {
                print("Failed to fetch CDUser with uuid \(user.login.uuid): \(error)")
            }
        }

        do {
            try context.save()
            print("Users saved/updated successfully.")
        } catch {
            print("Failed to save users: \(error)")
        }
    }
    
    func fetchUsersFromCoreData(context: NSManagedObjectContext) -> [User] {
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDUser.timestamp, ascending: false)]

        do {
            let cdUsers = try context.fetch(request)
            print("Retriving \(cdUsers.count)")
            return cdUsers.map { cdUser in
                User(
                    name: User.Name(
                        title: cdUser.title ?? "",
                        first: cdUser.first ?? "",
                        last: cdUser.last ?? ""
                    ),
                    email: cdUser.email ?? "",
                    phone: cdUser.phone ?? "",
                    picture: User.Picture(
                        large: cdUser.large ?? "",
                        medium: cdUser.medium ?? "",
                        thumbnail: cdUser.thumbnail ?? ""
                    ),
                    location: User.Location(
                        street: User.Location.Street(
                            number: Int(cdUser.number),
                            name: cdUser.name ?? ""
                        ),
                        city: cdUser.city ?? "",
                        state: cdUser.state ?? "",
                        country: cdUser.country ?? ""
                    ),
                    login: User.Login(uuid: cdUser.uuid ?? ""),
                    isOnline: cdUser.isOnline,
                    isActionTaken: cdUser.isActionTaken,
                    isAccepted: cdUser.isAccepted,
                    timestamp: cdUser.timestamp ?? Date(),
                    lastUpdate: cdUser.lastUpdate ?? Date()
                )
            }
        } catch {
            print("Failed to fetch from Core Data: \(error)")
            return []
        }
    }

    // Update action status for a given user by uuid
    func updateUserAction(uuid: String, isAccepted: Bool, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)

        do {
            if let user = try context.fetch(fetchRequest).first {
                user.isActionTaken = true
                user.isAccepted = isAccepted
                user.lastUpdate = Date()
                try context.save()
                print("Updated user \(uuid): isAccepted = \(isAccepted)")
            }
        } catch {
            print("Failed to update action for user \(uuid): \(error)")
        }
    }
}
