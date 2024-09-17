//
//  ShowExerciseSelection.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/14/24.
//

import SwiftUI

struct ShowExerciseSelection: View {
    @Binding var widget: WorkoutWidget
    @EnvironmentObject var workoutManager: WorkoutManager
    @Binding var isPresented : Bool
    var body: some View {
        NavigationStack {
//            List(workoutManager.filterExercises(), id: \.id) { exercise in
//                HStack{
//                    Image(systemName: widget.progressionID == exercise.id ? "checkmark.square" : "square")
//                    Text(exercise.name)
//                }.onTapGesture { // Handle checkbox toggle
//                    if widget.progressionID == exercise.id {
//                        widget.progressionID = ""
//                        
//                    } else {
//                        widget.progressionID = exercise.id
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
        }
        .searchable(text: $workoutManager.searchText)
    }
}

//struct ShowExerciseSelectionPreview: PreviewProvider {
//    static var previews: some View {
//        ShowExerciseSelection(widget: WorkoutWidget(), isPresented: .constant(true))
//            .environmentObject(WorkoutManager())
//        }
//}
