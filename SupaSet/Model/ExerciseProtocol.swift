//
//  ExerciseProtocol.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import Foundation
import SwiftData
protocol ExerciseFunctions {
    associatedtype ExerciseInfoType : PersistentModel
    
    var exercisesID: [String] { get }
    mutating func addExercise(exerciseID id: String)

    mutating func removeExercise(exerciseID: String)
    
    mutating func moveExercises(from source: IndexSet, to destination: Int)
    
    mutating func updateExerciseIndexes()
    
    func getExerciseInfo(by exerciseID: String) -> ExerciseInfoType?
}
