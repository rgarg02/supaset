//
//  CircularProgressBar.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/22/24.
//

import SwiftUI

struct CircularProgressBar: View {
    var steps: CGFloat
    var goalSteps: CGFloat

    private var progress: CGFloat {
        return min(steps / goalSteps, 1)
    }

    var body: some View {
        HStack{
            ZStack {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270.0))
                    .onAppear {
                        withAnimation(.linear(duration: 2)) {
                        }
                    }
            }
        }
    }
}
