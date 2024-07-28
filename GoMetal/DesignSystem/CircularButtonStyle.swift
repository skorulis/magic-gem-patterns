//Created by Alexander Skorulis on 26/5/2024.

import SwiftUI

struct CircularButtonStyle: ButtonStyle {
    
    let size: Size
    let tintColor: Color
    
    init(
        size: Size = .medium,
        tintColor: Color = .green
    ) {
        self.size = size
        self.tintColor = tintColor
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(width: size.width, height: size.width)
            .background(Circle().fill(tintColor))
            .shadow(color: Color.gray.opacity(0.5), radius: 8, x: 0, y: 8)
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
        
    }
}

extension CircularButtonStyle {
    enum Size {
        case medium
        
        var width: CGFloat {
            switch self {
            case .medium:
                return 52
            }
        }
    }
}

#Preview {
    Button(action: {}) {
        Image(systemName: "plus")
            .resizable()
            .fontWeight(.medium)
    }
    .buttonStyle(CircularButtonStyle())
}
