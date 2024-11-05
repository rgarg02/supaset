//
//  Home+getData.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/27/24.
//

import Foundation
import HealthKit

extension Home  {
    func loadWeeklyStepsData() {
        healthStore.fetchWeeklySteps { samples in
            guard let samples = samples else {
                return
            }
            
            let stepsPerDay = processSteps(samples: samples)
            var weeklySteps = [Int]()
            
            let lastWeekDates = getLastWeekDates()
            for date in lastWeekDates {
                let steps = Int(stepsPerDay[date] ?? 0)
                weeklySteps.append(steps)
            }
            
            DispatchQueue.main.async {
                self.weeklySteps = weeklySteps
            }
        }
    }
    func processSteps(samples: [HKQuantitySample]) -> [Date: Double] {
        var stepsPerDay = [Date: Double]()
        
        let calendar = Calendar.current
        for sample in samples {
            let date = calendar.startOfDay(for: sample.startDate)
            let steps = sample.quantity.doubleValue(for: HKUnit.count())
            stepsPerDay[date, default: 0] += steps
        }
        
        return stepsPerDay
    }
    func getLastWeekDates() -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).map { calendar.date(byAdding: .day, value: -$0, to: today)! }.reversed()
    }
}
