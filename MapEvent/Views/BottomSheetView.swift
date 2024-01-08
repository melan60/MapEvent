//
//  BottomSheetView.swift
//  MapEvent
//
//  Created by benoit melanie on 04/12/2023.
//

import SwiftUI

struct BottomSheetView: View {
    @StateObject var viewModel = ViewModel(service:ApiService())
    
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
            HStack {
                NavigationStack{
                    switch(viewModel.state) {
                        case .loading:
                            ProgressView()
                        case .success(let persons):
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(persons, id: \.self) { person in
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
                            var searchResults: [Person] {
                                if searchText.isEmpty {
                                    return persons
                                } else {
                                    return persons.filter { $0.firstname.lowercased().contains(searchText.lowercased()) }
                                }
                            }
                        
                        default:
                            EmptyView()
                        }
                            List {
                                
                            }
                            .toolbar {
                                Button("Lieu") {
                                    print("Lieu tapped!")
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
    
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView()
    }
}
