//
//  HomeView.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: UserViewModel
    var showFilteredList = false
    
    var body: some View {
        NavigationStack {
            VStack {
                //MARK:  User Info
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
                
                if vm.isLoading {
                    ProgressView() {
                        Text("Finding people you’ll love to meet 🥰")
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(showFilteredList ? vm.filteredUsers : vm.users, id: \.login.uuid) { user in
                                ProfileCard(user: user, acceptButtonAction: {
                                    vm.handleUserAction(uuid: user.id, isAccepted: true)
                                }, declineButtonAction: {
                                    vm.handleUserAction(uuid: user.id, isAccepted: false)
                                })
                                .frame(maxWidth: .infinity)
                                .aspectRatio(3/4, contentMode: .fit)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 12)
                            }
                            .listStyle(.plain)
                            .edgesIgnoringSafeArea(.all)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .refreshable {
                        if !showFilteredList {
                            await vm.loadUsers(isRefresh: true)
                        }
                    }
                }
            }
            .background(Color.black, ignoresSafeAreaEdges: .all)
            .toast(isPresented: $vm.toastConfig.show, message: $vm.toastConfig.message)
            .task {
                if !showFilteredList {
                    await vm.loadUsers()
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserViewModel())
}
