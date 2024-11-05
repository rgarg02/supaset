//
//  ExerciseTemplate.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import Foundation
import SwiftData
@Model
class TemplateEInfo {
    @Attribute(.unique) var id: UUID
    var exerciseID: String
    var numberOfSets: Int
    var index : Int
    var template : WorkoutTemplate? = nil
    init(id: UUID = UUID(), exerciseID: String = "", numberOfSets: Int = 0, index : Int = 0) {
        self.id = id
        self.exerciseID = exerciseID
        self.numberOfSets = numberOfSets
        self.index = index
    }
}
