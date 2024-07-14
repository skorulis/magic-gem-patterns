//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct SpellTestView: View {
    
    @State var pattern: SpellPattern = .line
    let service = SpellCastService()
    
    @State private var sliderValue: CGFloat = 0
    @State private var canvasSize: CGSize = .zero
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Pattern", selection: $pattern) {
                ForEach(SpellPattern.allCases) { pattern in
                    Text(pattern.rawValue)
                        .tag(pattern)
                }
            }
            canvas
            slider
        }
        .padding(.horizontal, 16)
        
    }
    
    private var canvas: some View {
        Circle()
            .fill(Color.clear)
            .overlay(
                DirectionalFieldView(pattern: pattern, canvasSize: canvasSize)
            )
            .overlay(
                PatternDisplayView(pattern: pattern, canvasSize: canvasSize)
            )
            .overlay(
                ActiveSpellView(
                    canvasSize: canvasSize,
                    pattern: pattern,
                    energy: energy
                )
            )
            .readSize(size: $canvasSize)
    }
    
    private var energy: SpellEnergy {
        service.calculateEnergy(
            pattern: pattern,
            time: sliderValue,
            canvasSize: canvasSize
        )
    }
    
    private var slider: some View {
        Slider(value: $sliderValue)
    }
    
}

#Preview {
    SpellTestView()
}
