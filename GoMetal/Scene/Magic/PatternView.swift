//  Created by Alexander Skorulis on 20/7/2024.

import SwiftUI

struct PatternView: View {
    
    let pattern: PatternProtocol
    let canvasSize: CGSize
    let fillPct: Float
    
    var body: some View {
        ZStack {
            AnyShape(pattern.shape)
                .stroke(style: StrokeStyle(lineWidth: 4))
                .foregroundColor(.black)
            
            AnyShape(pattern.shape)
                .trim(from: 0, to: CGFloat(fillPct))
                .stroke(style: StrokeStyle(lineWidth: 4))
                .foregroundColor(.red)
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
}

#Preview {
    PatternView(
        pattern: LinePattern(),
        canvasSize: .init(width: 300, height: 300),
        fillPct: 0.5
    )
}
