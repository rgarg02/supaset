//
//  NutritionFactsLabel.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/25/24.
//

import SwiftUI

struct NutritionFactsLabel: View {
    var food : FoodItem?
    var foodLog: FoodLog?
    let serving : Double
    @State var nutritionalInfo : NutritionalInfo?
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0){
                Text("Nutrition Facts")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .lineLimit(1)
                Rectangle()
                    .stroke(lineWidth: 1)
                    .frame(height: 1)
                
                HStack{
                    if let servingSize = food?.servingSize, let servingSizeUnit = food?.servingSizeUnit {
                        Text("Serving Size")
                        Spacer()
                        Text("\(servingSize, specifier: "%.1f") \(servingSizeUnit)")
                    }
                }
                .fontWeight(.heavy)
                .font(.title3)
                HStack{
                    if let servingSize = foodLog?.serving, let servingSizeUnit = foodLog?.servingSizeUnit {
                        Text("Serving Size")
                        Spacer()
                        Text("\(servingSize, specifier: "%.1f") \(servingSizeUnit)")
                    }
                }
                .fontWeight(.heavy)
                .font(.title3)
                Rectangle()
                    .stroke(lineWidth: 15)
                    .frame(height: 1)
                    .padding(.vertical, 7)
                Text("Amount Per Serving")
                    .fontWeight(.bold)
                if let nutritionalInfo {
                    HStack{
                        Text("Calories")
                        Spacer()
                        Text("\(nutritionalInfo.calories ?? 0,specifier: "%.1f" )")
                    }
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    Rectangle()
                        .stroke(lineWidth: 8)
                        .frame(height: 1)
                        .padding(.bottom)
                    HStack{
                        Spacer()
                        Text("% Daily Value")
                            .bold()
                    }
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Total Fat ")
                            .fontWeight(.bold) + Text(String(format: "%.1fg", nutritionalInfo.totalFat ?? 0))
                            .fontWeight(.regular)
                    }
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Saturated Fat ")
                            .fontWeight(.regular) + Text(String(format: "%.1fg", nutritionalInfo.saturatedFat ?? 0))
                            .fontWeight(.regular)
                    }
                    .padding(.leading)
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Trans Fat ")
                            .fontWeight(.regular) + Text(String(format: "%.1fg", nutritionalInfo.transFat ?? 0))
                            .fontWeight(.regular)
                    }
                    .padding(.leading)
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Cholesterol ")
                            .fontWeight(.bold) + Text(String(format: "%.1fmg", nutritionalInfo.cholesterol ?? 0))
                            .fontWeight(.regular)
                    }
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Sodium ")
                            .fontWeight(.bold) + Text(String(format: "%.1fmg", nutritionalInfo.sodium ?? 0))
                            .fontWeight(.regular)
                    }
                    HStack{
                        Text("Total Carbohydrate ")
                            .fontWeight(.bold) + Text(String(format: "%.1fg", nutritionalInfo.totalCarbohydrates ?? 0))
                            .fontWeight(.regular)
                    }
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Dietery Fiber ")
                            .fontWeight(.regular) + Text(String(format: "%.1fg", nutritionalInfo.dietaryFiber ?? 0))
                            .fontWeight(.regular)
                    }
                    .padding(.leading)
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Total Sugars ")
                            .fontWeight(.regular) + Text(String(format: "%.1fg", nutritionalInfo.totalSugars ?? 0))
                            .fontWeight(.regular)
                    }
                    .padding(.leading)
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Protein ")
                            .fontWeight(.bold) + Text(String(format: "%.1fg", nutritionalInfo.protein ?? 0))
                            .fontWeight(.regular)
                    }
                    Rectangle()
                        .stroke(lineWidth: 10)
                        .frame(height: 1)
                        .padding(.vertical,5)
                    HStack{
                        Text("Vitamin D ")
                            .fontWeight(.regular) + Text(String(format: "%.1fmcg", nutritionalInfo.vitaminD ?? 0))
                            .fontWeight(.regular)
                    }
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Calcium ")
                            .fontWeight(.regular) + Text(String(format: "%.1fmg", nutritionalInfo.calcium ?? 0))
                            .fontWeight(.regular)
                    }
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Iron ")
                            .fontWeight(.regular) + Text(String(format: "%.1fmg", nutritionalInfo.iron ?? 0))
                            .fontWeight(.regular)
                    }
                    Divider()
                        .frame(height: 1)
                    HStack{
                        Text("Pottasium ")
                            .fontWeight(.regular) + Text(String(format: "%.1fmg", nutritionalInfo.potassium ?? 0))
                            .fontWeight(.regular)
                    }
                }
            }
            .safeAreaPadding(.horizontal)
            .border(Color.black, width: 2)
            .background(Color.white)
            .foregroundStyle(Color.black)
        }
        .onAppear{
            if let food {
                nutritionalInfo = food.nutritionalInfo
            }
            if let foodLog {
                if let nutrition = foodLog.nutrients {
                    nutritionalInfo = nutrition
                }
            }
        }
    }
}

//#Preview {
//    NutritionFactsLabel(
//                food: FoodItem(
//                    foodDescription: "Peanuts",
//                    fdcId: 0,
//                    foodNutrients: [
//                        Nutrient(nutrientId: 1008, nutrientName: "Calories", nutrientNumber: "1", value: 567.0, unitName: "kcal"),
//                        Nutrient(nutrientId: 1004, nutrientName: "Total fat", nutrientNumber: "2", value: 567.0, unitName: "g")
//                    ],
//                    foodPortions: [
//                        FoodPortion(amount: 1.0, measureUnit: "cup", gramWeight: 146.0),
//                        FoodPortion(amount: 100.0, measureUnit: "grams", gramWeight: 100.0)
//                    ],
//                    servingSize: 28.0,  // A typical serving size in grams for peanuts
//                    servingSizeUnit: "grams"
//                ),
//                serving: 1.0  // This would be used to multiply the nutrient values, 1 means no change
//            )
//}
