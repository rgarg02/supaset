//
//  WorkoutTemplate.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import Foundation
import SwiftData
@Model
class WorkoutTemplate {
    @Attribute(.unique) var id: UUID
    var name : String
    @Relationship(deleteRule: .cascade,  inverse: \TemplateEInfo.template)
    var exercises: [TemplateEInfo]
    var isEditing : Bool
    init(id: UUID = UUID(), name: String = "New Template", exercises: [TemplateEInfo] = [], isEditing : Bool = true) {
        self.id = id
        self.name = name
        self.exercises = exercises
        self.isEditing = isEditing
    }
    
    func orderedExercises() -> [TemplateEInfo] {
        return exercises.sorted(by: { $0.index < $1.index })
    }
    

}
extension WorkoutTemplate : ExerciseFunctions {
    typealias ExerciseInfoType = TemplateEInfo
    
    func getExerciseInfo(by exerciseID: String) -> TemplateEInfo? {
        return exercises.first { $0.exerciseID == exerciseID }
        }
    
    var exercisesID: [String] {
        return exercises.map { $0.exerciseID }
    }
    func addExercise(exerciseID id: String) {
        let exercise = TemplateEInfo(exerciseID: id, numberOfSets: 3)
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
                    for i in sourceIndex + 1...destinationIndex {
                        if let exercise = exercises.first(where: { $0.index == i }) {
                            print(exercise.exerciseID)
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
