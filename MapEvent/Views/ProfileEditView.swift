//
//  ProfileEditView.swift
//  MapEvent
//
//  Created by beaudru messaline on 20/12/2023.
//

import SwiftUI

struct ProfileEditView: View {
    var profile : Person
    @State private var email: String = ""
    @State private var company: String = ""
    @State private var activity: String = ""
    
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
                    .padding(.bottom,150)
                    .padding(.leading)
                    
                    Button("Appliquer les modification"){
                        
                    }
                    
                }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(profile: Person(id_person: 1, firstname: "firstnamet", lastname: "namet", email: "emailt", company: "companyt", activity: "activityt", is_placed: false))
    }
}
