//
//  WorkoutInfo.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/12/24.
//

import SwiftUI
import SwiftData
struct WorkoutInfo: View {
    @Bindable var workout : Workout
    @Binding var expandWorkout : Bool
    var animation : Namespace.ID
    @State var timeElapsed : Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            if !expandWorkout {
                HStack{
                    Text(workout.name).font(.title)
                        .multilineTextAlignment(.center)
                        .matchedGeometryEffect(id: "WorkoutName", in: animation)
                        .padding(.leading)
                    Spacer()
                    Image(systemName: "clock")
                        .matchedGeometryEffect(id: "WorkoutClock", in: animation)
                    Text(formatTime(seconds: timeElapsed))
                        .padding(.trailing)
                        .onReceive(timer) { _ in
                            timeElapsed = Int(Date().timeIntervalSince(workout.date))
                        }
                        .matchedGeometryEffect(id: "WorkoutTime", in: animation)
                        
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)){
                expandWorkout = true
            }
        }
    }
}

struct WorkoutInfo_Previews: PreviewProvider {
    static var previews: some View {
        @Namespace var animation
        let workout = Workout(isFinished: false)
        WorkoutInfo(workout: workout, expandWorkout: .constant(false), animation: animation, timeElapsed: 0)
            .modelContainer(previewContainer)
            .onAppear{
                previewContainer.mainContext.insert(workout)
                workout.addExercise(exerciseID: "90_90_Hamstring")
                workout.addExercise(exerciseID: "90_90_Hamstring")
            }
    }
}

