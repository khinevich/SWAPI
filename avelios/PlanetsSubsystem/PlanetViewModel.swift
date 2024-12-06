//
//  PlanetViewModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
@Observable class PlanetViewModel {
    var planets = [Planet]()
    var urlString = "https://swapi.dev/api/planets/"
    
    func fetchPlanets() async {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(PlanetModel.self, from: data)
            planets = decodedResponse.results
        } catch {
            print("Error: \(error)")
        }
    }
}
