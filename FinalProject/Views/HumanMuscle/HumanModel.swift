//
//  Humun3DModel.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/17/24.
//

import SwiftUI
import SwiftData
import SceneKit

struct HumanModel: View {
    @State internal var sceneView = SCNView()
    @State private var selectedName: String?
    @Binding var showHumanModel : Bool
    var workout : Workout?
    @EnvironmentObject var workoutManager : WorkoutManager
    @State private var nodeName: String = ""
    @State internal var showDetails: Bool = false
    @State internal var lastOutlineNode: SCNNode?
    @State private var showMeasurementView : Bool = false
    @State var selectedMeasurement : MuscleMeasurement?
    @State var isTapGestureEnabled : Bool = true
    @State var movetoMuscle : String?
    @State var locationOfNode : Float?
    @Namespace var navbarAnimation
    let closable: Bool
    var exercise: Exercise?
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: showMeasurementView ? .top : .topTrailing) {
                SceneKitContainer(sceneView: $sceneView, nodeName: $nodeName, showDetails: $showDetails, isTapGestureEnabled: $isTapGestureEnabled, movetoMuscle: $movetoMuscle, locationOfNode: $locationOfNode)
                    .onAppear {
                        resetScene()
                        loadMusclesHighlights()
                    }
                HStack{
                    if closable{
                        Button {
                            withAnimation{
                                showHumanModel = false
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                        }
                        .frame(width: 25)
                        .padding()
                        .foregroundStyle(Color.red)
                        Spacer()
                    }
                }
                NavBar()
                if showMeasurementView {
                    MeasurementView(showMeasurementView : $showMeasurementView, selectedMeasurement: $selectedMeasurement)
                        .onChange(of: selectedMeasurement) { oldValue, newValue in
                            if let selectedMeasurement{
                                addOutline(for: selectedMeasurement)
                            }
                        }
                }
                if showDetails {
                    MuscleDetail(nodeName: nodeName)
                }
            }
        }
    }
    @ViewBuilder
    func NavBar() -> some View {
        if !closable{
            if showMeasurementView{
                HStack{
                    Button {
                        withAnimation{
                            showMeasurementView.toggle()
                            resetScene()
                            sceneView.allowsCameraControl.toggle()
                            isTapGestureEnabled.toggle()
                        }
                    } label: {
                        Image(systemName: "pencil.and.ruler")
                    }
                }
                .matchedGeometryEffect(id: "navbarAnimation", in: navbarAnimation)
                .frame(width: 100, height: 50)
                .background(.ultraThickMaterial)
                .clipShape(.rect(cornerRadius: 10))
                .padding()
            }else{
                VStack{
                    Button {
                        withAnimation{
                            showMeasurementView.toggle()
                            resetScene()
                            sceneView.allowsCameraControl.toggle()
                            isTapGestureEnabled.toggle()
                        }
                    } label: {
                        Image(systemName: "pencil.and.ruler")
                    }
                    .padding(.bottom)

                    Button {
                        withAnimation{
                            resetScene()
                        }
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
                .matchedGeometryEffect(id: "navbarAnimation", in: navbarAnimation)
                .frame(width: 50, height: 100)
                .background(.ultraThickMaterial)
                .clipShape(.rect(cornerRadius: 10))
                .padding()
            }
        }
    }
}

struct Human3DModel_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout()
        HumanModel(showHumanModel: .constant(true), closable: false)
            .environmentObject(WorkoutManager())
            .environmentObject(MeasurementManager())
            .modelContainer(previewContainer)
            .onAppear{
                previewContainer.mainContext.insert(workout)
                workout.addExercise(exerciseID: "Advanced_Kettlebell_Windmill")
            }
    }
}


