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
        NavigationStack {
            VStack {
                // Top greeting and avatar
                HStack {
                    Image("userImage")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(4)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Hello, Kate Tanner")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("New York")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                List {
                    ForEach(vm.users, id: \.id) { user in
                        ProfileCard(user: user, acceptButtonAction: {
                            vm.toastConfig = (show: true, message: "Accepted")
                        }, declineButtonAction: {
                            vm.toastConfig = (show: true, message: "Declined")
                        })
                            .frame(maxWidth: .infinity)
                            .aspectRatio(3/4, contentMode: .fit)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .padding(.vertical, 12)
                    }
                    .listStyle(.plain)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.black)
                    
                    
                }
                .scrollContentBackground(.hidden)
                .task {
                    await vm.fetchUsers()
                }
            }
            .tint(.white)
            .background(Color.black, ignoresSafeAreaEdges: .all)
            .toast(isPresented: $vm.toastConfig.show, message: $vm.toastConfig.message)
        }
    }
}

#Preview {
    HomeView()
}
