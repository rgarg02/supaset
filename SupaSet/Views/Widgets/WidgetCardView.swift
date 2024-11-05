//
//  WidgetCardView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/15/24.
//

import SwiftUI
import SwiftData
struct WidgetCardView: View {
    @Bindable var widget: WorkoutWidget
    @EnvironmentObject var workoutManager : WorkoutManager
    var body: some View {
        VStack{
            HStack{
                Text(workoutManager.exerciseName(for: widget.progressionID))
                    .foregroundStyle(Color("Goldenish"))
                    .bold()
                    .font(.subheadline)
                    .padding(.top)
            }
            if widget.focus == .exercise {
                ShowExerciseChart(exerciseID: widget.progressionID, progressionDetail : $widget.progressionDetail)
            }
        }
        .background(Color("DarkerBlue"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct WorkoutCardView_Previews: PreviewProvider {
    static var previews: some View {
        let widget = WorkoutWidget(progressionID: "3_4_Sit-Up")
        WidgetCardView(widget: widget)
            .modelContainer(previewContainer)
            .environmentObject(WorkoutManager())
            .onAppear{
                previewContainer.mainContext.insert(widget)
                widget.focus = .exercise
                widget.progressionDetail = ProgressionDetail(oneRepMax: true, volumeIncrease: true)
            }
    }
}
