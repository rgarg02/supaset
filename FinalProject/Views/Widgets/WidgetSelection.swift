//
//  WidgetSelection.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/14/24.
//

import SwiftUI
import SwiftData


struct WidgetSelection: View {
    @State var widget: WorkoutWidget
    var newWidget : Bool
    @State var showExerciseSelection : Bool = false
    @EnvironmentObject var workoutManager : WorkoutManager
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var widgets : [WorkoutWidget]
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack{
//                    Text("Select Focus")
//                        .font(.title2)
//                    Picker("Focus", selection: $widget.focus) {
//                        ForEach(Focus.allCases, id: \.self) { focus in
//                            Text(focus.rawValue.capitalized)
//                                .tag(focus)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
                    if widget.focus == .exercise {
                        Text("Select Exercise")
                            .font(.title2)
                        Text(workoutManager.exerciseName(for: widget.progressionID))
                            .padding()
                            .foregroundStyle(Color("Goldenish"))
                            .background(Color("DarkerBlue"))
                            .clipShape(Capsule())
                            .onTapGesture {
                                showExerciseSelection = true
                            }
                    }
                    Text("Select Metrics To Track")
                        .font(.title2)
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
                    WidgetCardView(widget: widget)
                    Text("Save Widget")
                        .padding()
                        .foregroundStyle(Color("Goldenish"))
                        .background(Color("DarkerBlue"))
                        .clipShape(Capsule())
                        .onTapGesture {
                            if newWidget {
                                widget.isEditing = false
                                widget.index = widgets.count
                                context.insert(widget)
                                dismiss()
                            }
                        }
                }
                .safeAreaPadding()
                .opacity(showExerciseSelection ? 0.7 : 1)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack{
                            TextField("New Template", text: $widget.name)
                                .font(.title)
                                .foregroundStyle(Color("Goldenish"))
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                if showExerciseSelection{
                    ExerciseModalView(isPresented: $showExerciseSelection, widget: widget, selectMany : false)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.7)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .transition(.scale.combined(with: .opacity))
                }
            }
        }
    }
}

#Preview {
    WidgetSelection(widget: WorkoutWidget(), newWidget: true)
        .modelContainer(previewContainer)
        .environmentObject(WorkoutManager())
}
