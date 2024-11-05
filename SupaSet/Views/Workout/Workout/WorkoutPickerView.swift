//
//  WorkoutPickerView.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/27/24.
//

import SwiftUI

struct MuscleFilterPicker: View {
    @Binding var selectedMuscle: String?
    let muscles =  [
        "abdominals",
        "abductors",
        "adductors",
        "biceps",
        "calves",
        "chest",
        "forearms",
        "glutes",
        "hamstrings",
        "lats",
        "lower back",
        "middle back",
        "neck",
        "quadriceps",
        "shoulders",
        "traps",
        "triceps"
    ]

    var body: some View {
        Picker("Muscle", selection: $selectedMuscle) {
            Text("All Muscles").tag(nil as String?)
            ForEach(muscles, id: \.self) { muscle in
                Text(muscle.capitalized).tag(muscle as String?)
            }
        }
    }
}

struct CategoryFilterPicker: View {
    @Binding var selectedCategory: String?
    let category =  [
        "powerlifting",
                "strength",
                "stretching",
                "cardio",
                "olympic weightlifting",
                "strongman",
                "plyometrics"
    ]

    var body: some View {
        Picker("Category", selection: $selectedCategory) {
            Text("All Category").tag(nil as String?)
            ForEach(category, id: \.self) { category in
                Text(category.capitalized).tag(category as String?)
            }
        }
    }
}
