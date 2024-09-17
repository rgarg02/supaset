//
//  ShowActivities.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/14/24.
//

import SwiftUI

struct ShowActivities: View {
    @EnvironmentObject var healthStore : HealthStore
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2), alignment: .center, pinnedViews: .sectionFooters) {
            ForEach(healthStore.activities.sorted(by: {$0.value.id < $1.value.id}), id: \.key){ activity in
                ActivityView(activity: activity.value)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ShowActivities()
        .environmentObject(HealthStore())
}
