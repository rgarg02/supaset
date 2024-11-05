//
//  PreviewSampleData.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/15/24.
//

import Foundation
import SwiftData

let previewContainer: ModelContainer = {
    do {
    let schema = Schema([
        Workout.self, WorkoutTemplate.self, WorkoutWidget.self, FoodLog.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        Task { @MainActor in
            let context = container.mainContext
            let widget1 = WorkoutWidget(index: 0, name: "My Widget", focus: .exercise, progressionID: "3_4_Sit-Up", progressionDetail: ProgressionDetail(oneRepMax: true, volumeIncrease: true), isEditing: false)
            let widget2 = WorkoutWidget(index: 1, name: "My Widget", focus: .exercise, progressionID: "90_90_Hamstring", progressionDetail: ProgressionDetail(oneRepMax: true, volumeIncrease: true), isEditing: false)
            let widget3 = WorkoutWidget(index: 2, name: "My Widget", focus: .exercise, progressionID: "Ab_Crunch_Machine", progressionDetail: ProgressionDetail(oneRepMax: true, volumeIncrease: true), isEditing: false)
            context.insert(widget1)
            context.insert(widget2)
            context.insert(widget3)
            for i in 0..<10{
                let offsetDate = Calendar.current.date(byAdding: .day, value: -i, to: Date.now)!
                let workout = Workout(id: UUID(), date: offsetDate, endDate: offsetDate.addingTimeInterval(TimeInterval(100*i+2000)), name: "Sample \(i+1)", exercises: [], isFinished: true)
                let eInfo1 = EInfo(id: UUID(), exerciseID: "3_4_Sit-Up", sets: [], index: 0)
                let eInfo2 = EInfo(id: UUID(), exerciseID: "90_90_Hamstring", sets: [], index: 1)
                let eInfo3 = EInfo(id: UUID(), exerciseID: "Ab_Crunch_Machine", sets: [], index: 2)
                context.insert(workout)
                workout.exercises.append(eInfo1)
                workout.exercises.append(eInfo2)
                workout.exercises.append(eInfo3)
                for i in 0..<3 {
                    eInfo1.addSets(weight: (Double.random(in: 40..<150)), reps: Int.random(in: 1..<5))
                    eInfo2.addSets(weight: Double.random(in: 40..<150), reps: Int.random(in: 1..<5))
                    eInfo3.addSets(weight: Double.random(in: 40..<150), reps: Int.random(in: 1..<5))
                }
                try? context.save()
            }
        }
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
     
}()
