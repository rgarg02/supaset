//
//  NetworkManager.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/23/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let apiKey = "8j0LSNEtVI77SinaWE6Q7Gv82y31QlYJ0OOofGjy"
    let baseURL = "https://api.nal.usda.gov/fdc/v1/foods/search"
    
    func fetchFoodData(query: String, completion: @escaping (Result<[FoodItem], Error>) -> Void) {
        let dataTypeFilter = "Branded"
        guard let url = URL(string: "\(baseURL)?query=\(query)&dataType=\(dataTypeFilter)&api_key=\(apiKey)&format=full") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            do {
                let searchResults = try JSONDecoder().decode(FoodSearchResults.self, from: data)
                let filteredFoods = searchResults.foods.map { foodItem -> FoodItem in
                    let filteredNutrients = foodItem.foodNutrients.filter { nutrient in
                        nutrientIDs.contains(nutrient.nutrientId)
                    }
                    print(foodItem.servingSize ?? "")
                    return FoodItem(foodDescription: foodItem.foodDescription, fdcId: foodItem.fdcId, foodNutrients: filteredNutrients, foodPortions: foodItem.foodPortions, servingSize: foodItem.servingSize, servingSizeUnit: foodItem.servingSizeUnit)
                }
                completion(.success(filteredFoods))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

extension FoodItem {
    var nutritionalInfo: NutritionalInfo {
        return NutritionalInfo(from: foodNutrients)
    }
    var nutrientsArray: [(name: String, value: Double?)] {
        [
            ("Calories", nutritionalInfo.calories),
            ("Total Fat", nutritionalInfo.totalFat),
            ("Saturated Fat", nutritionalInfo.saturatedFat),
            ("Trans Fat", nutritionalInfo.transFat),
            ("Cholesterol", nutritionalInfo.cholesterol),
            ("Sodium", nutritionalInfo.sodium),
            ("Total Carbohydrates", nutritionalInfo.totalCarbohydrates),
            ("Dietary Fiber", nutritionalInfo.dietaryFiber),
            ("Total Sugars", nutritionalInfo.totalSugars),
            ("Protein", nutritionalInfo.protein),
            ("Vitamin D", nutritionalInfo.vitaminD),
            ("Calcium", nutritionalInfo.calcium),
            ("Iron", nutritionalInfo.iron),
            ("Potassium", nutritionalInfo.potassium)
        ]
    }
}
// Nutritional information closely aligned with U.S. Nutrition Facts labels
struct NutritionalInfo: Codable {
    var calories: Double?       // Energy in kcal
    var totalFat: Double?       // Total fat in grams
    var saturatedFat: Double?   // Saturated fat in grams
    var transFat: Double?       // Trans fat in grams
    var cholesterol: Double?    // Cholesterol in milligrams
    var sodium: Double?         // Sodium in milligrams
    var totalCarbohydrates: Double?  // Total carbohydrates in grams
    var dietaryFiber: Double?   // Dietary fiber in grams
    var totalSugars: Double?    // Total sugars in grams
    var protein: Double?        // Protein in grams
    var vitaminD: Double?       // Vitamin D in micrograms
    var calcium: Double?        // Calcium in milligrams
    var iron: Double?           // Iron in milligrams
    var potassium: Double?      // Potassium in milligrams
    init(from nutrients: [Nutrient]) {
        for nutrient in nutrients {
            switch nutrient.nutrientName {
                case "Energy":
                    self.calories = nutrient.value
                case "Total lipid (fat)":
                    self.totalFat = nutrient.value
                case "Fatty acids, total saturated":
                    self.saturatedFat = nutrient.value
                case "Fatty acids, total trans":
                    self.transFat = nutrient.value
                case "Cholesterol":
                    self.cholesterol = nutrient.value
                case "Sodium, Na":
                    self.sodium = nutrient.value
                case "Carbohydrate, by difference":
                    self.totalCarbohydrates = nutrient.value
                case "Fiber, total dietary":
                    self.dietaryFiber = nutrient.value
                case "Sugars, total including NLEA":
                    self.totalSugars = nutrient.value
                case "Protein":
                    self.protein = nutrient.value
                case "Vitamin D (D2 + D3)":
                    self.vitaminD = nutrient.value
                case "Calcium, Ca":
                    self.calcium = nutrient.value
                case "Iron, Fe":
                    self.iron = nutrient.value
                case "Potassium, K":
                    self.potassium = nutrient.value
                default:
                    continue
            }
        }
    }
}
