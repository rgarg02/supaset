//
//  ExerciseDB.swift
//  FinalProject
//
//  Created by Rishi Garg on 5/7/24.
//

import Foundation
import SwiftData

@Model
class PersistentExercise {
    var id: String
    var name: String
    var force: Force?
    var level: Level
    var mechanic: Mechanic?
    var equipment: Equipment?
    var primaryMuscles: [Muscle]
    var secondaryMuscles: [Muscle]
    var instructions: [String]
    var category: Category
    var images: [String]
    var frequency : Int?
    init(id: String, name: String, force: Force? = nil, level: Level, mechanic: Mechanic? = nil, equipment: Equipment? = nil, primaryMuscles: [Muscle], secondaryMuscles: [Muscle], instructions: [String], category: Category, images: [String], frequency: Int? = nil) {
        self.id = id
        self.name = name
        self.force = force
        self.level = level
        self.mechanic = mechanic
        self.equipment = equipment
        self.primaryMuscles = primaryMuscles
        self.secondaryMuscles = secondaryMuscles
        self.instructions = instructions
        self.category = category
        self.images = images
        self.frequency = frequency
    }
}

