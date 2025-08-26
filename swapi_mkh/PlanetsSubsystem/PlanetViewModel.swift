//
//  PlanetViewModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
@Observable class PlanetViewModel {
    var planets = [Planet]()
    var favouritePlanets = [Planet]()
    
    var currentPage=0
    private var totalPages = 1
    
    func fetchPlanets() async {
        if !canLoadMore() {
            return print("Can't load more")
        }
        loadNextPage()
        
        var urlString = "https://swapi.dev/api/planets/?=page=\(currentPage)"
         
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(PlanetModel.self, from: data)
            planets.append(contentsOf: decodedResponse.results)
            totalPages = (decodedResponse.count! / decodedResponse.results.count) + 1
        } catch {
            print("Error: \(error)")
        }
    }
    
    func loadNextPage() {
        if canLoadMore() {
            currentPage += 1            
        }
    }
    func canLoadMore() -> Bool {
        return currentPage <= totalPages
    }
    func isFavorite(planet: Planet) -> Bool {
        favouritePlanets.contains(planet)
        }
}
