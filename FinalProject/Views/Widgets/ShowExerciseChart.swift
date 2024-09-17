//
//  ShowExerciseChart.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/15/24.
//

import SwiftUI
import SwiftData
import Charts
struct ShowExerciseChart: View {
    @Query var sets : [ESet]
    @Binding var progressionDetail : ProgressionDetail
    @State var selectedValue : Double?
    var body: some View {
        GeometryReader {geometry in
            TabView{
                if !sets.isEmpty {
                    ForEach(ProgressionDetailProperty.allCases) {property in
                        if progressionDetail.isSet(property: property){
                            let chartData = progressionDetail.getSetData(for: property, sets: sets)
                            VStack{
                                HStack{
                                    Text(property.displayName)
                                        .padding(.leading)
                                    Spacer()
                                }
                                Chart {
                                    ForEach(Array(chartData.keys).sorted(), id: \.self) { date in
                                        LineMark(
                                            x: .value("Date", date),
                                            y: .value("Weight", chartData[date]!)
                                        )
                                        .interpolationMethod(.catmullRom)
                                    }
                                }
                                .chartYSelection(value: $selectedValue)
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 15)
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundStyle(property.color)
                            }
                        }
                    }
                } else {
                    Text("No data available")
                }
            }
            .tabViewStyle(.page)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    init(exerciseID: String, progressionDetail: Binding<ProgressionDetail>) {
        _sets = Query(filter: #Predicate<ESet> { set in
            set.exercise?.exerciseID == exerciseID
        }, sort: \ESet.exercise?.workout?.date)
        self._progressionDetail = progressionDetail
    }
}

#Preview {
    ShowExerciseChart(exerciseID: "3_4_Sit-Up", progressionDetail : .constant(ProgressionDetail(oneRepMax: true, volumeIncrease: true, duration: true)))
        .modelContainer(previewContainer)
}
