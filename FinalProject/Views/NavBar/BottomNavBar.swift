//
//  BottomNavBar.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/27/24.
//

import SwiftUI
import SwiftData
struct BottomNavBar: View {
    @EnvironmentObject var workoutManager : WorkoutManager
    @Query var workouts : [Workout]
    @State var expandWorkout : Bool = false
    @Namespace private var animation 
    var body: some View {
        TabView() {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .padding(.bottom , workouts.first(where: {!$0.isFinished}) != nil ? 49 : 0)
            WorkoutHome(expandWorkout: $expandWorkout)
                .tabItem {
                    Label("Workout", systemImage: "figure.strengthtraining.traditional")
                }
                .padding(.bottom , workouts.first(where: {!$0.isFinished}) != nil ? 60 : 0)
            PreviousWorkouts()
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
                .padding(.bottom , workouts.first(where: {!$0.isFinished}) != nil ? 60 : 0)
            NutritionView()
                .tabItem {
                    Label("Food", systemImage: "fork.knife")
                }
                .padding(.bottom , workouts.first(where: {!$0.isFinished}) != nil ? 60 : 0)
            HumanModel(showHumanModel: .constant(true), closable: false)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .padding(.bottom , workouts.first(where: {!$0.isFinished}) != nil ? 60 : 0)
        }
        .safeAreaInset(edge: .bottom) {
                CustomBottomSheet()
        }
        .overlay(alignment: .center, content: {
            if expandWorkout {
                if let workout = workouts.first(where: {!$0.isFinished}) {
                    WorkoutMain(expandWorkout: $expandWorkout, animation: animation, workout: workout)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y:-5)))
                }
               
            }
        })
    }
}

extension BottomNavBar {
    @ViewBuilder
    func CustomBottomSheet() -> some View{
        if let workout = workouts.first(where: {!$0.isFinished}) {
            ZStack{
                if expandWorkout {
                    Rectangle()
                        .fill(.clear)
                }else{
                    Rectangle()
                        .fill(.ultraThickMaterial)
                        .overlay {
                            WorkoutInfo(workout: workout, expandWorkout: $expandWorkout, animation: animation)
                        }
                        .matchedGeometryEffect(id: "BGView", in: animation)
                }
            }
            .frame(height: 70)
            .overlay(alignment: .bottom, content: {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .frame(height: 1)
            })
            .offset(y:-49)
        }
    }
}
#Preview {
    BottomNavBar()
        .environmentObject(WorkoutManager())
        .modelContainer(previewContainer)
}
