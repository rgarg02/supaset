//
//  DotView.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/1/24.
//

import SwiftUI
import SwiftData
struct DotsView: View {
    @Bindable var workout : Workout
    let activeDotIndex: Int // To highlight the active dot
    
    var body: some View {
        HStack {
            ForEach(0..<workout.exercises.count, id: \.self) { index in
                var dotColor : Color {
                    if index == activeDotIndex {
                        return .blue
                    }
                    else if workout.exercises[index].isCompleted() {
                        return .green
                    }
                    else{
                        return .gray
                    }
                }
                Circle()
                    .fill(dotColor)
                    .frame(width: 10, height: 10)
            }
        }
    }}
