//
//  PlanetsView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import SwiftUI

struct PlanetsView: View {
    @State private var viewModel = PlanetViewModel()
    @State var loadedOnce: Bool = false
    @State var selection = 0
    var body: some View {
        NavigationStack {
            List {
                ForEach(
                    selection==0 ? viewModel.planets: viewModel.favouritePlanets
                ) { planet in
                    if (selection==1) {
                        NavigationLink(value: planet) {
                            HStack(spacing: 15) {
                                // Icon for Starship
                                Image(systemName: "globe.americas")
                                    .font(.system(size: 24))
                                    .foregroundColor(.green)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(planet.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text(
                                        "Surface: \(planet.terrain)"
                                    )
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                }
                            }
                            .padding(.vertical, 8)
                        }.swipeActions(edge: .trailing) {
                            Button {
                                print("removing")
                                if let index = viewModel.favouritePlanets.firstIndex(
                                    of: planet
                                ) {
                                    viewModel.favouritePlanets
                                        .remove(at: index)
                                }
                            } label: {
                                Label("Remove from Favorites", systemImage: "minus.circle")
                            }
                            .tint(.red)
                        }
                    } else {
                        NavigationLink(value: planet) {
                            HStack(spacing: 15) {
                                // Icon for Starship
                                Image(systemName: "globe.americas")
                                    .font(.system(size: 24))
                                    .foregroundColor(.green)
                                
                                // Starship Details
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(planet.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text(
                                        "Surface: \(planet.terrain)"
                                    )
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    
                                }
                                Spacer()

                                // Favorite Indicator
                                if viewModel.isFavorite(planet: planet) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 20))
                                }
                                Spacer()
                            }
                            .padding(.vertical, 8)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                if viewModel.isFavorite(planet: planet) {
                                    viewModel.favouritePlanets.removeAll { $0.id == planet.id }
                                } else {
                                    viewModel.favouritePlanets.append(planet)
                                }
                            } label: {
                                Label(
                                    viewModel.isFavorite(planet: planet) ? "Remove from Favorites" : "Add to Favorites",
                                    systemImage: viewModel.isFavorite(planet: planet) ? "star.slash.fill" : "star.fill"
                                )
                            }
                            .tint(viewModel.isFavorite(planet: planet) ? .red : .green)
                        }
                    }
                }
                if viewModel.canLoadMore() && selection==0 {
                    Text("Fetching data...")
                        .onAppear(perform: {
                            Task {
                                await viewModel.fetchPlanets()
                            }
                        })
                }
            }
//            .onAppear{
//                Task {
//                    if loadedOnce == false && selection==0 {
//                        await viewModel.fetchPlanets()
//                        loadedOnce = true
//                    }
//                }
//            }
            .navigationTitle("Planets")
            .navigationBarItems(trailing:
                                    Picker("filter", selection: $selection) {
                Text("All").tag(0)
                Text("Favourites").tag(1)
            }.pickerStyle(.menu)
            )
            .navigationDestination(for: Planet.self) { planet in
                PlanetView(planet: planet)
            }
        }
    }
}

#Preview {
    PlanetsView()
}
