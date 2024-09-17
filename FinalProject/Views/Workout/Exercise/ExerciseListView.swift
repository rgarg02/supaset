//
//  ExerciseListView.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/4/24.
//

import SwiftUI

struct ExerciseListView: View {
    @Bindable var workout: Workout
    @Bindable var exerciseInfo: EInfo
    @EnvironmentObject var workoutManager: WorkoutManager
    var body: some View {
            HStack{
                Text(workoutManager.exerciseName(for: exerciseInfo.exerciseID))
                    .font(.headline)
                    .padding()
                Spacer()
                Image(systemName: "line.3.horizontal")
            .toolbar{
                EditButton()
            }
        }
    }
}

