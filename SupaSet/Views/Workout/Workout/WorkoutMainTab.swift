//
//  WorkoutMainTab.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/4/24.
//

import SwiftUI
import SwiftData
struct WorkoutMainTab: View {
    @Environment(\.modelContext) var context
    @Bindable var workout : Workout
    var animation : Namespace.ID
    @State private var dragging: EInfo?
    @State private var moving : Bool = false
    @EnvironmentObject var workoutManager : WorkoutManager
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing){
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        ForEach(workout.orderedExercises()) { exercise in
                            ExerciseTab(exerciseInfo: exercise, moving : $moving)
                                .scrollTransition{content, phase in
                                    content.opacity(phase.isIdentity ? 1 : 0.5)
                                }
                                .opacity(dragging == exercise ? 0.7 : 1)
                                .draggable(exercise.id){
                                    
                                    EmptyView()
                                    .safeAreaPadding(.bottom)
                                        .onAppear{
                                            withAnimation {
                                                moving = true
                                            }
                                            dragging = exercise
                                        }
                                    
                                }
                                .dropDestination(for: PersistentIdentifier.self ){ persistentModelIDs, _ in
                                    withAnimation{
                                        moving = false
                                        dragging = nil
                                    }
                                    return false
                                } isTargeted: { status in
                                    if let dragging, status, dragging != exercise {
                                        if let from = workout.exercises.first(where: {$0.index == dragging.index})?.index, let to = workout.exercises.first(where: {$0.index == exercise.index})?.index {
                                            withAnimation{
                                                workout.moveExercises(from: IndexSet(integer: from), to: to > from ? to + 1 : to)
                                            }
                                        }
                                    }
                                }

                        }
                        .scrollTargetLayout()
                    }
                    .animation(.default, value: workout.exercises)
                }
                .contentMargins(15, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
            }
        }
    }
}
struct DragRelocateDelegate: DropDelegate {
    let item: EInfo
    @Bindable var workout: Workout
    @Binding var current: EInfo?

    func dropEntered(info: DropInfo) {
        if item != current {
            let from = workout.exercises.firstIndex(of: current!)!
            let to = workout.exercises.firstIndex(of: item)!
            if workout.exercises[to].id != current!.id {
                workout.moveExercises(from: IndexSet(integer: from), to: to > from ? to + 1 : to)
            }
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}
struct WorkoutMainTab_Previews: PreviewProvider {
    static var previews: some View {
        @Namespace var animation
        let workout = Workout()
        WorkoutMainTab(workout: workout, animation: animation)
            .modelContainer(previewContainer)
            .environmentObject(WorkoutManager())
            .onAppear{
                previewContainer.mainContext.insert(workout)
                workout.exercises.append(EInfo(exerciseID: "3-4-Sit_Up"))
                workout.exercises.append(EInfo(exerciseID: "3-4-Sit_Up"))
            }
    }
}
