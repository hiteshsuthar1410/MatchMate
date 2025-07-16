//
//  HomeView.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = UserViewModel()
    var body: some View {
//        VStack {
//            // Top greeting and avatar
//            HStack {
//                Image(systemName: "person.crop.circle.fill")
//                    .resizable()
//                    .frame(width: 40, height: 40)
//                    .padding(4)
//                    .background(Color.white.opacity(0.1))
//                    .clipShape(Circle())
//                
//                VStack(alignment: .leading) {
//                    Text("Hello, Henry")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                    Text("New work")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                
//                Spacer()
//                
//                Button(action: {}) {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.white)
//                }
//                
//            }
//            .padding(.horizontal)
            
            ScrollView {
                ForEach(vm.users, id: \.id) { user in
                    ProfileCard(user: user)
                        .frame(maxWidth: .infinity)
                    //                    .frame(height: 500)
                        .aspectRatio(3/4, contentMode: .fit)
                        .padding()
                    //                    .fixedSize()
                }
                
            }
//        }
        .background(Color.black, ignoresSafeAreaEdges: .all)
        .task {
            await vm.fetchUsers()
        }
    }
}

#Preview {
    HomeView()
}
