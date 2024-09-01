//  Created by Alexander Skorulis on 20/7/2024.

import SwiftUI

struct PatternView: View {
    
    let pattern: PatternProtocol
    let canvasSize: CGSize
    let fillPct: Float
    
    var body: some View {
        ZStack {
            AnyShape(pattern.shape)
                .stroke(style: StrokeStyle(lineWidth: lineWidth))
                .foregroundColor(.black)
            
            AnyShape(pattern.shape)
                .trim(from: 0, to: CGFloat(fillPct))
                .stroke(style: StrokeStyle(lineWidth: lineWidth))
                .foregroundColor(.red)
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
    
    private var lineWidth: CGFloat {
        return ceil(canvasSize.width / 100)
    }
}

#Preview {
    PatternView(
        pattern: LinePattern(),
        canvasSize: .init(width: 300, height: 300),
        fillPct: 0.5
    )
}
