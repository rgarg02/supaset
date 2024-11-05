//
//  MeasurementManager.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import SwiftUI
import Combine


class MeasurementManager: ObservableObject {
    @Published var measurements: [MuscleMeasurement: Float]

    init() {
        // First, try to load measurements from UserDefaults
        if let loadedMeasurements = UserDefaults.standard.loadMeasurements() {
            measurements = loadedMeasurements
        } else {
            // If there is nothing in UserDefaults, set up default values
            var defaultMeasurements = [MuscleMeasurement: Float]()
            MuscleMeasurement.allCases.forEach { muscle in
                defaultMeasurements[muscle] = 0
            }
            measurements = defaultMeasurements
            saveMeasurements() // Save the default measurements to UserDefaults
        }
    }
    
    func binding(for muscle: MuscleMeasurement) -> Binding<Float> {
        Binding<Float>(
            get: { self.measurements[muscle, default: 0] },
            set: { newValue in
                       self.measurements[muscle] = newValue
                       self.saveMeasurements()  // Save to UserDefaults whenever a measurement is updated.
                   }
        )
    }
    func value(for muscle: MuscleMeasurement) -> Float{
        return measurements[muscle] ?? 0
    }
    func saveMeasurements() {
        UserDefaults.standard.saveMeasurements(measurements)
    }
}

// UserDefaults extension to handle the encoding and decoding of complex types
extension UserDefaults {
    func saveMeasurements(_ measurements: [MuscleMeasurement: Float]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(measurements.mapKeys { $0.rawValue }) {
            set(encoded, forKey: "Measurements")
        }
    }
    
    func loadMeasurements() -> [MuscleMeasurement: Float]? {
        if let data = data(forKey: "Measurements") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([String: Float].self, from: data) {
                return decoded.mapKeys { MuscleMeasurement(rawValue: $0)! }
            }
        }
        return nil
    }
}

// Dictionary extension to map keys
extension Dictionary {
    func mapKeys<NewKey: Hashable>(_ transform: (Key) -> NewKey) -> [NewKey: Value] {
        var newDictionary = [NewKey: Value]()
        for (key, value) in self {
            newDictionary[transform(key)] = value
        }
        return newDictionary
    }
}

