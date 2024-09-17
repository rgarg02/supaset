//
//  MuscleDetail.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/28/24.
//

import SwiftUI

struct MuscleDetail: View {
    var nodeName: String
    @State var muscleGroup : String = ""
    var body: some View {
        VStack {
            Text(muscleGroup.capitalized)
                .padding()
                .cornerRadius(10)
                .shadow(radius: 10)
                .foregroundStyle(Color("Goldenish"))
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear{
            self.muscleGroup = MuscleGroups.muscleForValue(nodeName)?.rawValue ?? ""
        }
        .onChange(of: nodeName) { oldValue, newValue in
            self.muscleGroup = MuscleGroups.muscleForValue(nodeName)?.rawValue ?? ""
        }
    }
}

#Preview {
    MuscleDetail(nodeName: "Muslo")
}
