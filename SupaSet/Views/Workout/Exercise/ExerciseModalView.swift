//
//  ExerciseModalView.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/29/24.
//

import SwiftUI

struct ExerciseModalView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var workoutManager : WorkoutManager
    @Binding var isPresented: Bool
    @State var exerciseFunctions : (any ExerciseFunctions)?
    @State var widget : WorkoutWidget?
    @State var showDetailView : Bool = false
    let selectMany : Bool
    var body: some View {
        NavigationStack{
            List{
                ForEach(workoutManager.filteredExercises){exercise in
                        ExerciseInfoView(exercise: exercise)
                            .onTapGesture {
                                if selectMany{
                                    workoutManager.toggleSelection(of: exercise)
                                }else{
                                    workoutManager.toggleSelectionSingle(of: exercise)
                                }
                            }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if workoutManager.selectedCount > 0 {
                        Button("Add (\(workoutManager.selectedCount))") {
                            if (exerciseFunctions != nil) {
                                for exerciseId in workoutManager.selectedExercisesSubmit{
                                    exerciseFunctions?.addExercise(exerciseID: exerciseId)
                                }
                            } else {
                                for exerciseId in workoutManager.selectedExercisesSubmit{
                                    widget?.progressionID = exerciseId
                                }
                            }
                            workoutManager.clearSelection()
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(Color.red)
                    }
                    
                }
            }
            .searchable(text: $workoutManager.searchText)
            .listStyle(.plain)
            .safeAreaPadding()
        }
    }
}

#Preview {
    ExerciseModalView(isPresented: .constant(false), exerciseFunctions: Workout(), selectMany: false)
        .environmentObject(WorkoutManager())
        .modelContainer(previewContainer)
}
