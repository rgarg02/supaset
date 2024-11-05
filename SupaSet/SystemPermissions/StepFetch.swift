//
//  StepFetch.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/22/24.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}
extension Double {
    func formattedCommaString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
extension HealthStore {
    func updateActivities() {
        let types = [
            (type: HKQuantityType.quantityType(forIdentifier: .stepCount)!, identifier: "dailySteps", title: "Daily Steps", subTitle: "Goal: 10,000", image: "figure.walk", unit: HKUnit.count(), format: "steps"),
            (type: HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!, identifier: "caloriesConsumed", title: "Calories Consumed", subTitle: "Eat healthy", image: "flame", unit: HKUnit.kilocalorie(), format: "kcal"),
            (type: HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!, identifier: "basalCaloriesBurned", title: "Basal Calories Burned", subTitle: "Resting metabolism", image: "bed.double", unit: HKUnit.kilocalorie(), format: "kcal"),
            (type: HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!, identifier: "activeCaloriesBurned", title: "Active Calories Burned", subTitle: "Stay active", image: "figure.run", unit: HKUnit.kilocalorie(), format: "kcal")
        ]
        
        for typeInfo in types {
            let predicate = HKQuery.predicateForSamples(withStart: Date.startOfDay, end: Date())
            let query = HKStatisticsQuery(quantityType: typeInfo.type, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                guard let quantity = result?.sumQuantity(), error == nil else {
                    print("Error fetching \(typeInfo.identifier)")
                    return
                }
                let value = quantity.doubleValue(for: typeInfo.unit)
                let formattedValue = value.formattedCommaString() + " " + typeInfo.format
                let activity = Activity(id: 0, title: typeInfo.title, subTitle: typeInfo.subTitle, image: typeInfo.image, amount: formattedValue)
                DispatchQueue.main.async {
                    self.activities[typeInfo.identifier] = activity
                }
            }
            healthStore.execute(query)
        }
    }
    func fetchWeeklySteps(completion: @escaping ([HKQuantitySample]?) -> Void) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(nil)
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: stepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (_, results, error) in
            guard let samples = results as? [HKQuantitySample], error == nil else {
                completion(nil)
                return
            }
            completion(samples)
        }
        
        healthStore.execute(query)
    }
    func getTotalDistance(completion: @escaping (Double) -> Void) {
        guard let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            fatalError("Something went wrong retriebing quantity type distanceWalkingRunning")
        }
        
        let startOfYear = Calendar.current.date(from: Calendar.current.dateComponents([.year], from: .now))!
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfYear, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
            var value: Double = 0
            
            if error != nil {
                print("something went wrong")
            } else if let quantity = statistics?.sumQuantity() {
                value = quantity.doubleValue(for: HKUnit.mile())
            }
            DispatchQueue.main.async {
                completion(value)
            }
        }
        healthStore.execute(query)
    }
    func addCaloriesToHealthKit(calories: Double, date: Date) {
        guard let calorieType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed) else {
            print("Calorie Type is unavailable")
            return
        }

        let quantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: calories)
        let calorieSample = HKQuantitySample(type: calorieType, quantity: quantity, start: date, end: date)

        healthStore.save(calorieSample) { success, error in
            if success {
                print("Calories successfully saved")
            } else {
                print("Error saving calories: \(String(describing: error))")
            }
        }
    }
}
