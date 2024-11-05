//
//  UserManager.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/25/24.
//

import Foundation
class UserManager: ObservableObject {
    @Published var userProfile: UserProfile
    init() {
        self.userProfile = UserProfile(name: "John Doe", weight: 170)
    }

    func updateWeight(_ weight: Double) {
        userProfile.weight = weight
    }

    func updateGoalWeight(_ goalWeight: Double) {
        userProfile.goalWeight = goalWeight
    }

    func updateGoalDailySteps(_ goalSteps: Int) {
        userProfile.goalDailySteps = goalSteps
    }

    func updateGoalCalorieIntake(_ goalCalories: Int) {
        userProfile.goalCalorieIntake = goalCalories
    }
}
