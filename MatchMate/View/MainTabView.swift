//
//  MainTabView.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 17/07/25.
//

import SwiftUI
import UIKit

struct MainTabView: View {
    @StateObject var vm = UserViewModel()
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(vm)
                .tabItem {
                    Label("Explore", systemImage: "sparkles")
                }
            
            HomeView(showFilteredList: true)
                .environmentObject(vm)
                .tabItem {
                    Label("Activity", systemImage: "person.crop.circle.badge.checkmark")
                }
        }
        .tint(.pink)
    }
}

func setupTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
}

#Preview {
    MainTabView()
}
