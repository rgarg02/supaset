//
//  Profile.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/25/24.
//

import SwiftUI
import SceneKit

struct Profile: View {
    @EnvironmentObject var userManager : UserManager
    @EnvironmentObject var healthStore : HealthStore
    @State private var sceneView = SCNView()
    var body: some View {
        HumanModel(showHumanModel: .constant(true), closable: false)
    }
}

#Preview {
    Profile()
        .environmentObject(UserManager())
        .environmentObject(HealthStore())
}
