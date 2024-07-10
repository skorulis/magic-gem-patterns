//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct SpellTestView: View {
    
    let pattern: SpellPattern = .circle
    
    @State private var sliderValue: CGFloat = 0
    @State private var canvasSize: CGSize = .zero
    
    var body: some View {
        VStack(spacing: 16) {
            canvas
            slider
        }
        .padding(.horizontal, 16)
        
    }
    
    private var canvas: some View {
        Circle()
            .fill(Color.clear)
            .overlay(
                PatternDisplayView(canvasSize: canvasSize)
            )
            .overlay(
                ActiveSpellView(
                    canvasSize: canvasSize,
                    pattern: pattern,
                    time: sliderValue
                )
            )
            .readSize(size: $canvasSize)
    }
    
    private var slider: some View {
        Slider(value: $sliderValue)
    }
    
}

#Preview {
    SpellTestView()
}
