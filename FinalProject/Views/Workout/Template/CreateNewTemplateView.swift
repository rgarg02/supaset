//
//  CreateNewTemplateView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/11/24.
//

import SwiftUI
import SwiftData
struct CreateNewTemplateView: View {
    @Query(filter: #Predicate<WorkoutTemplate> {$0.isEditing == true}) var templates : [WorkoutTemplate]
    @State var template : WorkoutTemplate
    var newTemplate : Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var context
    @State var isEditing : Bool = false
    @FocusState var isFocused : Bool
    @State var showAddExercises : Bool = false
    @State private var exerciseList: [Exercise] = []
    @Binding var expandWorkout: Bool
    var body: some View {
        GeometryReader {geometry in
            ZStack(alignment: .bottom){
                VStack{
                    ShowAddedExercisesView(template : template)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(height: 400)
                    HStack(alignment: .center){
                        Button {
                            withAnimation {
                                showAddExercises = true
                            }
                        } label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Add Exercise")
                            }
                        }
                    }
                    Spacer()
                }
                .safeAreaPadding()
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        template.isEditing = false
                    } label: {
                        if newTemplate{
                            Text("Add Template")
                                .padding()
                                .bold()
                        }else{
                            Text("Update Template")
                                .padding()
                                .bold()
                        }
                    }
                    .background(.ultraThinMaterial)
                    .foregroundStyle(Color.fourth)
                    .clipShape(Capsule())
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        template.isEditing = false
                        let workout = Workout(isFinished: false)
                        context.insert(workout)
                        workout.updateWithTemplate(template: template)
                        expandWorkout = true
                    } label: {
                        Text("Start Workout")
                            .padding()
                            .bold()
                    }
                    .background(.ultraThinMaterial)
                    .foregroundStyle(Color.fourth)
                    .clipShape(Capsule())
                }
                .padding(.bottom)
                
            }
            .overlay(content: {
                if showAddExercises {
                    ExerciseModalView(isPresented: $showAddExercises, exerciseFunctions: template, selectMany: true)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.7)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .transition(.scale.combined(with: .opacity))
                        .padding()
                }
            })
            .background(Color.black)
            .navigationTitle(" ")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    HStack{
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                            if newTemplate{
                                context.delete(template)
                            }
                        } label: {
                            Text("Close")
                        }
                        
                        if isEditing{
                            TextField("New Template", text: $template.name)
                                .font(.title)
                                .foregroundStyle(Color("Goldenish"))
                                .multilineTextAlignment(.center)
                                .onSubmit {
                                    withAnimation {
                                        isEditing = false
                                    }
                                }
                                .focused($isFocused)
                                .selectAllTextOnBeginEditing()
                                .padding()
                                .onAppear{
                                    isFocused = true
                                }
                        }
                        else {
                            Text(template.name)
                                .font(.title)
                                .foregroundStyle(Color.fourth)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    withAnimation {
                                        isEditing = true
                                    }
                                }
                                .padding()
                            
                        }
                        Menu {
                            Button("Change Template Name") {
                                withAnimation{
                                    isEditing = true
                                }
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .padding(.vertical)
                        }
                        Spacer()
                    }
                }
            }
            .onAppear{
                if newTemplate{
                    if let newTemplate = templates.first {
                        template = newTemplate
                    } else {
                        let newTemplate = WorkoutTemplate()
                        template = newTemplate
                        context.insert(newTemplate)
                    }
                }
                
            }
            .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    CreateNewTemplateView(template: WorkoutTemplate(exercises: []), newTemplate: true, expandWorkout: .constant(false))
        .modelContainer(for: WorkoutTemplate.self)
        .environmentObject(WorkoutManager())
}
