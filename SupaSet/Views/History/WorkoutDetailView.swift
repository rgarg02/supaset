//
//  WorkoutDetailView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/11/24.
//

import SwiftUI

struct WorkoutDetailView: View {
    var workout : Workout
    @EnvironmentObject var workoutManager : WorkoutManager
    var body: some View {
        VStack{
            HStack{
                Text(workout.name)
                    .foregroundStyle(Color.fourth)
                Spacer()
                Text(formatDate(date: workout.date))
            }
            HStack{
                Text("\(Int(totalVolume(workout: workout))) lb")
                Spacer()
                Image(systemName: "clock.fill")
                Text("\(Int(workout.endDate.timeIntervalSince(workout.date)/60))m")
            }
            HStack{
                Text("Exercise")
                Spacer()
                Text("Highest Volume")
            }
            VStack{
                ForEach(workout.orderedExercises()) {exercise in
                    HStack{
                        Text(String(format: "%d x %@",exercise.sets.count,workoutManager.exerciseName(for: exercise.exerciseID)))
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer()
                        Text(String(format: "%.1flbs x %d", highestVolume(exercise: exercise).weight, highestVolume(exercise: exercise).reps))
                            .lineLimit(1)
//                        Text("exercise name : \(exercise.sets.first?.exercise?.exerciseID)")
                    }
                }
            }
        }
        .safeAreaPadding()
        .foregroundStyle(Color.white)
        .background(Color.first)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
func totalVolume(workout: Workout) -> Double {
        workout.exercises.reduce(0) { total, exercise in
            total + exercise.sets.reduce(0) { subtotal, set in
                subtotal + (set.weight * Double(set.reps))
            }
        }
    }
func highestVolume(exercise: EInfo) -> ESet{
    exercise.sets.max { ($0.weight * Double($0.reps)) < ($1.weight * Double($1.reps)) } ?? ESet()
   }
func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        // Example format: "E, MMM d" -> "Tue, Jan 1"
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: date)
    }
struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sets = [ESet(weight: 10,reps: 10),ESet(weight: 80,reps: 10),ESet(weight: 50,reps: 10)]
        let einfo = [EInfo(exerciseID: "Lat Pulldown",sets : sets),EInfo(exerciseID: "Lat Pulldown",sets : sets),EInfo(exerciseID: "Lat Pulldown",sets : sets),EInfo(exerciseID: "Lat Pulldown",sets : sets)]
        let workout = Workout(id: UUID(), date: Date.now, endDate: Date.now.addingTimeInterval(1000),name: "New Workout", exercises: einfo, isFinished: true)
        WorkoutDetailView(workout: workout)
    }
}
