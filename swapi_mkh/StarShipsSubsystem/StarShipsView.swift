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
            List (selection == 0 ? viewModel.starShipsGraphQL: viewModel.favouriteStarShips) { starship in
                if (selection==1) {
                    NavigationLink(value: starship) {
                        HStack(spacing: 15) {
                            Image(systemName: "airplane")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                        
                            VStack(alignment: .leading, spacing: 5) {
                                Text(starship.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(
                                    "Manufacturer: \(starship.manufacturers)"
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
                            if let index = viewModel.favouriteStarShips.firstIndex(
                                of: starship
                            ) {
                                viewModel.favouriteStarShips
                                    .remove(at: index)
                            }
                        } label: {
                            Label("Remove from Favorites", systemImage: "minus.circle")
                        }
                        .tint(.red)
                    }
                } else {
                    NavigationLink(value: starship) {
                        HStack(spacing: 15) {
                            Image(systemName: "airplane")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(starship.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("Manufacturer: \(starship.manufacturers)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text("Crew: \(starship.crew)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            if viewModel.isFavorite(starship: starship) {
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
                            if viewModel.isFavorite(starship: starship) {
                                viewModel.favouriteStarShips.removeAll { $0.id == starship.id }
                            } else {
                                viewModel.favouriteStarShips.append(starship)
                            }
                        } label: {
                            Label(
                                viewModel.isFavorite(starship: starship) ? "Remove from Favorites" : "Add to Favorites",
                                systemImage: viewModel.isFavorite(starship: starship) ? "star.slash.fill" : "star.fill"
                            )
                        }
                        .tint(viewModel.isFavorite(starship: starship) ? .red : .green)
                    }
                }            }
            .navigationTitle("Starships")
            .navigationBarItems(trailing:
                                    Picker("filter", selection: $selection) {
                Text("All").tag(0)
                Text("Favourites").tag(1)
            }.pickerStyle(.menu)
            )
            .navigationDestination(for: StarShipsGraphQL.self) { starship in
                StarShipView(starship: starship)
            }
            .onAppear {
                Task {
                    await viewModel.fetchQueryStarShips()
                }
            }
        }
    }
}


#Preview {
    StarShipsView()
}
