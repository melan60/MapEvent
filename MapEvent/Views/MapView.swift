//
//  MapView.swift
//  MapEvent
//
//  Created by fernandes adrien on 06/12/2023.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let id_place: Int
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @StateObject var viewModelPlaces = ViewModelPlaces(service:ApiService())
    @StateObject var viewModel = ViewModel(service:ApiService())

    @State private var showingCredits = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.7235038, longitude: 3.1605714), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @State private var placeClicked = "Le Saint Martin"
    @State private var idClicked = 2

    @State private var currentUser: Person = Person(id_person: 0, firstname: "", lastname: "", email: "", company: "", activity: "", is_placed: false)

    var body: some View {
        NavigationStack{
            ZStack(alignment: .topTrailing){
                ZStack {
                    switch(viewModelPlaces.state) {
                        case .loading:
                            ProgressView()

                        case .success(let locations):
                            Map(coordinateRegion: $region, annotationItems: locations, annotationContent: {
                                location in
                                MapAnnotation(
                                    coordinate: location.coordinate,
                                    content: {
                                        Button {
                                            placeClicked = location.name
                                            idClicked = location.id_place
        //                                    if(showingCredits == false){
                                            showingCredits.toggle()
        //                                    }
                                            
                                        } label: {
                                            HStack() {
                                                // Image(systemName: "pin.fill").foregroundColor(.red)
                                                Text(location.name)
                                                    .bold()
                                            }.foregroundColor(.blue)
                                        }
                                        .sheet(isPresented: $showingCredits){
        //                                    BottomSheetView(lieu : location.name, id_place: location.id_place, currentUser: currentUser)
        //                                    BottomSheetView(lieu : String(idClicked), id_place: idClicked, currentUser: currentUser)
                                            BottomSheetView(lieu : placeClicked, id_place: idClicked, currentUser: currentUser)
                                        }
                                    }
                                )
                            }).edgesIgnoringSafeArea(.all)

                        NavigationLink{
                            ProfileEditView(profile: currentUser)
                        } label: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width:60, height: 60)
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing,10)
                        .padding(.bottom, 700)
                        .padding(.leading, 250)

                        default:
                            EmptyView()
                    }
                }
                .task {
                    do {
                        currentUser = try await viewModel.getAllPersons()
                    } catch {
                        print(error)
                    }
                    await viewModelPlaces.getAllPlaces()
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
