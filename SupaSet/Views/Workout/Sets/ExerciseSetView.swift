//
//  ExerciseSetView.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/27/24.
//

import SwiftUI

struct ExerciseSetView: View {
    @Bindable var exerciseInfo : EInfo
    @Environment (\.modelContext) var context
    @State private var opacity: Double = 1.0
    var body: some View {
        let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
        VStack{
            VStack {
                LazyVGrid(columns: columns, content: {
                    Text("Set")
                    Text("Weight")
                    Text("Rep")
                    Text("Done")
                })
                .listRowBackground(Color.clear)
                ForEach(Array(exerciseInfo.sets.sorted(by: {$0.index < $1.index}).enumerated()), id: \.element) { index, set in
                    SetRowView(index: index, set: set)
                        
                }
                .listRowSeparator(.hidden)
                SetRowView(index: -1, set: ESet())
                    .onTapGesture {
                        let set = ESet(index: exerciseInfo.sets.count, done: false)
                        exerciseInfo.sets.append(set)
                    }
            }
            .frame(minHeight: 200, alignment: .top)
            .scrollDisabled(true)
            .listStyle(PlainListStyle())
        }
    }
    
}
struct ExerciseSetView_Preview : PreviewProvider {
    static var previews: some View {
        let eInfo = EInfo(exerciseID: "3-4_Sit_Up")
        ExerciseSetView(exerciseInfo: eInfo)
            .modelContainer(previewContainer)
            .onAppear{
                previewContainer.mainContext.insert(eInfo)
            }
    }
}



