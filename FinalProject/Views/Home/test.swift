//
//  test.swift
//  FinalProject
//
//  Created by Rishi Garg on 3/8/24.
//

import SwiftUI

struct test: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        // Your other content here
                        
                        // Vertically scrolling list
                        VStack {
                            List {
                                ForEach(0..<20) { item in
                                    Text("Item \(item)")
                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                            Button {
                                                print("Deleting item \(item)")
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            .tint(.red)
                                        }
                                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                            Button {
                                                print("Pinning item \(item)")
                                            } label: {
                                                Label("Pin", systemImage: "pin")
                                            }
                                            .tint(.blue)
                                        }
                                }
                            }
                        }
                        .frame(width: 300) // Set the width to your requirement
                        
                        // Your other content here
                    }
                }
    }
}

#Preview {
    test()
}
