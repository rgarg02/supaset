//
//  VerticleCara.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/16/24.
//

import SwiftUI

struct VerticleCara: View {
    // Sample data: array of system image names
    let items = ["house.fill", "gear", "person.fill", "airplane", "car.fill"]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Image(systemName: item)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1)) // Light gray background for better visibility
    }
}

#Preview {
    VerticleCara()
}

#Preview {
    VerticleCara()
}
