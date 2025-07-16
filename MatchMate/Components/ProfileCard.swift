//
//  ProfileCard.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 16/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCard: View {
    
    let user = User.preview
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    WebImage(url: URL(string: user.picture.large))
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: geometry.size.width,
                            maxHeight: geometry.size.height
                        )
                        .aspectRatio(3/4, contentMode: .fit)
                        .clipped()
                        .cornerRadius(20)
                }
                .background(Color.green)
            }
            
            VStack(alignment: .leading) {
                Group {
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
                    HStack {
                        Text(user.name.fullName)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    
                    Text(user.location.fullAddress)
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.bottom, 6)
                }
                .padding(.horizontal)
                .padding(.vertical, 2)
                
                
            }
            .background(Color.black.opacity(0.3))
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10.0))
            .foregroundStyle(.secondary)
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard()
    }
}
