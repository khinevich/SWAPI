//
//  StarShipsView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import SwiftUI

struct StarShipsView: View {
    @State private var viewModel = StarShipsViewModel()
    @State var loadedOnce: Bool = false
    @State var selection = 0
    var body: some View {
        NavigationStack {
            List {
                ForEach(
                    selection==0 ? viewModel.starShips: viewModel.favouriteStarShips
                ) { starship in
                    if (selection==1) {
                        NavigationLink(value: starship) {
                            HStack(spacing: 15) {
                                // Icon for Starship
                                Image(systemName: "airplane")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                                
                                // Starship Details
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(starship.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text(
                                        "Manufacturer: \(starship.manufacturer)"
                                    )
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    
                                    Text("Crew: \(starship.crew)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                        }.swipeActions(edge: .trailing) {
                            Button {
                                print("removing")
                                if let index = viewModel.favouriteStarShips.firstIndex(
                                    of: starship
                                ) {
                                    viewModel.favouriteStarShips
                                        .remove(at: index)
                                }
                            } label: {
                                Label("Subtract", systemImage: "minus.circle")
                            }
                            .tint(.red)
                        }
                    } else {
                        NavigationLink(value: starship) {
                            HStack(spacing: 15) {
                                // Icon for Starship
                                Image(systemName: "airplane")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                                
                                // Starship Details
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(starship.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text(
                                        "Manufacturer: \(starship.manufacturer)"
                                    )
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    
                                    Text("Crew: \(starship.crew)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                            .background(
                                viewModel
                                    .isFavorite(starship: starship) ? Color.gray
                                    .opacity(0.2) : Color.clear
                            )
                        }.swipeActions(edge: .leading) {
                            Button {
                                print("adding")
                                viewModel.favouriteStarShips.append(starship)
                            } label: {
                                Label(
                                    "Add to favourites",
                                    systemImage: "plus.circle"
                                )
                            }
                            .tint(.green)
                        }
                    }
                }
                if viewModel.canLoadMore() && selection==0 {
                    Text("Fetching data...")
                        .onAppear(perform: {
                            Task {
                                await viewModel.fetchStarShips()
                            }
                        })
                }
            }
            .onAppear{
                Task {
                    if loadedOnce == false && selection==0 {
                        await viewModel.fetchStarShips()
                        loadedOnce = true
                    }
                }
            }
            .navigationTitle("Starships")
            .navigationBarItems(trailing:
                                    Picker("filter", selection: $selection) {
                Text("All").tag(0)
                Text("Favourites").tag(1)
            }.pickerStyle(.menu)
            )
            .navigationDestination(for: StarShip.self) { starship in
                StarShipView(starship: starship)
            }
        }
    }
}

#Preview {
    StarShipsView()
}
