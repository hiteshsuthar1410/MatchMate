//
//  UserProfile.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import Foundation
struct User: Identifiable, Codable {
    var id : String {
        login.uuid
    }
    let name: Name
    let email: String
    let phone: String
    let picture: Picture
    let location: Location
    let login: Login
    
    // for UI, not in API response
    var isOnline: Bool = true
    var isActionTaken = false
    var isAccepted = false
    var timestamp = Date()
    var lastUpdate = Date()
    
    enum CodingKeys: String, CodingKey {
        case name, email, phone, picture, location, login
    }

    struct Name: Codable {
        let title: String
        let first: String
        let last: String

        var fullName: String {
            "\(title) \(first) \(last)"
        }
    }

    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    struct Location: Codable {
        let street: Street
        let city: String
        let state: String
        let country: String
        
        struct Street: Codable {
            let number: Int
            let name: String
        }
        
        var fullAddress: String {
            "\(street.number) \(street.name), \(city), \(state), \(country)"
        }
    }
    struct Login: Codable {
        var uuid: String
    }
}

extension User {
    static let preview = User(
        name: Name(
            title: "Mr.",
            first: "John",
            last: "Doe"
        ),
        email: "john.doe@example.com",
        phone: "+1-202-555-0170",
        picture: Picture(
            large: "https://randomuser.me/api/portraits/men/1.jpg",
            medium: "https://randomuser.me/api/portraits/med/men/1.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/men/1.jpg"
        ),
        location: Location(
                    street: Location.Street(
                        number: 123,
                        name: "Main Street"
                    ),
                    city: "San Francisco",
                    state: "California",
                    country: "USA"
                ),
        login: Login(uuid: UUID().uuidString)
    )
}
