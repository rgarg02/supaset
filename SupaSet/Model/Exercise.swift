//
//  Exercise.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import Foundation
import SwiftData

enum Force: String, Codable, CaseIterable {
    case stationary = "static"
    case pull
    case push
}
enum Level: String, Codable, CaseIterable {
    case beginner = "beginner"
    case intermediate = "intermediate"
    case expert = "expert"
}

enum Mechanic: String, Codable, CaseIterable {
    case isolation = "isolation"
    case compound = "compound"
}

enum Equipment: String, Codable, CaseIterable {
    case medicineBall = "medicine ball"
    case dumbbell = "dumbbell"
    case bodyOnly = "body only"
    case bands = "bands"
    case kettlebells = "kettlebells"
    case foamRoll = "foam roll"
    case cable = "cable"
    case machine = "machine"
    case barbell = "barbell"
    case exerciseBall = "exercise ball"
    case eZCurlBar = "e-z curl bar"
    case other = "other"
}

enum Muscle: String, Codable, CaseIterable, Identifiable {
    var id: Self {self}
    
    case none
    case abdominals, abductors, adductors, biceps, calves, chest, forearms
    case glutes, hamstrings, lats, lowerBack = "lower back"
    case middleBack = "middle back", neck, quadriceps, shoulders, traps, triceps
}

enum Category: String, Codable, CaseIterable {
    case powerlifting, strength, stretching, cardio
    case olympicWeightlifting = "olympic weightlifting"
    case strongman, plyometrics
}
struct Exercise: Codable, Identifiable, Equatable, Hashable {
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
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
}

@Model
class EInfo {
    @Attribute(.unique) var id: UUID
    var exerciseID: String
    @Relationship(deleteRule: .cascade)
    var sets: [ESet]
    var index : Int
    var workout: Workout? = nil
    init(id: UUID = UUID(), exerciseID: String = "", sets: [ESet] = [], index : Int = 0) {
        self.id = id
        self.exerciseID = exerciseID
        self.sets = sets
        self.index = index
    }
    func isCompleted()->Bool{
        return sets.allSatisfy { $0.done } && sets.count > 0
    }
    func addSets(weight : Double, reps: Int){
        let set = ESet(index: sets.count, weight: weight, reps: reps, done: false)
        sets.append(set)
    }
}

@Model
class ESet {
    @Attribute(.unique) var id: UUID
    var index: Int
    var weight: Double
    var weight_ : Double{
        get {weight}
        set {weight = newValue}
    }
    var reps: Int
    var done: Bool = false
    var exercise: EInfo?
    init(id: UUID = UUID(), index: Int = 0, weight: Double = 0, reps: Int = 0, done: Bool = false) {
        self.id = id
        self.index = index
        self.weight = weight
        self.reps = reps
        self.done = done
    }
    
}
