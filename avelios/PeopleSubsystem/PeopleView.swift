//
//  CharactersView.swift
//  avelios
//
//  Created by Mikhail Khinevich on 03.12.24.
//

import SwiftUI

struct PeopleView: View {
    @State private var viewModel = PeopleViewModel()
    @State var loadedOnce: Bool = false
    @State var selection = 0
    var body: some View {
        NavigationStack {
            List {
                ForEach(
                    selection==0 ? viewModel.people: viewModel.favouritePeople
                ) { person in
                    if (selection==1) {
                        NavigationLink(value: person) {
                            HStack(spacing: 15) {
                                Image(
                                    systemName: viewModel.logo(gender: person.gender.lowercased())
                                )
                                .font(.system(size: 24))
                                .foregroundColor(
                                    viewModel.personColor(gender: person.gender.lowercased())
                                )
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(person.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text(person.gender.capitalized)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                        }.swipeActions(edge: .trailing) {
                            Button {
                                print("removing")
                                if let index = viewModel.favouritePeople.firstIndex(
                                    of: person
                                ) {
                                    viewModel.favouritePeople.remove(at: index)
                                }
                            } label: {
                                Label("Subtract", systemImage: "minus.circle")
                            }
                            .tint(.red)
                        }
                    } else {
                        NavigationLink(value: person) {
                            HStack(spacing: 15) {
                                    Image(
                                        systemName: viewModel.logo(gender: person.gender.lowercased())
                                    )
                                    .font(.system(size: 24))
                                    .foregroundColor(viewModel.personColor(gender: person.gender.lowercased())
                                                     )
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(person.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text(person.gender.capitalized)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                print("adding")
                                viewModel.favouritePeople.append(person)
                            } label: {
                                Label(
                                    "Add to favourites",
                                    systemImage: "plus.circle"
                                )
                            }
                            .tint(.green)
                        }
                    }
                }
                if viewModel.canLoadMore() && selection==0 {
                    Text("Fetching data...")
                        .onAppear(perform: {
                            Task {
                                await viewModel.fetchPeople()
                            }
                        })
                }
            }
            .onAppear{
                Task {
                    if loadedOnce == false && selection==0 {
                        await viewModel.fetchPeople()
                        loadedOnce = true
                    }
                }
            }
            .navigationBarTitle("Star Wars Characters")
            .navigationBarItems(trailing:
                                    Picker("filter", selection: $selection) {
                Text("All").tag(0)
                Text("Favourites").tag(1)
            }.pickerStyle(.menu)
            )
            .navigationDestination(for: Person.self) { person in
                PersonView(person: person, viewModel: viewModel)
            }
        }
    }
}


#Preview {
    PeopleView()
}
