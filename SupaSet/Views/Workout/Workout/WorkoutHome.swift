//
//  WorkoutHome.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/3/24.
//

import SwiftUI
import SwiftData
struct WorkoutHome: View {
    @Environment(\.modelContext) var context
    @Binding var expandWorkout : Bool
    @Query var templates : [WorkoutTemplate]
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                VStack{
                    HStack{
                        Text("Templates")
                            .foregroundStyle(Color.white)
                            .font(.title2)
                            .bold()
                        Spacer()
                        NavigationLink(destination: CreateNewTemplateView(template: WorkoutTemplate(), newTemplate : true, expandWorkout: $expandWorkout)) {
                            Image(systemName: "plus.app.fill")
                                .font(.title2)
                        }
                    }
                    .padding(.bottom)
                    TemplatesView(expandWorkout : $expandWorkout)
                    Spacer()
                }
                Button {
                    let workout = Workout(isFinished: false)
                    context.insert(workout)
                    expandWorkout = true
                } label: {
                    Text("Start Workout")
                        .padding()
                }
                .background(.ultraThinMaterial)
                .foregroundStyle(Color.fourth)
                .clipShape(Capsule())
            }
            .navigationTitle(" ")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack{
                        Text("Start Workout")
                            .foregroundStyle(Color.gray)
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding()
                }
            }
            .background(Color.black)
            .safeAreaPadding()
        }
    }
}

struct WorkoutHomelView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHome(expandWorkout: .constant(false))
    }
}
