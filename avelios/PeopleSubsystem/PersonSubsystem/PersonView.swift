//
//  PersonView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 04.12.24.
//

import SwiftUI

struct PersonView: View {
    let person: Person
    @Bindable var viewModel: PeopleViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack {
                    Text(person.name)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            viewModel.personColor(gender: person.gender.lowercased())
                        )
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                VStack(spacing: 15) {
                    ForEach(groupedAttributes, id: \.self) { row in
                        HStack(spacing: 15) {
                            ForEach(row, id: \.title) { attribute in
                                AttributeCard(icon: attribute.icon, title: attribute.title, value: attribute.value)
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
                VStack(alignment: .leading, spacing: 10) {
                    Text("Homeworld")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Link(destination: URL(string: person.homeworld)!) {
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.blue)
                            Text(person.homeworld)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .underline()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.green.opacity(0.15))
                        )
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.green.opacity(0.1))
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                
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
    private var groupedAttributes: [[AttributeRow]] {
        [
            [
                AttributeRow(icon: "ruler", title: "Height", value: "\(person.height) cm"),
                AttributeRow(icon: "scalemass", title: "Mass", value: "\(person.mass) kg")
            ],
            [
                AttributeRow(icon: "paintbrush", title: "Hair Color", value: person.hairColor.capitalized),
                AttributeRow(icon: "drop.fill", title: "Skin Color", value: person.skinColor.capitalized)
            ],
            [
                AttributeRow(icon: "eye.fill", title: "Eye Color", value: person.eyeColor.capitalized),
                AttributeRow(icon: "calendar", title: "Birth Year", value: person.birthYear)
            ]
        ]
    }
}

// Attribute Card for Each Attribute
struct AttributeCard: View {
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

// Struct for managing attribute rows
struct AttributeRow: Hashable {
    let icon: String
    let title: String
    let value: String
}


#Preview {
    PersonView(person: .init(id: UUID(), name: "Anakin Skywalker", height: "182",mass: "100", hairColor: "Blond", skinColor: "Black", eyeColor: "Blue", birthYear: "1970", gender: "male", homeworld: "Tatooine"), viewModel: PeopleViewModel())
}
