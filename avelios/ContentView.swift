//
//  ContentView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
    }
}
#Preview {
    ContentView()
}
