//
//  MuscleGroups.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import Foundation

struct MuscleGroups {
    static let muscleMappings: [Muscle: [String]] = [
        .abdominals: ["Abdominales", "Oblicuos"],
        .forearms: ["Antebrazo2", "Antebrazo3", "Antebrazo4", "Antebrazo_ext", "Antebrazo_int", "Antebrazo_int1", "Codo"],
        .shoulders: ["Bajo_hombro1", "Bajo_hombro2", "Bajo_hombro3", "Deltoides"],
        .biceps: ["Biceps"],
        .chest: ["Pectoral"],
        .lats:["Lumbar"],
        .lowerBack: ["Cintura1", "Cintura2", "Lumbar"],
        .neck: ["Cuello1", "Cuello2", "Cuello3", "Cuello4"],  // Assuming 'Cara' mainly affects neck visibility
        .glutes: ["Culo"],
        .quadriceps: ["Muslo", "Muslo2", "Muslo8", "Muslo9"],
        .abductors: ["Muslo3", "Muslo7"],
        .hamstrings: ["Muslo4", "Muslo5", "Muslo6"],
        .calves: ["Pierna2", "Pierna3"],
        .traps: ["Trapecio"],
        .triceps: ["Triceps", "Triceps2"],
//        .none: ["Brazoextra", "Garra", "Modelado_Musculos_Cuerpo_12_ZTL50DF832D_5F4A_494F_BFFB__13355e7", "Muslo10", "Muslo11", "Muslo12", "Pierna1", "Pierna4", "Pierna5", "Cara"]  // Including 'none' for muscles that aren't clearly categorized or are placeholders
    ]
    static func muscleForValue(_ value: String) -> Muscle? {
            for (muscle, values) in muscleMappings {
                if values.contains(value) {
                    return muscle
                }
            }
            return nil // Return nil if the value is not found
        }
    static let locationMappings: [Muscle: Int] = [
        //1 -> back, -1 -> front
        .abdominals: -1,
        .forearms: -1,
        .shoulders: 1,
        .biceps: -1,
        .chest: -1,
        .lats: 1,
        .lowerBack: 1,
        .neck: -1,
        .glutes: 1,
        .quadriceps: -1,
        .abductors: 1,  // Since abductors are located on the side of the thighs
        .hamstrings: 1,
        .calves: 1,
        .traps: 1,
        .triceps: 1,
        .none: 0
    ]
    
    // Method to get the location of a muscle group
    static func getLocation(of muscle: Muscle) -> Int {
        return locationMappings[muscle] ?? 0
    }
}
