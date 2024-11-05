//
//  ShowAddedExercisesView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/13/24.
//

import SwiftUI

struct ShowAddedExercisesView: View {
    var template : WorkoutTemplate
    @EnvironmentObject var workoutManager : WorkoutManager
    var body: some View {
        VStack {
            List {
                ForEach(template.orderedExercises()) { exercise in
                    HStack {
                        Text(workoutManager.exerciseName(for: exercise.exerciseID))
                        Spacer()
                        Text("x \(exercise.numberOfSets)")
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            template.removeExercise(exerciseID: exercise.exerciseID)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    .listRowBackground(Color("LightBlue"))
                }
            }
        }
    }
}

#Preview {
    ShowAddedExercisesView(template: WorkoutTemplate(name: "My Template", exercises: []))
        .modelContainer(for: WorkoutTemplate.self)
}
