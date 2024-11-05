//
//  ExerciseAddView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/13/24.
//

import SwiftUI

struct ExerciseAddView: View {
    @EnvironmentObject var workoutManager : WorkoutManager
    @Binding var isPresented: Bool
    @State var exerciseList : [String] = []
    @Bindable var template : WorkoutTemplate
    var body: some View {
        NavigationStack {
//            List(workoutManager.filterExercises(), id: \.id) { exercise in
//                HStack{
//                    Image(systemName: exerciseList.contains(exercise.id) ? "checkmark.square" : "square")
//                    Text(exercise.name)
//                }.onTapGesture { // Handle checkbox toggle
//                    if let index = exerciseList.firstIndex(of: exercise.id) {
//                        exerciseList.remove(at: index)
//                        template.removeExercise(exerciseID: exercise.id)
//                        
//                    } else {
//                        exerciseList.append(exercise.id)
//                        template.addExercise(exerciseID: exercise.id)
//                    }
//                        }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Close") {
//                        isPresented.toggle()
//                    }
//                }
//            }
//            .navigationTitle("Exercise")
//        }
//        .onAppear{
//            for exercise in template.exercises{
//                exerciseList.append(exercise.exerciseID)
//            }
        }
        .searchable(text: $workoutManager.searchText)
    }
}
