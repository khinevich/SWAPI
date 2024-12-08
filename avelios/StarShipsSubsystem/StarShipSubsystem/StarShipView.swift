//
//  StarShipView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 06.12.24.
//

import SwiftUI

struct StarShipView: View {
    //let starship: StarShip
    let starship: StarShipsGraphQL

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack {
                    Text(starship.name)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue) // Starships have a consistent theme color (blue)
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)

                VStack(spacing: 15) {
                    ForEach(groupedAttributes, id: \.self) { row in
                        HStack(spacing: 15) {
                            ForEach(row, id: \.title) { attribute in
                                AttributeCardShip(icon: attribute.icon, title: attribute.title, value: attribute.value)
                            }
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(UIColor.systemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)

                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
        )
    }

    private var groupedAttributes: [[AttributeRowShip]] {
        [
            [
                AttributeRowShip(icon: "building.2.crop.circle", title: "Manufacturer", value: starship.manufacturers),
                AttributeRowShip(icon: "dollarsign.circle", title: "Cost", value: starship.costInCredits.isEmpty ? "Unknown" : "\(starship.costInCredits) credits")
            ],
            [
                AttributeRowShip(icon: "ruler", title: "Length", value: "\(starship.length) meters"),
                AttributeRowShip(icon: "figure.stand", title: "Crew", value: starship.crew)
            ],
            [
                AttributeRowShip(icon: "person.3", title: "Passengers", value: starship.passengers),
                AttributeRowShip(icon: "gear", title: "Class", value: starship.starShipClass)
            ],
            [
                AttributeRowShip(icon: "speedometer", title: "Max Speed", value: "\(starship.maxAtmospheringSpeed)"),
                AttributeRowShip(icon: "clock", title: "Consumables", value: starship.consumables)
            ]
        ]
    }
}

struct AttributeRowShip: Hashable {
    let icon: String
    let title: String
    let value: String
}

struct AttributeCardShip: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color.blue.opacity(0.15))
                )

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
        )
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    StarShipView(
        starship: StarShipsGraphQL(
            id: UUID(),
            name: "Millennium Falcon",
            //model: "Desroyer",
            manufacturers: "Corellian Engineering Corporation",
            costInCredits: "100000",
            length: "34.37",
            maxAtmospheringSpeed: "1050",
            crew: "4",
            passengers: "6",
            //cargoCapacity: "1000people",
            consumables: "2 months",
            starShipClass: "Light Freighter"
        )
    )
}
