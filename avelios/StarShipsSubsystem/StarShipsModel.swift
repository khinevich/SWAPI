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


struct StarShip: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let crew: String
    let passengers: String
    let consumables: String
    let starShipClass: String
    
    enum CodingKeys: String, CodingKey {
        case name, manufacturer, costInCredits = "cost_in_credits", length, maxAtmospheringSpeed = "max_atmosphering_speed", crew, passengers, consumables, starShipClass = "starship_class"
    }
}

struct StarShipsGraphQL: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let manufacturers: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let crew: String
    let passengers: String
    let consumables: String
    let starShipClass: String
//    {
//        "__typename" = Starship;
//        consumables = "15 hours";
//        costInCredits = 102500;
//        crew = 1;
//        length = "7.9";
//        manufacturers =     (
//            "Kuat Systems Engineering"
//        );
//        maxAtmospheringSpeed = 1050;
//        name = "V-wing";
//        passengers = 0;
//        starshipClass = starfighter;
//    }
}


