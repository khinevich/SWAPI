// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PlanetQuery: GraphQLQuery {
  public static let operationName: String = "PlanetQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query PlanetQuery($planetId: ID) { planet(planetID: $planetId) { __typename name } }"#
    ))

  public var planetId: GraphQLNullable<ID>

  public init(planetId: GraphQLNullable<ID>) {
    self.planetId = planetId
  }

  public var __variables: Variables? { ["planetId": planetId] }

  public struct Data: SWAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { SWAPI.Objects.Root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("planet", Planet?.self, arguments: ["planetID": .variable("planetId")]),
    ] }

    public var planet: Planet? { __data["planet"] }

    /// Planet
    ///
    /// Parent Type: `Planet`
    public struct Planet: SWAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { SWAPI.Objects.Planet }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String?.self),
      ] }

      /// The name of this planet.
      public var name: String? { __data["name"] }
    }
  }
}
