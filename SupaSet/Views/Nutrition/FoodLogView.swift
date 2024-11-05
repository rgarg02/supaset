//
//  FoodLogView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/23/24.
//

import SwiftUI

struct FoodLogView: View {
    @State private var searchQuery = ""
    @State private var foods: [FoodItem] = []
    @State var path = NavigationPath()
    @State var mealType : MealType
    var body: some View {
        VStack {
            List(foods, id: \.fdcId) { food in
                VStack(alignment: .leading) {
                    NavigationLink {
                        FoodDetailView(food: food, mealType : mealType)
                    } label: {
                        FoodRowView(food: food)
                    }
                }
            }
            .navigationTitle("Food Search")
            .searchable(text: $searchQuery, prompt: "Search for foods")
            .onSubmit(of: .search) {
                NetworkManager().fetchFoodData(query: searchQuery) { result in
                    switch result {
                    case .success(let results):
                        DispatchQueue.main.async {
                            foods = results
                        }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    FoodLogView(mealType: .breakfast)
}
