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
    var body: some View {
        VStack {
            if isUnlocked {
                TabView {
                    PeopleView()
                        .tabItem {
                            Label("Characters", systemImage: "person.3.sequence")
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
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                    print("Problem!")
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
