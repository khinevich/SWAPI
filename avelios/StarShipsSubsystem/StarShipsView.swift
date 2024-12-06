//
//  StarShipsView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import SwiftUI

struct StarShipsView: View {
    @State private var viewModel = StarShipsViewModel()
    var body: some View {
        NavigationView {
            List (viewModel.starShips, id: \.id) { starShip in
                VStack(alignment: .leading) {
                    Text("Name: \(starShip.name)")
                        .font(.headline)
                    Text("Manufacturer: \(starShip.manufacturer)")
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("StarShips")
            .task { //why not onAppear? cause it asynchronous
                await viewModel.fetchStarShips()
            }
        }
    }
}

#Preview {
    StarShipsView()
}
