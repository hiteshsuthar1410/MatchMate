//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import SwiftUI

@main
struct MatchMateApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear {
                    setupTabBarAppearance()
                }
        }
    }
}
