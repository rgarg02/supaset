//
//  WidgetView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/14/24.
//

import SwiftUI
import SwiftData
struct WidgetView: View {
    @Query(filter: #Predicate<WorkoutWidget> {$0.isEditing == false}, sort: \WorkoutWidget.index) var widgets : [WorkoutWidget]
    @Environment(\.modelContext) var context
    @State private var dragging: WorkoutWidget?
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), alignment: .center, pinnedViews: .sectionFooters) {
            ForEach(widgets) {widget in
                WidgetCardView(widget: widget)
            }
            
        }
    }
}

#Preview {
    WidgetView()
        .modelContainer(previewContainer)
        .environmentObject(WorkoutManager())
}
