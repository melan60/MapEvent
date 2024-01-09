//
//  BottomSheetView.swift
//  MapEvent
//
//  Created by benoit melanie on 04/12/2023.
//

import SwiftUI

struct BottomSheetView: View {

    var lieu : String
    var id_place : Int
    var currentUser: Person

    @StateObject var viewModelPersonByPlace = ViewModelPersonInPlace(service:ApiService()) //récupère la liste des personnes présentes sur le lieu sélectionné
    
    @State private var searchText = ""
    
    // List of heights from 0.15 to 1.0 increasing by 0.1
    let heights = stride(from: 0.2, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
//            Text(lieu)
//                .padding(.trailing, 120)
//                .padding(.top,10)
//                .bold()
            HStack {
                
                NavigationStack {
                    switch(viewModelPersonByPlace.state) {
                        case .loading:
                            ProgressView()

                        case .success(let persons):
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(searchResults, id: \.self) { person in
                                    NavigationLink {
                                        ProfilView(profile: person)
                                            .presentationDetents([.large])
                                    } label: {
                                        VStack {
                                            Image(systemName: "person.circle")
                                            Text(person.firstname)
                                            Text(person.lastname)
//                                                    .cornerRadius(20)
                                        }
                                        .padding(0)
                                        .frame(height: 40)
                                    }
                                }
                            }.padding(.top,10)
                        
                        
                            List {
                                
                            }
                            .toolbar {
                                
                                ToolbarItem(placement: .navigationBarLeading){
                                    Text(lieu)
                                        .bold()
                                        .padding(.leading,1)
                                }
                                ToolbarItem(placement: .navigationBarTrailing){
                                    if (persons.contains(currentUser)) {
                                        Button("Partir du lieu") {
                                            deleteLocation(currentUser: currentUser)
                                        }
                                    } else {
                                        Button("Se placer ici") {
                                            addLocation(currentUser: currentUser)
                                        }
                                    }
                                }                                
                                
                            }
                            .padding(.trailing, 5)

                            var searchResults: [Person] {
                                if searchText.isEmpty {
                                    return persons
                                } else {
                                    return persons.filter { $0.firstname.lowercased().contains(searchText.lowercased()) ||
                                        $0.lastname.lowercased().contains(searchText.lowercased())
                                    }
                                }
                            }
                        default:
                            EmptyView()
                    }
                }
                .searchable(text: $searchText, prompt: "Une personne...")
            }
        }
        .presentationDetents(Set(heights))
        .presentationCornerRadius(30)
        .presentationBackgroundInteraction(.enabled)
        .interactiveDismissDisabled()
        .task {
            await viewModelPersonByPlace.getAllPersonsByPlace(id_place: id_place)
        }


//            NavigationStack {
//                Text("test")
//                        List {
//                            ForEach(searchResults, id: \.self) { name in
//                                NavigationLink {
//                                    ProfilView()
//                                        .presentationDetents([.large])
//                                        .presentationDragIndicator(.hidden)
//                                } label: {
//                                    Text(name)
//                                }
//                            }
//                        }
//                    }
//            .searchable(text: $searchText, prompt: "Un lieu, une personne...")
//                    .frame(width:80)
            //Text("This app was brought to you by Hacking with Swift")
//                .presentationDetents(Set(heights))
//                .presentationBackground(.clear)
//                .presentationCornerRadius(30)
//                .presentationBackgroundInteraction(.enabled)
//                .interactiveDismissDisabled()
//        }
        
//        var searchResults: [String] {
//               if searchText.isEmpty {
//                   return persons
//               } else {
//                   return names.filter { $0.lowercased().contains(searchText.lowercased()) }
//               }
//           }
    }
    
    func addLocation(currentUser: Person) {
        Task {
            await viewModelPersonByPlace.addPlace(id_place: id_place, id_person: currentUser.id_person)
            await viewModelPersonByPlace.getAllPersonsByPlace(id_place: id_place)
        }
    }
    
    func deleteLocation(currentUser: Person) {
        Task {
            await viewModelPersonByPlace.deletePlace(id_person: currentUser.id_person)
            await viewModelPersonByPlace.getAllPersonsByPlace(id_place: id_place)
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(lieu: "Nom lieu", id_place: 4, currentUser: Person(id_person: 1, firstname: "Bruno", lastname: "Charles", email: "bru@gmail.com", company: "Apple", activity: "Développeur", is_placed: true))
    }
}
