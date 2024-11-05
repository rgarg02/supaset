//
//  TemplateCardView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/13/24.
//

import SwiftUI
import SwiftData

struct TemplateCardView: View {
    @Bindable var template : WorkoutTemplate
    @EnvironmentObject var workoutManager: WorkoutManager
    var body: some View {
        VStack(alignment: .leading){
            Text(template.name)
                .foregroundStyle(Color("Goldenish"))
                .padding(.top)
                .bold()
            ForEach(template.orderedExercises()){ exercise in
                Text(workoutManager.exerciseName(for: exercise.exerciseID))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.caption)
            }
            Spacer()
        }
        .safeAreaPadding(.horizontal, 5)
        .frame(width: 170, height: 150)
        .foregroundStyle(Color.white)
        .background(Color("DarkBlue"))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: WorkoutTemplate.self, configurations: config)

    let template = WorkoutTemplate(name: "Test Template")
    return TemplateCardView(template: template)
        .modelContainer(container)
        .environmentObject(WorkoutManager())
}
