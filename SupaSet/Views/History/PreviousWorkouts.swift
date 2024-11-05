//
//  PreviousWorkouts.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/3/24.
//

import SwiftUI
import SwiftData



struct PreviousWorkouts: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var workoutManager : WorkoutManager
    @Query(filter: #Predicate<Workout> {$0.isFinished == true},
           sort:\Workout.date, order: .reverse) var workouts : [Workout]
    var body: some View {
        NavigationView{
            VStack{
                //            Button {
                //                for workout in workouts {
                //                    context.delete(workout)
                //                }
                //            } label: {
                //                Text("DELETE ALL WORKOUTS")
                //            }
                //            Text("Workout History")
                //                .padding()
                //                .font(.title)
                ScrollView{
                    ForEach (workouts) { workout in
                        VStack{
                            WorkoutDetailView(workout: workout)
                        }
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack{
                        Text("Workout History")
                            .foregroundStyle(Color.gray)
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding()
                }
            }
            .safeAreaPadding()
        }
    }
    
}

#Preview {
    PreviousWorkouts()
        .environmentObject(WorkoutManager())
        .modelContainer(previewContainer)
}
