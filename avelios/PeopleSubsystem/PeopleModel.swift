//
//  People.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation

struct PeopleModel: Codable {
    var id = UUID()
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Person]
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

struct Person: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass, hairColor = "hair_color", skinColor = "skin_color", eyeColor = "eye_color", birthYear = "birth_year", gender, homeworld
    }
}
