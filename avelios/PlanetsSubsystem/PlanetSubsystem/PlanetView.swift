//
//  PlanetView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 06.12.24.
//

import SwiftUI

struct PlanetView: View {
    let planet: Planet

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Title Section
                VStack {
                    Text(planet.name)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.green) // Planets have a consistent theme color (green)
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)

                // Attributes Section
                VStack(spacing: 15) {
                    ForEach(groupedAttributes, id: \.self) { row in
                        HStack(spacing: 15) {
                            ForEach(row, id: \.title) { attribute in
                                AttributeCardPlanet(icon: attribute.icon, title: attribute.title, value: attribute.value)
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

    // Group attributes into rows with 2 items each
    private var groupedAttributes: [[AttributeRowPlanet]] {
        [
            [
                AttributeRowPlanet(icon: "clock", title: "Rotation Period", value: "\(planet.rotationPeriod) hours"),
                AttributeRowPlanet(icon: "calendar", title: "Orbital Period", value: "\(planet.orbitalPeriod) days")
            ],
            [
                AttributeRowPlanet(icon: "thermometer.sun", title: "Climate", value: planet.climate),
                AttributeRowPlanet(icon: "globe.europe.africa", title: "Gravity", value: planet.gravity)
            ],
            [
                AttributeRowPlanet(icon: "mountain.2", title: "Terrain", value: planet.terrain),
                AttributeRowPlanet(icon: "drop.fill", title: "Surface Water", value: "\(planet.surfaceWater)%")
            ],
            [
                AttributeRowPlanet(icon: "person.3.fill", title: "Population", value: planet.population.isEmpty ? "Unknown" : planet.population)
            ]
        ]
    }
}

// Struct for managing attribute rows
struct AttributeRowPlanet: Hashable {
    let icon: String
    let title: String
    let value: String
}

// Attribute Card for Each Attribute
struct AttributeCardPlanet: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.green)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color.green.opacity(0.15))
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
    PlanetView(
        planet: Planet(
            id: UUID(),
            name: "Tatooine",
            rotationPeriod: "23",
            orbitalPeriod: "304",
            climate: "Arid",
            gravity: "1 standard",
            terrain: "Desert",
            surfaceWater: "1",
            population: "200000"
        )
    )
}
