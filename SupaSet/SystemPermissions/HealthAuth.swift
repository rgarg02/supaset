//
//  HealthAuth.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/22/24.
//

import Foundation
import HealthKit
import CoreLocation
import SwiftUI
class HealthStore: NSObject, ObservableObject, CLLocationManagerDelegate {
    var healthStore = HKHealthStore()
    @Published var activities : [String : Activity] = [:]
    var healthStatus : Color {

        let status = healthStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .stepCount)!)
        switch status {
        case .notDetermined:
            return Color.gray
        case .sharingDenied:
            return Color.red
        case .sharingAuthorized:
            return Color.green
        @unknown default:
            return Color.gray
        }
    }
    let healthDataToRead: Set<HKObjectType> = {
        var types = Set([
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .height)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .leanBodyMass)!
        ])
        // Nutrition data types
        let nutritionalTypesIdentifiers: [HKQuantityTypeIdentifier] = [
            .dietaryFatTotal, .dietaryProtein, .dietaryCarbohydrates, .dietaryFiber,
            .dietarySugar, .dietaryCholesterol, .dietarySodium, .dietaryWater,
            .dietaryVitaminA, .dietaryVitaminC, .dietaryCalcium, .dietaryIron
        ]
        nutritionalTypesIdentifiers.forEach { identifier in
            if let type = HKObjectType.quantityType(forIdentifier: identifier) {
                types.insert(type)
            }
        }
        return types
    }()
    let typesToWrite: Set = [
            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        ]
    
    func requestHealthPermissions() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device.")
            return
        }
        healthStore.requestAuthorization(toShare: typesToWrite, read: healthDataToRead) { (success, error) in
            if !success {
                print("Error requesting HealthKit authorization: \(String(describing: error))")
            }
        }
    }
}
