//
//  PermissionsView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/23/24.
//

import SwiftUI

struct PermissionsView: View, WelcomePageProtocol {
    let id = UUID()
    @EnvironmentObject var healthStore : HealthStore
    @EnvironmentObject var destinationManager : DestinationViewModel
    var body: some View {
        VStack {
            Text("We Need Your Permission")
                .font(.title).bold()
                .padding(.bottom)
            Spacer()
            HStack{
                Text("Allow Health Data")
                Spacer()
                Button {
                    healthStore.requestHealthPermissions()
                } label: {
                    Image(systemName: "bolt.heart.fill")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: 20)
                        .foregroundStyle(healthStore.healthStatus)
                }
            }
            HStack{
                Text("Allow Location Data")
                Spacer()
                Button {
                    destinationManager.requestLocation()
                } label: {
                    Image(systemName: "location.fill")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: 20)
                        .foregroundStyle(destinationManager.locationStatus())
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PermissionsView()
        .environmentObject(HealthStore())
        .environmentObject(DestinationViewModel())
}
