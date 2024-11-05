//
//  ActivityView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/14/24.
//

import SwiftUI

struct ActivityView: View {
    @State var activity : Activity
    var body: some View {
        ZStack{
            Color("DarkerBlue")
                .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack(alignment: .leading, spacing: 20){
                HStack(alignment: .top){
                    VStack(alignment: .leading){
                        Text(activity.title)
                            .foregroundStyle(Color("Goldenish"))
                            .font(.title3)
                        Text(activity.subTitle)
                            .font(.subheadline)
                    }
                    Spacer()
                    Image(systemName: activity.image)
                        .foregroundStyle(Color.green)
                }
                Text(activity.amount)
                    .foregroundStyle(Color("Goldenish"))
                    .bold()
                    .font(.title3)
            }
            .safeAreaPadding()
        }
        .foregroundStyle(Color.white)
    }
}

#Preview {
    ActivityView(activity: Activity(id: 0, title: "Daily Steps", subTitle: "Goal: 10000", image: "figure.walk", amount: "10000"))
}
