//
//  Workout.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/22/24.
//

import Foundation
import SwiftData
import SwiftUI
import UniformTypeIdentifiers


@Model
class Workout {
    @Attribute(.unique) var id: UUID
    var date: Date
    var endDate: Date
    var name : String
    @Relationship(deleteRule: .cascade)
    var exercises: [EInfo]
    var isFinished: Bool
    var orders: [Int]
    init(id: UUID = UUID(), date: Date = Date.now, endDate: Date = Date.now, name: String = "New Workout", exercises: [EInfo] = [], isFinished: Bool = false) {
        self.id = id
        self.date = date
        self.name = name
        self.exercises = exercises
        self.isFinished = isFinished
        self.orders = []
        self.endDate = endDate
    }
    func orderedExercises() -> [EInfo] {
        return exercises.sorted(by: { $0.index < $1.index })
    }
    func updateWithTemplate(template : WorkoutTemplate) {
        name = template.name
        for exercise in template.exercises {
            var sets : [ESet] = []
            for _ in 0..<exercise.numberOfSets {
                let set = ESet(index: sets.count, done: false)
                sets.append(set)
            }
            self.addExercise(exerciseID: exercise.exerciseID)
            self.exercises.first(where: {$0.exerciseID == exercise.exerciseID})?.sets = sets
        }
    }
}




extension Workout : ExerciseFunctions {
    typealias ExerciseInfoType = EInfo
    func getExerciseInfo(by exerciseID: String) -> EInfo? {
        return exercises.first { $0.exerciseID == exerciseID }
        }
    var exercisesID: [String] {
        return exercises.map { $0.exerciseID }
    }
    
    func addExercise(exerciseID id: String) {
        let exercise = EInfo(exerciseID: id)
        exercise.index = exercises.count
        exercises.append(exercise)
    }
    
    func removeExercise(exerciseID: String) {
        guard let index = exercises.firstIndex(where: { $0.exerciseID == exerciseID }) else { return }
        exercises.remove(at: index)
        updateExerciseIndexes()
    }
    
    func moveExercises(from source: IndexSet, to destination: Int) {
        guard let sourceIndex = source.first else { return }
        // Calculate the target index for the move
        let destinationIndex = destination > sourceIndex ? destination - 1 : destination
        // Ensure that the source and destination are not the same
        if sourceIndex != destinationIndex {
            // Assume exercises are already sorted by index or are in a consistent order
            if let movingExercise = exercises.first(where: { $0.index == sourceIndex }) {
                // Update the index for the moving exercise
                if sourceIndex < destinationIndex {
                    // Shift indices down for exercises between sourceIndex and destinationIndex
                    for i in sourceIndex + 1...destinationIndex {
                        if let exercise = exercises.first(where: { $0.index == i }) {
                            exercise.index -= 1
                        }
                    }
                } else {
                    // Shift indices up for exercises between destinationIndex and sourceIndex
                    for i in (destinationIndex..<sourceIndex).reversed() {
                        if let exercise = exercises.first(where: { $0.index == i }) {
                            exercise.index += 1
                        }
                    }
                }
                movingExercise.index = destinationIndex
            }
        }
    }
    
    func updateExerciseIndexes() {
        let sortedExercises = exercises.sorted(by: { $0.index < $1.index })
        for (newIndex, exercise) in sortedExercises.enumerated() {
            exercise.index = newIndex
        }
        exercises = sortedExercises
    }
}


