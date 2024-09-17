//
//  FoodRowView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/25/24.
//

import SwiftUI

struct FoodRowView: View {
    var food : FoodItem?
    var foodLog : FoodLog?
    var body: some View {
        HStack{
            if let food {
                
                Text(food.foodDescription)
                    .fontWeight(.bold)
                Spacer()
                Text("\(food.foodNutrients.first(where: {$0.nutrientName == "Energy"})?.value ?? 0, specifier: "%.1f") kcal")
                    .fontWeight(.bold)
            }
            if let foodLog{
                Text(foodLog.name)
                    .fontWeight(.bold)
                Spacer()
                Text("\(foodLog.nutrients?.calories ?? 0, specifier: "%.1f") kcal")
                    .fontWeight(.bold)
            }
        }
    }
}

//#Preview {
//    FoodRowView(food: FoodItem(foodDescription: "Apple", fdcId: 0, foodNutrients: [FoodNutrient(nutrientName: "Energy", value: 57)]))
//}
