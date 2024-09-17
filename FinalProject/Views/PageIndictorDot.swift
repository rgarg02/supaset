//
//  PageIndictorDot.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/1/24.
//

import Foundation
import SwiftUI
struct DotsView: View {
    let numberOfDots: Int
    let activeDotIndex: Int // To highlight the active dot
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfDots, id: \.self) { index in
                Circle()
                    .fill(index == activeDotIndex ? Color.blue : Color.gray)
                    .frame(width: 10, height: 10)
            }
        }
    }
}
