//
//  WorkoutMain.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/22/24.
//

import SwiftUI
import SwiftData
func formatTime(seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let seconds = seconds % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}
struct WorkoutMain: View {
    @Environment(\.modelContext) var context
    @State private var showingAddExerciseModal : Bool = false
    @EnvironmentObject var workoutManager : WorkoutManager
    @State private var exerciseList: [Exercise] = []
    @Binding var expandWorkout : Bool
    var animation : Namespace.ID
    @State var currentDot : Int = 0
    @State var workoutName : String = "New Workout"
    @Bindable var workout : Workout
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @State var animateContent : Bool = false
    @State var offsetY : CGFloat = 0
    @State var submitExercises : Bool = false
    var body: some View {
        GeometryReader { geometry in
            VStack{
                WorkoutInfo(workout: workout, expandWorkout: $expandWorkout, animation: animation)
                    .allowsHitTesting(false)
                    .opacity(animateContent ? 0 : 1)
                    .matchedGeometryEffect(id: "BGView", in: animation)
                WorkoutMainTopControls(animation: animation, workout: workout)
                ZStack(alignment: .bottom){
                        WorkoutMainTab(workout: workout, animation: animation)
                        HStack{
                            Button("Add Exercise") {
                                withAnimation{
                                    showingAddExerciseModal = true
                                }
                            }
                            Button("Cancel Workout") {
                                expandWorkout = false
                                context.delete(workout)
                            }
                            Button("Finish"){
                                var allSetsDone = true
                                var emptyWorkout = false
                                if workout.exercises.count == 0 {
                                    emptyWorkout = true
                                }
                                for exercise in workout.exercises {
                                    for set in exercise.sets {
                                        if !set.done {
                                            allSetsDone = false
                                            break
                                        }
                                    }
                                    if !allSetsDone {
                                        break
                                    }
                                }
                                if emptyWorkout{
                                    showAlert = true
                                }
                                if allSetsDone {
                                    workout.isFinished = true
                                    workout.endDate = Date.now
                                    dismiss()
                                } else {
                                    showAlert = true
                                }
                            }
                        }
                    }
                .opacity(animateContent ? 1 : 0)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Incomplete Workout"),
                        message: Text("The workout is incompleted"),
                        primaryButton: .destructive(Text("Finish Workout")) {
                            for exercise in workout.exercises {
                                exercise.sets.removeAll(where: {!$0.done})
                            }
                            workout.isFinished = true
                            dismiss()
                        },
                        secondaryButton: .cancel(Text("Continue Workout"))
                    )
                }
                .buttonStyle(.borderedProminent)
            }
            .opacity(animateContent ? 1: 0)
            .contentShape(Rectangle())
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translationY = value.translation.height
                        offsetY = (translationY > 0 ? translationY : 0)
                        
                    })
                    .onEnded({ value in
                        withAnimation(.easeInOut(duration: 0.35)){
                            if offsetY > geometry.size.height * 0.4 {
                                expandWorkout = false
                                animateContent = false
                            } else {
                                offsetY = .zero
                            }
                        }
                    })
            )
            .onAppear{
                withAnimation(.easeInOut(duration: 0.35)){
                    animateContent = true
                }
            }
            .overlay{
                if showingAddExerciseModal {
                    ExerciseModalView(isPresented: $showingAddExerciseModal, exerciseFunctions: workout, selectMany : true)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.7)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 10)
                            .transition(.scale.combined(with: .opacity))
                            .padding()
                }
            }
            .background(Color.black)
            .containerRelativeFrame(.vertical)
        }
    }
}

struct WorkoutMain_Previews: PreviewProvider {
    static var previews: some View {
        @Namespace var animation
        let manager : WorkoutManager = WorkoutManager()
        let workout = Workout(isFinished: false)
        WorkoutMain(expandWorkout: .constant(true), animation: animation, currentDot: 0, workoutName: "New Workout", workout: workout)
            .modelContainer(previewContainer)
            .environmentObject(manager)
            .onAppear{
                previewContainer.mainContext.insert(workout)
                workout.addExercise(exerciseID: "90_90_Hamstring")
                workout.addExercise(exerciseID: "3_4-Sit-Up")
            }
    }
}
