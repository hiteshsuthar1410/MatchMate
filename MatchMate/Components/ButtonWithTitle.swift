//
//  ButtonWithTitle.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 17/07/25.
//

import SwiftUI

struct ButtonWithTitle: View {
    let title: String
    let imageName: String
    var backgroundColor: Color = .green
    var foregroundColor: Color = .white
    let action: () -> Void
    var size: CGFloat = 50

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .padding(.leading, 16)
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundStyle(foregroundColor)
                    .background(backgroundColor)
                    .frame(width: size, height: size)
            }
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    ButtonWithTitle(title: "Accepted", imageName: "checkmark.circle.fill", action: {})
    ButtonWithTitle(title: "Declined", imageName: "xmark.circle.fill", backgroundColor: .red, action: {})
}
