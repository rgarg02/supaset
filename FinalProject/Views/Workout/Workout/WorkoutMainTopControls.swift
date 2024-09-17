//
//  WorkoutMainTopControls.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/29/24.
//

import SwiftUI

struct WorkoutMainTopControls: View {
    var animation : Namespace.ID
    @Bindable var workout : Workout
    @State private var isEditing = false
    @State private var backgroundOpacity = 1.0
    @State var timeElapsed: Int = 0
    @State var opacity : CGFloat = 0
    @FocusState private var isFocused : Bool
    @State var showHumanModel : Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        HStack {
            if isEditing {
                TextField("Workout Name", text: $workout.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .onSubmit {
                        withAnimation { // Animate the change back to Text
                            isEditing = false
                        }
                    }
                    .focused($isFocused)
                    .selectAllTextOnBeginEditing()
                    .padding()
                    .onAppear{
                        isFocused = true
                    }
            } else {
                Text(workout.name).font(.title)
                    .multilineTextAlignment(.center)
                    .onTapGesture { // Tap on the text to start editing
                        withAnimation {  // Animate the change to TextField
                            isEditing = true
                        }
                    }
                    .matchedGeometryEffect(id: "WorkoutName", in: animation)
                    .padding()
                
            }
            Menu {
                Button("Change Workout Name") {
                    withAnimation{
                        isEditing = true
                    }
                }
                Button("Select Template") {
                    // Present a list of templates to select from
                }
            } label: {
                    Image(systemName: "ellipsis")
                    .padding(.vertical)
            }
            .buttonStyle(.plain)
            Spacer()
            Image(systemName: "clock")
                .padding(.vertical)
                .matchedGeometryEffect(id: "WorkoutClock", in: animation)
            Text(formatTime(seconds: timeElapsed))
                .matchedGeometryEffect(id: "WorkoutTime", in: animation)
            .onReceive(timer) { _ in
                timeElapsed = Int(Date().timeIntervalSince(workout.date))
            }
            .padding([.top, .bottom, .trailing])
            Image(systemName: "figure")
                .onTapGesture {
                    withAnimation {
                        showHumanModel = true
                    }
                }
                .popover(isPresented: $showHumanModel, content: {
                    HumanModel(showHumanModel: $showHumanModel, workout: workout, closable: true)
                        .presentationCompactAdaptation(.popover)
                        .frame(width: 300,height: 400)
                })
                .padding([.top, .bottom, .trailing])
        }
        
    }
}

struct WorkoutMainTopControls_Preview: PreviewProvider {
    static var previews: some View {
        @Namespace var animation
        let workout = Workout()
        WorkoutMainTopControls(animation: animation, workout: workout, timeElapsed: 0)
            .modelContainer(previewContainer)
            .onAppear{
                previewContainer.mainContext.insert(workout)
                workout.addExercise(exerciseID: "Advanced_Kettlebell_Windmill")
            }
    }
}
