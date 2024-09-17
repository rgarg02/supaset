//
//  Widgets.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/14/24.
//

import Foundation
import SwiftData
import SwiftUI

enum Focus: String, CaseIterable, Identifiable, Codable, Hashable {
    var id: Self {self}
    case exercise
    case workout
}


struct ProgressionDetail : Codable{
    var oneRepMax : Bool = false
    var volumeIncrease : Bool = false
    var duration: Bool = false
//    var timeOfDay: Bool = false
//    var rpe: Bool = false
//    var heartRateData: Bool = false
//    var caloriesBurned: Bool = false
//    var mood: Bool = false
//    var sleepHoursNightBefore: Bool = false
    mutating func toggle(property: ProgressionDetailProperty) {
        switch property {
        case .oneRepMax:
            oneRepMax.toggle()
        case .volumeIncrease:
            volumeIncrease.toggle()
        case .duration:
            duration.toggle()
//        case .timeOfDay:
//            timeOfDay.toggle()
//        case .rpe:
//            rpe.toggle()
//        case .heartRateData:
//            heartRateData.toggle()
//        case .caloriesBurned:
//            caloriesBurned.toggle()
//        case .mood:
//            mood.toggle()
//        case .sleepHoursNightBefore:
//            sleepHoursNightBefore.toggle()
        }
    }
    func isSet(property: ProgressionDetailProperty) -> Bool {
        switch property {
        case .oneRepMax:
            return oneRepMax
        case .volumeIncrease:
            return volumeIncrease
        case .duration:
            return duration
//        case .timeOfDay:
//            return timeOfDay
//        case .rpe:
//            return rpe
//        case .heartRateData:
//            return heartRateData
//        case .caloriesBurned:
//            return caloriesBurned
//        case .mood:
//            return mood
//        case .sleepHoursNightBefore:
//            return sleepHoursNightBefore
        }
    }
    func getSetData(for property: ProgressionDetailProperty, sets : [ESet]) -> [Date: Double]{
        let setsByDate = Dictionary(grouping: sets) { set in
            Calendar.current.startOfDay(for: set.exercise?.workout?.date ?? Date())
        }
        switch property{
        case .oneRepMax:
                let maxSetsPerDay = setsByDate.mapValues { dailySets in
                    dailySets.max(by: { $0.weight < $1.weight })!.weight
                }
                return maxSetsPerDay
        case .volumeIncrease:
            let volume = setsByDate.mapValues { dailySets in
                dailySets.reduce(0){ total, set in
                    total + Double(set.reps) * set.weight
                }
            }
            return volume
        case .duration:
            var durations: [Date: Double] = [:] // Using Double to represent duration
            
            for (date, dailySets) in setsByDate {
                if let firstSet = dailySets.first,
                   let workout = firstSet.exercise?.workout {
                    let startDate = workout.date
                    let endDate = workout.endDate
                    
                    let duration = endDate.timeIntervalSince(startDate) // Duration in seconds
                    durations[date] = duration
                }
            }
            return durations
//        case .timeOfDay:
//            return [:]
//        case .rpe:
//            return [:]
//        case .heartRateData:
//            return [:]
//        case .caloriesBurned:
//            return [:]
//        case .mood:
//            return [:]
//        case .sleepHoursNightBefore:
//            return [:]
        }
    }
}
enum moodType: Codable {
    case happy, neutral, stressed, sad
}
struct Mood : Codable{
    var before : moodType
    var after : moodType
    
}
struct HeartRateData : Codable{
    var peak: Int
    var average: Int
}

@Model
class WorkoutWidget {
    let id : UUID
    var index: Int
    var name: String
    var focus: Focus
    var progressionID : String
    var progressionDetail: ProgressionDetail
    var isEditing: Bool
    init(id: UUID = UUID(), index: Int = 0, name : String = "New Focus", focus: Focus = .exercise, progressionID: String = "", progressionDetail: ProgressionDetail = .init(), isEditing: Bool = true) {
        self.id = id
        self.index = index
        self.name = name
        self.focus = focus
        self.progressionID = progressionID
        self.progressionDetail = progressionDetail
        self.isEditing = isEditing
    }
}

enum ProgressionDetailProperty: String, CaseIterable, Identifiable {
    case oneRepMax
    case volumeIncrease
    case duration
//    case timeOfDay
//    case rpe
//    case heartRateData
//    case caloriesBurned
//    case mood
//    case sleepHoursNightBefore
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .oneRepMax: return "One Rep Max"
        case .volumeIncrease: return "Volume Increase"
        case .duration: return "Duration of Workout"
//        case .timeOfDay: return "Time of Day"
//        case .rpe: return "Rate of Perceived Exertion (RPE)"
//        case .heartRateData: return "Heart Rate Data"
//        case .caloriesBurned: return "Calories Burned"
//        case .mood: return "Mood"
//        case .sleepHoursNightBefore: return "Sleep Hours the Night Before"
        }
    }
    var color: Color {
           switch self {
           case .oneRepMax: return .red
           case .volumeIncrease: return .green
           case .duration: return .orange
//           case .timeOfDay: return .purple
//           case .rpe: return .pink
//           case .heartRateData: return .teal
//           case .caloriesBurned: return .gray
//           case .mood: return .indigo
//           case .sleepHoursNightBefore: return .brown
           }
       }
}
