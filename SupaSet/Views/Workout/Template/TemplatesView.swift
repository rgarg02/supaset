//
//  TemplatesView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/11/24.
//

import SwiftUI
import SwiftData
struct TemplatesView: View {
    @Binding var expandWorkout : Bool
    @Query (filter: #Predicate<WorkoutTemplate> {$0.isEditing == false}) var templates : [WorkoutTemplate]
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(templates){
                    template in
                    NavigationLink(destination: CreateNewTemplateView(template: template, newTemplate: false, expandWorkout: $expandWorkout)) {
                                    TemplateCardView(template: template)
                                }
                }
            }
        }
    }
}

#Preview {
    TemplatesView(expandWorkout: .constant(false))
}
