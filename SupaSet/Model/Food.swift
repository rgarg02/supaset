//
//  Food.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/29/24.
//

import Foundation
import SwiftData
struct FoodSearchResults: Codable {
    let foods: [FoodItem]
}
let nutrientIDs = [
    1008, // Calories
    1004, // Total Fat
    1258, // Saturated Fat
    1253, // Cholesterol
    1093, // Sodium
    1005, // Total Carbohydrates
    1079, // Dietary Fiber
    2000, // Total Sugars
    1003, // Protein
    1114, // Vitamin D
    1087, // Calcium
    1089, // Iron
    1092  // Potassium
]
struct FoodPortion: Codable {
    let amount: Double
    let measureUnit: String
    let gramWeight: Double
}
struct FoodItem: Codable {
    let foodDescription: String
    let fdcId: Int
    let foodNutrients: [Nutrient]
    let foodPortions: [FoodPortion]?
    let servingSize : Double?
    let servingSizeUnit : String?
    enum CodingKeys: String, CodingKey {
        case foodDescription = "description"
        case fdcId
        case foodNutrients
        case foodPortions
        case servingSize
        case servingSizeUnit
    }
}

struct Nutrient: Codable {
    let nutrientId: Int
    let nutrientName: String
    let nutrientNumber: String
    let value: Double
    let unitName : String
}

@Model
class FoodLog {
    var name : String
    var serving : Double
    var nutrients : NutritionalInfo?
    var date : Date
    var mealType : MealType
    var servingSizeUnit : String
    init(name: String, serving: Double, nutrients: NutritionalInfo, date: Date = Date(), mealType : MealType = MealType.determineMealTime(from: Date()), servingSizeUnit: String) {
        self.name = name
        self.serving = serving
        self.nutrients = nutrients
        self.date = date
        self.mealType = mealType
        self.servingSizeUnit = servingSizeUnit
    }
    
}

enum MealType : String, Codable, CaseIterable {
    case breakfast, lunch, dinner, snack
    static func determineMealTime(from date: Date) -> MealType {
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 5...10:
            return .breakfast
        case 11...16:
            return .lunch
        case 17...21:
            return .dinner
        default:
            return .snack
        }
    }
    
    
}
extension FoodLog {
    
    static func currentPredicate() -> Predicate<FoodLog> {
        let currentDate = Date.now
        
        return #Predicate<FoodLog> { food in
            food.date > currentDate
        }
    }
}
