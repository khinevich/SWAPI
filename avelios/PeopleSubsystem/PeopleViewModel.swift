//
//  PeopleViewModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
import SwiftUICore

@Observable class PeopleViewModel {
    var people = [Person]()
    
    var favouritePeople = [Person]()
    
    var currentPage = 0
    private var totalPages = 1
    
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
            print(people)
            totalPages = (decodedResponse.count! / decodedResponse.results.count) + 1
            print("Total Pages \(totalPages)")
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
}
