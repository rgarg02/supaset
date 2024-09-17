//
//  FoodSections.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/29/24.
//

import SwiftUI
import SwiftData
struct FoodSections: View {
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
                ScrollView{
                    VStack{
                        ForEach(MealType.allCases, id: \.self) {type in
                            VStack{
                                HStack{
                                    Text(type.rawValue.capitalized)
                                    Spacer()
                                    NavigationLink {
                                        FoodLogView(mealType : type)
                                    } label: {
                                        Image(systemName: "plus")
                                    }
                                }
                                LoggedMeals(mealType: type)
                            }
                            .safeAreaPadding()
                            .background(Color("DarkerBlue"))
                            .clipShape(.rect(cornerRadius: 20))
                            .frame(height: 250)
                            .padding(.bottom)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack{
                                Text("Log Food")
                                    .foregroundStyle(Color.gray)
                                    .font(.title)
                                    .bold()
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .safeAreaPadding()
                }
            }
        }
    }
}
struct LoggedMeals: View {
    @Query var foodLogs : [FoodLog]
    let mealType : MealType
    var body: some View {
        ScrollView{
            VStack{
                ForEach(foodLogs.filter({$0.mealType == mealType})){foodLog in
                    NavigationLink {
                        FoodDetailView(foodLog: foodLog, mealType : foodLog.mealType)
                    } label: {
                        FoodRowView(foodLog: foodLog)
                    }
                }
            }
        }
    }
}
#Preview {
    FoodSections()
}
