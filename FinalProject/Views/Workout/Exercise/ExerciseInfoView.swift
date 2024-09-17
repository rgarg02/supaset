//
//  ExerciseInfoView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/23/24.
//

import SwiftUI

struct ExerciseInfoView: View {
    let exercise: Exercise
    @EnvironmentObject var workoutManager : WorkoutManager
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(exercise.name)
                    .font(.subheadline)
                    .foregroundStyle(Color("Goldenish"))
                HStack{
                    ForEach(exercise.primaryMuscles){ muscle in
                        Text(muscle.rawValue.capitalized)
                            .font(.caption)
                    }
                }
            }
            Spacer()
        }
        .safeAreaPadding()
        .background(workoutManager.isSelected(exercise: exercise) ? Color("LightBlue"): Color("DarkerBlue"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ExerciseInfoView(exercise: Exercise(id: "3_4-Sit-Up", name: "3-4 Sit Up", level: .beginner, primaryMuscles: [.abdominals,.abductors], secondaryMuscles: [.biceps,.calves], instructions: ["These are some sample instructions"], category: .cardio, images: [""]))
        .environmentObject(WorkoutManager())
}
