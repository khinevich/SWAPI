//
//  ApolloService.swift
//  avelios
//
//  Created by Mikhail Khinevich on 08.12.24.
//

import Foundation
import Apollo

class ApolloService {
    static let shared = ApolloService()

    private let url = URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!
    lazy var client = ApolloClient(url: url)
}
