//
//  ProfileCard.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCard: View {
    
    var user = User.preview
    
    var acceptButtonAction: () -> ()
    var declineButtonAction: () -> ()
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                // User Image
                WebImage(url: URL(string: user.picture.large))
                    .resizable()
                    .scaledToFill()
                    .frame(
                        maxWidth: geometry.size.width,
                        maxHeight: geometry.size.height
                    )
                    .aspectRatio(3/4, contentMode: .fit)
                    .clipped()
                    .cornerRadius(36)
                
                    .overlay(alignment: .bottom) {
                        // User Info
                        VStack(alignment: .leading, spacing: 4) {
                            Group {
                                // Active Status
                                if user.isOnline {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundStyle(.green)
                                        Text("Active")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color.white.opacity(0.2))
                                    .clipShape(Capsule())
                                    .padding(.top, 6)
                                }
                                // User Info
                                HStack {
                                    VStack(spacing: 4) {
                                        HStack {
                                            Text(user.name.fullName)
                                                .lineLimit(1)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            
                                            Image(systemName: "checkmark.seal.fill")
                                                .foregroundStyle(.white)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text(user.location.fullAddress)
                                            .lineLimit(2)
                                            .font(.callout)
                                            .foregroundColor(.white)
                                            .padding(.bottom, 6)
                                        
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    Spacer()
                                    
                                    // Action Buttons
                                    if user.isActionTaken {
                                        if user.isAccepted {
                                            ButtonWithTitle(title: "Accepted", imageName: "checkmark.circle.fill", action: {})
                                        } else {
                                            ButtonWithTitle(title: "Declined", imageName: "xmark.circle.fill", backgroundColor: .red, action: {})
                                        }
                                        
                                    } else {
                                        CircularButton(imageName: "x.circle.fill", action: {
                                            declineButtonAction()
                                        }, backgroundColor: Color.red, foregroundColor: Color.white)
                                        .buttonStyle(.plain)
                                        CircularButton(imageName: "checkmark.circle.fill", action: {
                                            acceptButtonAction()
                                        }, backgroundColor: Color.green, foregroundColor: Color.white)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                        }
                        .background(Color.black.opacity(0.35))
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 0.0))
                        .cornerRadius(26)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)

                    }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard(acceptButtonAction: {}, declineButtonAction: {})
    }
}
