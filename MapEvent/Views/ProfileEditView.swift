//
//  ProfileEditView.swift
//  MapEvent
//
//  Created by beaudru messaline on 20/12/2023.
//

import SwiftUI

struct ProfileEditView: View {
    var profile : Person
    @State private var givenName: String = ""
    @State private var email: String = ""
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
            
            
            VStack(alignment: .leading) {
                HStack(alignment: .top){
                    
                    //Image(systemName: "envelope.circle")
                    Image(systemName: "at")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:60, height: 60)
                        .foregroundColor(.blue)
                    
                    VStack{
                        Text("Email ")
                            .font(.system(size: 18))
                            .foregroundStyle(.gray)
                            .bold()
                            
                        TextField(
                            profile.email,
                            text : $email
                        )
                        .font(.system(size: 25))
                            
                    }
                    .padding(.leading)
                    
                    
                }
                .padding(.bottom,20)
                
                    
                
                HStack(alignment: .center){
                    //person.3
                    Image(systemName: "house")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:60, height: 60)
                        .foregroundColor(.blue)
                    
                    VStack{
                        Text("Entreprise  ")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundStyle(.gray)
                        Text(profile.company)
                            .font(.system(size: 25))
                    }
                    .padding(.leading)
                    
                }
                .padding(.bottom,20)
                
            
                HStack(alignment: .center){
                    Image(systemName: "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50, height: 50)
                        .foregroundColor(.blue)
                    
                    VStack{
                        Text("Domaine")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundStyle(.gray)
                        Text(profile.activity)
                            .font(.system(size: 25))
                    }
                    .padding(.leading)
                    
                }
                .padding(.bottom,150)
             
            }
            
            
            
           
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(profile: Person(id_person: 1, firstname: "firstname", lastname: "name", email: "email", company: "company", activity: "activity", is_placed: false))
    }
}
