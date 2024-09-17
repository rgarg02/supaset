//
//  WelcomeScreenView.swift
//  FinalProject
//
//  Created by Rishi Garg on 4/23/24.
//

import SwiftUI
protocol WelcomePageProtocol: View {
    var id: UUID { get }
}
struct WelcomeScreenView: View {
    @AppStorage("hasShownWelcomeScreen") var hasShownWelcomeScreen: Bool = false

    private var pages: [AnyView] = [
        AnyView(WelcomeView()),
        AnyView(PermissionsView()),
        AnyView(GoalsView())
    ]
    var body: some View {
        TabView {
            ForEach(pages.indices, id: \.self) { index in
                pages[index]
                    .tag(index)
                    .if(index == pages.count - 1) {
                        $0.overlay(
                            Button(action: {
                                finishOnboarding()
                            }, label: {
                                Text("Get Started")
                                    .bold()
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            })
                            .padding(), alignment: .bottomTrailing
                        )
                    }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    private func finishOnboarding() {
            hasShownWelcomeScreen = true
        }
}
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
struct WelcomePageProtocol_Preview : PreviewProvider {
    static var previews: some View{
        WelcomeScreenView()
            .environmentObject(HealthStore())
    }
}
