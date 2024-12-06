//
//  PlanetModel.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import Foundation
struct PlanetModel: Codable {
    var id = UUID()
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Planet]
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

struct Planet: Codable, Identifiable {
    var id = UUID()
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    
    enum CodingKeys: String, CodingKey {
        case name, rotationPeriod = "rotation_period", orbitalPeriod = "orbital_period"
    }
}
