//
//  ProfileEditView.swift
//  MapEvent
//
//  Created by beaudru messaline on 20/12/2023.
//

import SwiftUI

struct ProfileEditView: View {
    @StateObject var viewModel = ViewModel(service:ApiService())
    
    var profile : Person
    
    @State private var email: String = ""
    @State private var company: String = ""
    @State private var activity: String = ""
    
    @State private var present = false
    @State private var alertTitle = "Loading"
    
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "person.circle")
                .resizable()
                .frame(width:150, height: 150)
                .multilineTextAlignment(.center)
                .padding(.top,30)
                .padding(.bottom,10)
                
            
            HStack(alignment: .center){
                Text(profile.firstname)
                    .font(.system(size: 45))
                    .bold()
                Text(profile.lastname)
                    .font(.system(size: 45))
                    .bold()
            }
            .padding(.top,40)
            .padding(.bottom,30)
            
                VStack{
                    HStack(alignment: .top){
                        
                        //Image(systemName: "envelope.circle")
                        Image(systemName: "at")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:60, height: 60)
                            .foregroundColor(.blue)
                        
                        VStack (alignment: .leading){
                            Text("Email")
                                .font(.system(size: 18))
                                .foregroundStyle(.gray)
                                .bold()
                            
                            TextField(
                                profile.email,
                                text : $email
                            )
                            .onAppear {
                                email = profile.email
                                    }
                            .font(.system(size: 25))
                            
                        }
                        .padding(.leading)
                        
                        
                    }
                    .padding(.bottom,20)
                    .padding(.leading)
                    
                    
                    
                    HStack(alignment: .center){
                        //person.3
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:60, height: 60)
                            .foregroundColor(.blue)
                        
                        VStack (alignment: .leading){
                            Text("Entreprise  ")
                                .font(.system(size: 18))
                                .bold()
                                .foregroundStyle(.gray)
                            TextField(profile.company,text: $company)
                            .onAppear {company = profile.company}
                            .font(.system(size: 25))
                        }
                        .padding(.leading)
                        
                    }
                    .padding(.bottom,20)
                    .padding(.leading)
                    
                    
                    HStack(alignment: .center){
                        Image(systemName: "bookmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:50, height: 50)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading){
                            Text("Domaine")
                                .font(.system(size: 18))
                                .bold()
                                .foregroundStyle(.gray)
                            TextField(profile.activity, text:$activity)
                                .onAppear {activity = profile.activity}
                                .font(.system(size: 25))
                        }
                        .padding(.leading)
                        
                    }
                    .padding(.bottom,70)
                    .padding(.leading)
                    
                    Button("Appliquer les modification"){
                        var updateData = profile
                        updateData.email = email
                        updateData.company = company
                        updateData.activity = activity
                        present = true
                        
                        Task {
                            await viewModel.updatePersons(for: updateData)
                            switch (viewModel.state) {
                            case .success(_):
                                present = false
                            case .failed(_):
                                present = false
                            default:
                                break
                            }
                        }
                    }
                    .padding(.bottom,10)
                    .padding(.top,10)
                    .padding(.trailing,5)
                    .padding(.leading,5)
                    .buttonStyle(.borderedProminent)
                    .alert("loading",isPresented: $present) {
                    }
                    
                }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(profile: Person(id_person: 1, firstname: "Bruno", lastname: "Charles", email: "bru@gmail.com", company: "Apple", activity: "Développeur", is_placed: true))
    }
}
