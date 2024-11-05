//
//  NutritionView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/25/24.
//

import SwiftUI
import SwiftData
struct NutritionView: View {
    @Query var foods : [FoodLog]
    @State var showLogView : Bool = false
    var body: some View {
        NavigationStack{
            GeometryReader{ geometry in
                VStack {
                    FoodSections()
                }
            }
        }
    }
}

#Preview {
    NutritionView()
}
