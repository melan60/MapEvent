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
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @StateObject var viewModelPlaces = ViewModelPlaces(service:ApiService())
    
    @State private var showingCredits = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.7235038, longitude: 3.1605714), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        NavigationStack{
        ZStack(alignment: .topTrailing){
            VStack {
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
                                    showingCredits.toggle()
                                } label: {
                                    HStack() {
                                        // Image(systemName: "pin.fill").foregroundColor(.red)
                                        Text(location.name)
                                            .bold()
                                    }.foregroundColor(.blue)
                                }
                                .sheet(isPresented: $showingCredits){
                                    BottomSheetView()
                                }
                            }
                        )
                        
                    })
                    .edgesIgnoringSafeArea(.all)
                    default:
                        EmptyView()
                }
            }
            .task {
                await viewModelPlaces.getAllPlaces()
            }
            NavigationLink{
                    ProfilView(profile : Person(id_person: 1, firstname: "firstname", lastname: "name", email: "email", company: "company", activity: "activity", is_placed: false))
                } label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width:60, height: 60)
                        .foregroundColor(.blue)
                }
                .padding(.trailing,10)
            }
                
            }
        }     
    }


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
