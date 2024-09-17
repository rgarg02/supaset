//
//  Home.swift
//  FinalProject
//
//  Created by Rishi Garg on 2/20/24.
//

import SwiftUI
import HealthKit
import SwiftData

struct Home: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State var weeklySteps: [Int] = []
    @State var changeExercise : Bool = false
    @State var totalYearlyDistance : Double = 0.0
    @State var showNewWidgetSelection : Bool = false
    @State var showPrevWidgetSelection : Bool = false
    @EnvironmentObject var healthStore : HealthStore
    @Environment(\.modelContext) var context
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                VStack{
                    ScrollView{
                        VStack {
                            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                                Text(AppInfo.appName.value)
                                    .font(.title)
                                    .foregroundColor(Color("Goldenish"))
                                    .bold()
                            })
                            .padding(.bottom)
                            ShowActivities()
                            VStack{
                                HStack{
                                    Text("Widgets")
                                        .font(.title2)
                                    Spacer()
                                    NavigationLink(destination: WidgetSelection(widget: WorkoutWidget(), newWidget: true)) {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(height: 20)
                                        
                                    }
                                }
                                WidgetView()
                            }
                            .safeAreaPadding()
                        }
                    }
                }
            }
        }
        .onAppear{
            healthStore.getTotalDistance { distance in
                DispatchQueue.main.async {
                    self.totalYearlyDistance = distance
                }
            }
            healthStore.updateActivities()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of your environment object
        let manager = WorkoutManager()
        let health = HealthStore()
        // Provide the environment object to your Home view
        Home()
            .environmentObject(manager)
            .environmentObject(health)
            .modelContainer(previewContainer)
    }
}
