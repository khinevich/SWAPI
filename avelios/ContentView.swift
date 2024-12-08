//
//  ContentView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var authenticationFailed = false
    var body: some View {
        VStack {
            if isUnlocked {
                TabView {
                    PeopleView()
                        .tabItem {
                            Label(
                                "Characters",
                                systemImage: "person.3.sequence"
                            )
                        }
                    StarShipsView()
                        .tabItem {
                            Label("Star Ships", systemImage: "airplane.circle")
                        }
                    PlanetsView()
                        .tabItem {
                            Label("Planets", systemImage: "globe.americas")
                        }
                }
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.red)
                    Text(
                        authenticationFailed ? "Authentication Failed" : "Locked"
                    )
                    .font(.title)
                    .fontWeight(.semibold)
                    Button(action: authenticate) {
                        Text("Retry Authentication")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                }
                .padding()
            }
        }
        .onAppear(perform: authenticate)
    
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context
            .canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: &error
            ) {
            let reason = "We need to unlock your data."

            context
                .evaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: reason
                ) { success, authenticationError in
                    if success {
                        isUnlocked = true
                        authenticationFailed = false
                    } else {
                        print("Problem!")
                        authenticationFailed = true
                    }
                }
        } else {
            print("No Biometrics available")
        }
    }
}
#Preview {
    ContentView()
}
