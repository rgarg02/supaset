//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/20/24.
//

import SwiftUI
import SwiftData
extension UserDefaults {
    var welcomeScreenShow : Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShow") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShow")
        }
    }
}

@main
struct FinalProjectApp: App {
    @StateObject var workoutManager = WorkoutManager()
    @StateObject var healthStore = HealthStore()
    @StateObject var destinationManager = DestinationViewModel()
    @StateObject var userManager = UserManager()
    @StateObject var measurementManager = MeasurementManager()
    let container: ModelContainer = {
        let schema = Schema([Workout.self, WorkoutTemplate.self, WorkoutWidget.self, FoodLog.self, PersistentExercise.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    @AppStorage("hasShownWelcomeScreen") var hasShownWelcomeScreen: Bool = false
    var body: some Scene {
        WindowGroup {
            if hasShownWelcomeScreen {
                BottomNavBar()
                    .environmentObject(workoutManager)
                    .environmentObject(healthStore)
                    .environmentObject(destinationManager)
                    .environmentObject(userManager)
                    .environmentObject(measurementManager)
                    .modelContainer(previewContainer)
                    
            } else {
                WelcomeScreenView()
                    .environmentObject(workoutManager)
                    .environmentObject(healthStore)
                    .environmentObject(destinationManager)
                    .environmentObject(userManager)
                    .environmentObject(measurementManager)
                    .modelContainer(previewContainer)
            }
        }
    }
}
