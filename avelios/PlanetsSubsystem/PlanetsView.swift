//
//  PlanetsView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import SwiftUI

struct PlanetsView: View {
    @State private var viewModel = PlanetViewModel()
    var body: some View {
        NavigationView {
            List (viewModel.planets) { planet in
                VStack(alignment: .leading) {
                    Text("Name: \(planet.name)")
                        .font(.headline)
                    Text("Rotation: \(planet.rotationPeriod)")
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("Planets")
            .task { //why not onAppear? cause it asynchronous
                await viewModel.fetchPlanets()
            }
        }
    }
}

#Preview {
    PlanetsView()
}
