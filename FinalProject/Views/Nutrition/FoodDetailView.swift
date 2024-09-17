//
//  FoodDetailView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/25/24.
//

import SwiftUI
import SwiftData
struct FoodDetailView: View {
    @State var food: FoodItem?
    var foodLog : FoodLog?
    @State var serving: Double = 1.0
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var mealType : MealType = MealType.determineMealTime(from: Date())
    @EnvironmentObject var healthStore : HealthStore
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                if let food {
                    Text(food.foodDescription)
                        .font(.title)
                        .bold()
                    VStack{
                        HStack {
                            Text("Serving Size:")
                            Spacer()
                            TextField("Servings", value: $serving, format: .number)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // Adds a border to make the TextField visible
                                .frame(width: 60)
                        }
                        HStack{
                            Text("Meal Type")
                            Spacer()
                            Picker("Meal Type", selection: $mealType) {
                                ForEach(MealType.allCases, id: \.self){type in
                                    Text(type.rawValue.capitalized)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    
                    .padding()  // Adds padding around the HStack for better spacing
                    HStack{
                        NutritionFactsLabel(food: food, serving: serving)
                    }
                }
                if let foodLog{
                    @Bindable var foodLog = foodLog
                    Text(foodLog.name)
                        .font(.title)
                        .bold()
                    VStack{
                        HStack {
                            Text("Serving Size:")
                            Spacer()
                            TextField("Servings", value: $foodLog.serving, format: .number)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // Adds a border to make the TextField visible
                                .frame(width: 60)
                        }
                        HStack{
                            Text("Meal Type")
                            Spacer()
                            Picker("Meal Type", selection: $foodLog.mealType) {
                                ForEach(MealType.allCases, id: \.self){type in
                                    Text(type.rawValue.capitalized)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    
                    .padding()  // Adds padding around the HStack for better spacing
                    HStack{
                        NutritionFactsLabel(foodLog: foodLog, serving: foodLog.serving)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { // Use navigationBarTrailing if you meant to add it to a navigation bar.
                    if let food {
                        Button(action: {
                            let foodDescription = food.foodDescription
                            let nutritionalInfo = food.nutritionalInfo
                            if let servingSizeUnit = food.servingSizeUnit{
                                let food = FoodLog(name:foodDescription, serving: serving, nutrients: nutritionalInfo, mealType: mealType, servingSizeUnit: servingSizeUnit)
                                context.insert(food)
                                if let calories =
                                    food.nutrients?.calories{
                                    print(calories)
                                    healthStore.addCaloriesToHealthKit(calories: calories, date: food.date)
                                }
                                dismiss()
                            }
                        }) {
                            HStack{
                                Image(systemName: "fork.knife")
                                Image(systemName: "plus")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    if let foodLog {
                        Button {
                            context.delete(foodLog)
                            dismiss()
                        } label: {
                            Image(systemName: "fork.knife")
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                        }

                    }
                }
            }
            .navigationTitle("Nutrition Details")
            .padding()
        }
    }
    @ViewBuilder
        private func nutrientRow(title: String, value: Double) -> some View {
            HStack {
                Text(title)
                Spacer()
                Text("\(value * serving, specifier: "%.1f")")
            }
        }
}

// Assuming you have a way to pass the Binding path from upstream
struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(food: FoodItem(
            foodDescription: "Peanuts",
            fdcId: 0,
            foodNutrients: [
                Nutrient(nutrientId: 1008, nutrientName: "Calories", nutrientNumber: "1", value: 567.0, unitName: "kcal"),
                Nutrient(nutrientId: 1004, nutrientName: "Total fat", nutrientNumber: "2", value: 567.0, unitName: "g")
            ],
            foodPortions: [
                FoodPortion(amount: 1.0, measureUnit: "cup", gramWeight: 146.0),
                FoodPortion(amount: 100.0, measureUnit: "grams", gramWeight: 100.0)
            ],
            servingSize: 28.0,  // A typical serving size in grams for peanuts
            servingSizeUnit: "grams"
        ))
        .modelContainer(previewContainer)
    }
}

