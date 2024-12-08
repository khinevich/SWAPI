// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StarShipsQuery: GraphQLQuery {
  public static let operationName: String = "StarShipsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query StarShipsQuery { allStarships { __typename totalCount starships { __typename name manufacturers costInCredits length maxAtmospheringSpeed crew passengers consumables starshipClass } } }"#
    ))

  public init() {}

  public struct Data: SWAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { SWAPI.Objects.Root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("allStarships", AllStarships?.self),
    ] }

    public var allStarships: AllStarships? { __data["allStarships"] }

    /// AllStarships
    ///
    /// Parent Type: `StarshipsConnection`
    public struct AllStarships: SWAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { SWAPI.Objects.StarshipsConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("totalCount", Int?.self),
        .field("starships", [Starship?]?.self),
      ] }

      /// A count of the total number of objects in this connection, ignoring pagination.
      /// This allows a client to fetch the first five objects by passing "5" as the
      /// argument to "first", then fetch the total count so it could display "5 of 83",
      /// for example.
      public var totalCount: Int? { __data["totalCount"] }
      /// A list of all of the objects returned in the connection. This is a convenience
      /// field provided for quickly exploring the API; rather than querying for
      /// "{ edges { node } }" when no edge data is needed, this field can be be used
      /// instead. Note that when clients like Relay need to fetch the "cursor" field on
      /// the edge to enable efficient pagination, this shortcut cannot be used, and the
      /// full "{ edges { node } }" version should be used instead.
      public var starships: [Starship?]? { __data["starships"] }

      /// AllStarships.Starship
      ///
      /// Parent Type: `Starship`
      public struct Starship: SWAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { SWAPI.Objects.Starship }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("manufacturers", [String?]?.self),
          .field("costInCredits", Double?.self),
          .field("length", Double?.self),
          .field("maxAtmospheringSpeed", Int?.self),
          .field("crew", String?.self),
          .field("passengers", String?.self),
          .field("consumables", String?.self),
          .field("starshipClass", String?.self),
        ] }

        /// The name of this starship. The common name, such as "Death Star".
        public var name: String? { __data["name"] }
        /// The manufacturers of this starship.
        public var manufacturers: [String?]? { __data["manufacturers"] }
        /// The cost of this starship new, in galactic credits.
        public var costInCredits: Double? { __data["costInCredits"] }
        /// The length of this starship in meters.
        public var length: Double? { __data["length"] }
        /// The maximum speed of this starship in atmosphere. null if this starship is
        /// incapable of atmosphering flight.
        public var maxAtmospheringSpeed: Int? { __data["maxAtmospheringSpeed"] }
        /// The number of personnel needed to run or pilot this starship.
        public var crew: String? { __data["crew"] }
        /// The number of non-essential people this starship can transport.
        public var passengers: String? { __data["passengers"] }
        /// The maximum length of time that this starship can provide consumables for its
        /// entire crew without having to resupply.
        public var consumables: String? { __data["consumables"] }
        /// The class of this starship, such as "Starfighter" or "Deep Space Mobile
        /// Battlestation"
        public var starshipClass: String? { __data["starshipClass"] }
      }
    }
  }
}
