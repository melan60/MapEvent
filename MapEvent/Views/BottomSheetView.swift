//
//  BottomSheetView.swift
//  MapEvent
//
//  Created by benoit melanie on 04/12/2023.
//

import SwiftUI

struct BottomSheetView: View {
    let names = ["Holly", "Josh", "Rhonda", "Ted", "Teddy"]
    let person = Person(id_person: 1, firstname: "firstname", lastname: "name", email: "email", company: "company", activity: "activity", isPlaced: false)
    @StateObject var viewModel = ViewModel(service:ApiService())

    @State private var showingCredits = false
    @State private var searchText = ""
    
    // List of heights from 0.15 to 1.0 increasing by 0.1
    let heights = stride(from: 0.15, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }

    var body: some View {
        Button("Show Credits") {
            showingCredits.toggle()
        }
        .sheet(isPresented: $showingCredits) {
            VStack {
                HStack {
                    NavigationStack{
                        Text("")
                        switch(viewModel.state) {
                            case .loading:
                                ProgressView()
                            case .success(let persons):
                                ForEach(persons, id: \.self) { personne in
                                    NavigationLink {
                                        ProfilView(profile: personne)
                                            .presentationDetents([.large])
                                    } label: {
                                        Image(systemName: "person.circle")
                                        Text(personne.firstname)
                                            .cornerRadius(20)
                                    }
                                }
                        default:
                            Text("oskour")
                            EmptyView()
                        }
                            List {
                                
                            }
                            .toolbar {
                                Button("Lieu") {
                                    print("Lieu tapped!")
                                }

                                Button("Profil") {
                                    print("Profil tapped!")
                                }
                            }
                    }
                    .searchable(text: $searchText, prompt: "Un lieu, une personne...")
                }
            }
            .presentationDetents(Set(heights))
            .presentationCornerRadius(30)
            .presentationBackgroundInteraction(.enabled)
            .interactiveDismissDisabled()
            .task {
                await viewModel.getAllPersons()
            }
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
        
        var searchResults: [String] {
               if searchText.isEmpty {
                   return names
               } else {
                   return names.filter { $0.lowercased().contains(searchText.lowercased()) }
               }
           }
    }
    
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView()
    }
}
