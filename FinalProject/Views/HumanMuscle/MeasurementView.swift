//
//  MeasurementView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import SwiftUI

struct MeasurementView: View {
    @Binding var showMeasurementView: Bool
    @EnvironmentObject var measurementManager: MeasurementManager
    @Binding var selectedMeasurement : MuscleMeasurement?
    @State var showRuler : Bool = false
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .top){
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Array(MuscleMeasurement.allCases.prefix(MuscleMeasurement.allCases.count / 2)), id: \.self) { muscle in
                            muscleItem(muscle: muscle, value: measurementManager.measurements[muscle] ?? 0)
                                .onTapGesture {
                                    withAnimation {
                                        selectedMeasurement = muscle
                                        showRuler = true
                                    }
                                }
                        }
                        Spacer()
                    }
                    .frame(width: geometry.size.width/4)
                    .frame(maxHeight: .infinity)
                    Spacer()
                    VStack(spacing: 10) {
                        ForEach(Array(MuscleMeasurement.allCases.suffix(MuscleMeasurement.allCases.count / 2 + 1)), id: \.self) { muscle in
                            muscleItem(muscle: muscle , value: measurementManager.measurements[muscle] ?? 0)
                                .onTapGesture {
                                    withAnimation {
                                        selectedMeasurement = muscle
                                        showRuler = true
                                    }
                                }
                        }
                        Spacer()
                    }
                    .frame(width: geometry.size.width/4)
                    .frame(maxHeight: .infinity)
                }
                .safeAreaPadding()
                .padding(.top, 30)
                .font(.subheadline)
                if showRuler{
                    if selectedMeasurement != nil{
                        CircularRuler(selectedMeasurement: $selectedMeasurement )
                            .offset(y: geometry.size.height/2)
                    }
                }
            }
            .safeAreaPadding(.bottom)
        }
    }
}

@ViewBuilder
func muscleItem(muscle: MuscleMeasurement, value : Float) -> some View {
    VStack {
        Text(muscle.displayName)
        Text(String(format: "%.1f inches",value))
    }
    .frame(minWidth: 0, maxWidth: .infinity)
    .safeAreaPadding(5)
    .background(Color("DarkerBlue"))
    .clipShape(.rect(cornerRadius: 10))
    .foregroundColor(.white)
    
}
#Preview {
    MeasurementView(showMeasurementView: .constant(true), selectedMeasurement: .constant(.neck))
        .environmentObject(MeasurementManager())
}
