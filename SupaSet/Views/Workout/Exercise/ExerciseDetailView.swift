//
//  ExerciseDetailView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/24/24.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    var body: some View {
        VStack{
            Text(exercise.name)
                .bold()
                .font(.title)
            HumanModel(showHumanModel: .constant(true), closable: false, exercise: exercise)
            HStack{
                Text("Category: \(exercise.category.rawValue.capitalized)")
            }
            HStack{
                Text("Instructions: \(exercise.instructions)")
            }
        }
    }
}

#Preview {
    ExerciseDetailView(exercise: Exercise(id: "3_4-Sit-Up", name: "3-4 Sit Up", level: .beginner, primaryMuscles: [.abdominals,.abductors], secondaryMuscles: [.biceps,.calves], instructions: ["These are some sample instructions"], category: .cardio, images: [""]))
        .environmentObject(WorkoutManager())
}
