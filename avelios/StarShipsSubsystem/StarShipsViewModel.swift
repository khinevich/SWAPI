//
//  StarShipsViewModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
@Observable class StarShipsViewModel {
    var starShips = [StarShip]()
    var urlString = "https://swapi.dev/api/starships/"
    
    func fetchStarShips() async {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(StarShipsModel.self, from: data)
            starShips = decodedResponse.results
        } catch {
            print("Error: \(error)")
        }
    }
}
