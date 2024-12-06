//
//  StarShipsViewModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
@Observable class StarShipsViewModel {
    var starShips = [StarShip]()
    var favouriteStarShips = [StarShip]()
    
    var currentPage=0
    private var totalPages = 1
    
    func fetchStarShips() async {
        if !canLoadMore() {
            return print("Can't load more")
        }
        loadNextPage()
        let urlString = "https://swapi.dev/api/starships/?page=\(currentPage)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(StarShipsModel.self, from: data)
            starShips.append(contentsOf: decodedResponse.results)
            totalPages = (decodedResponse.count! / decodedResponse.results.count) + 1
        } catch {
            print("Error: \(error)")
        }
    }
    func loadNextPage() {
        if canLoadMore() {
            currentPage += 1
            print(currentPage)
        }
    }
    func canLoadMore() -> Bool {
        return currentPage <= totalPages
    }
    func isFavorite(starship: StarShip) -> Bool {
        favouriteStarShips.contains(starship)
        }
}
