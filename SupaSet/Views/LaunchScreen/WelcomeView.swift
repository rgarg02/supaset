//
//  WelcomeView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/23/24.
//

import SwiftUI

struct WelcomeView: View, WelcomePageProtocol {
    let id = UUID()
    var body: some View {
        VStack(spacing: 20) {
            Text("SupaSet")
                .font(.largeTitle).bold()
                .foregroundStyle(Color("Goldenish"))
            Text("Get ready to transform your life!")
                .font(.title3)
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
