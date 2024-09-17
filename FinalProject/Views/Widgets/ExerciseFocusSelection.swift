//
//  ExerciseFocusSelection.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/21/24.
//

import SwiftUI

struct ExerciseFocusSelection: View {
    @Binding var isPresented : Bool
    @EnvironmentObject var workoutManager : WorkoutManager
    @Binding var widget : WorkoutWidget
    var body: some View {
        VStack{
            Section(header: Text("Select Exercise").font(.title2)) {
                HStack{
                    Button {
                        withAnimation {
                            isPresented = true
                        }
                    } label: {
                        Text(workoutManager.exerciseName(for: widget.progressionID))
                            .foregroundStyle(Color("Goldenish"))
                            .padding()
                            .background(Color.gray.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
            }
            Section(header: Text("Select Properties To Track").font(.title2)) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(ProgressionDetailProperty.allCases, id: \.self) { property in
                            Toggle(isOn: Binding(
                                get: { widget.progressionDetail.isSet(property: property) },
                                set: { newValue in
                                    widget.progressionDetail.toggle(property: property)
                                }
                            )) {
                                Text(property.displayName)
                            }
                            .toggleStyle(.button)
                            .background(property.color.opacity(0.05))
                            .clipShape(.rect(cornerRadius: 15))
                            .tint(property.color)
                            if property != ProgressionDetailProperty.allCases.last {
                                Divider()
                                    .frame(height: 30) // Specify the height of the Divider
                                    .background(Color.gray)
                            }
                        }
                    }
                }
            }
            WidgetCardView(widget: widget)
        }
    }
}

//#Preview {
//    ExerciseFocusSelection(isPresented: .constant(false), widget: WorkoutWidget())
//        .environmentObject(WorkoutManager())
//        .modelContainer(previewContainer)
//}
