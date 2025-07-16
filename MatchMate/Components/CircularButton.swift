//
//  CircularButton.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 17/07/25.
//

import SwiftUI

struct CircularButton: View {
    let imageName: String
    let action: () -> Void
    var size: CGFloat = 50
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .clipShape(Circle())
                .shadow(radius: 4)
                .frame(width: size, height: size)
        }
        .clipShape(Circle())
    }
}

#Preview {
    CircularButton(imageName: "circle.fill") {}
}
