//
//  PeopleViewModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
import SwiftUICore
import Apollo
import SWAPI


@Observable class PeopleViewModel {
    var people = [Person]()
    
    var favouritePeople = [Person]()
    
    var currentPage = 0
    private var totalPages = 1
    var planetName = ""
    
    func fetchPeople() async {
        if !canLoadMore() {
            return print("Can't load more")
        }
        loadNextPage()
        let urlString = "https://swapi.dev/api/people/?page=\(currentPage)"
        print("Fetching Model")
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(PeopleModel.self, from: data)
            people.append(contentsOf: decodedResponse.results)
            totalPages = (decodedResponse.count! / decodedResponse.results.count) + 1
            print("Total Pages \(totalPages)")
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchPlanetName(from link: String) async {
            guard let planetID = link.split(separator: "/").last else {
                print("Invalid planet URL")
                return
            }
        let query = PlanetQuery(planetId: GraphQLNullable(stringLiteral: String(planetID)))

            ApolloService.shared.client.fetch(query: query) { [weak self] result in
                switch result {
                case .success(let graphQLResult):
                    if let name = graphQLResult.data?.planet?.name {
                        self?.planetName = name
                    } else {
                        DispatchQueue.main.async {
                            self?.planetName = "Unknown Planet"
                        }
                    }
                case .failure(let error):
                    print("GraphQL Fetch Error: \(error)")
                    DispatchQueue.main.async {
                        self?.planetName = "Error Fetching Planet"
                    }
                }
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
    
    func logo(gender: String) -> String {
        if (gender=="male") {
            return "figure.stand"
        } else if (gender=="female") {
            return "figure.stand.dress"
        } else {
            return "person.fill.questionmark"
        }
    }
    
    func personColor(gender: String) -> Color {
        if (gender=="male") {
            return Color.blue
        } else if (gender=="female") {
            return Color.pink
        } else {
            return Color.gray
        }
    }
    func isFavorite(person: Person) -> Bool {
        favouritePeople.contains(person)
        }

}
