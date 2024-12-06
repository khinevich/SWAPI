//
//  StarShipsModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
struct StarShipsModel: Codable {
    var id = UUID()
    let count: Int?
    let next: String?
    let previous: String?
    let results: [StarShip]
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

struct StarShip: Codable, Identifiable {
    var id = UUID()
    let name: String
    let manufacturer: String
    
    enum CodingKeys: String, CodingKey {
        case name, manufacturer
    }
}
