//
//  StarShipsViewModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
import SWAPI
@Observable class StarShipsViewModel {
    var starShips = [StarShip]()
    //var favouriteStarShips = [StarShip]()
    
    var starShipsGraphQL = [StarShipsGraphQL]()
    var favouriteStarShips = [StarShipsGraphQL]()
    
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
    
    
    
    func fetchQueryStarShips() async {
        let query = StarShipsQuery()
        
        ApolloService.shared.client.fetch(query: query) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let fetchedStarships = graphQLResult.data?.allStarships?.starships?.compactMap({ $0 }) {
                    self?.starShipsGraphQL = fetchedStarships.map { starShipGraphQL in
                        StarShipsGraphQL(
                            name: starShipGraphQL.name ?? "Unknown",
                            manufacturers: starShipGraphQL.manufacturers?.compactMap { $0 }.joined(separator: ", ") ?? "Unknown",
                            costInCredits: starShipGraphQL.costInCredits?.description ?? "Uknown",
                            length: starShipGraphQL.length?.description ?? "Uknown",
                            maxAtmospheringSpeed: starShipGraphQL.maxAtmospheringSpeed?.description ?? "Uknown",
                            crew: starShipGraphQL.crew ?? "Unknown",
                            passengers: starShipGraphQL.passengers ?? "Unknown",
                            consumables: starShipGraphQL.consumables ?? "Unknown",
                            starShipClass: starShipGraphQL.starshipClass ?? "Unknown"
                        )
                    }
                }
            case .failure(let error):
                print("GraphQL Fetch Error: \(error)")
            }
        }
        print(self.starShipsGraphQL)
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
    func isFavorite(starship: StarShipsGraphQL) -> Bool {
        favouriteStarShips.contains(starship)
    }
}
