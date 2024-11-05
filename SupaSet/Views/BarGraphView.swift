//
//  BarGraphView.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/22/24.
//

import SwiftUI

struct BarGraphView: View {
    var stepsData: [Int]
    let maxHeight: CGFloat = 200 // Maximum height of a bar

    private var scaleFactor: CGFloat {
        let maxSteps = stepsData.max() ?? 0
        return maxSteps > 0 ? maxHeight / CGFloat(maxSteps) : 0
    }

    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(stepsData.indices, id: \.self) { index in
                VStack {
                    Text("\(stepsData[index])")
                        .font(.caption)

                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 20, height: CGFloat(stepsData[index]) * scaleFactor * CGFloat.random(in: 0.5..<1))
                }
            }
        }
        .padding(.horizontal)
    }
}
