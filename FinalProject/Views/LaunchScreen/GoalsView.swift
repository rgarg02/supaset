//
//  GoalsView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/23/24.
//

import SwiftUI

struct GoalsView: View, WelcomePageProtocol {
    @State private var goal = ""
    let id = UUID()
    
    var body: some View {
        VStack {
            Text("What's Your Fitness Goal?")
                .font(.largeTitle).bold()
            Spacer()
            TextField("Enter your goal", text: $goal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Save Goal") {
                // Placeholder to save user's goal
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
        .padding()
    }
}


#Preview {
    GoalsView()
}
