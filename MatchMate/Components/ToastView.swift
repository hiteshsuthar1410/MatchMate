//
//  ToastView.swift
//  MatchMate
//
//  Created by NovoTrax Dev1 on 17/07/25.
//

import SwiftUI

struct ToastView: View {
    @Binding var message: String
    
    var body: some View {
        Text(message)
            .font(.subheadline)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.6))
            )
            .multilineTextAlignment(.center)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .clipShape(RoundedRectangle(cornerRadius: 26))
            .padding(.bottom, 30)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var message: String
    let duration: Double
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Spacer()
                    ToastView(message: $message)
                }
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, message: Binding<String>, duration: Double = 2.0) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, duration: duration))
    }
}

#Preview {
    ToastView(message: .constant("Accepted"))
}
