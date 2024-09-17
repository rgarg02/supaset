//
//  ExerciseTab.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/27/24.
//

import SwiftUI

struct ExerciseTab: View {
    @Bindable var exerciseInfo : EInfo
    @Binding var moving : Bool
    @EnvironmentObject var workoutManager : WorkoutManager
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Text(workoutManager.exerciseName(for: exerciseInfo.exerciseID))
                    .font(.headline)
                    .foregroundStyle(Color.fourth)
                    .padding()
                Spacer()
            }
            if !moving{
                ExerciseSetView(exerciseInfo: exerciseInfo)
            }
        }
        .background(Color("DarkerBlue"))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.vertical, 5)
        .safeAreaPadding(.bottom)
        .ignoresSafeArea(.keyboard)
    }
}
                                  

struct ExerciseTab_Preview : PreviewProvider{
    static var previews: some View {
        let einfo = EInfo(exerciseID: "3-4_Sit_Up")
        ExerciseTab(exerciseInfo: einfo, moving : .constant(false))
            .modelContainer(previewContainer)
            .environmentObject(WorkoutManager())
            .onAppear{
                previewContainer.mainContext.insert(einfo)
            }
    }
}
