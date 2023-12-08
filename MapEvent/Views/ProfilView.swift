//
//  ProfilView.swift
//  MapEvent
//
//  Created by benoit melanie on 04/12/2023.
//

import SwiftUI

struct ProfilView: View {
    var profile : Person

    
    var body: some View {
        VStack{
            Image(systemName: "person.circle")
                .resizable()
                .frame(width:150, height: 150)
                .multilineTextAlignment(.center)
                
            
            HStack(alignment: .center){
                Text(profile.firstname)
                    .font(.system(size: 45))
                    .bold()
                Text(profile.lastname)
                    .font(.system(size: 45))
                    .bold()
            }
            Spacer()
            
                HStack(alignment: .center){
                    Text("Email : ")
                        .font(.system(size: 25))
                        .bold()
                        
                    Text(profile.email)
                        .font(.system(size: 25))
                }
                .padding(.bottom,20)
                
                
                HStack(alignment: .center){
                    Text("Company : ")
                        .font(.system(size: 25))
                        .bold()
                    Text(profile.company)
                        .font(.system(size: 25))
                }
                .padding(.bottom,20)
            
            HStack(alignment: .center){
                    Text("Activity : ")
                        .font(.system(size: 25))
                        .bold()
                    Text(profile.activity)
                        .font(.system(size: 25))
                }
            
            
            Spacer()
        }
        
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView(profile: Person(id_person: 1, firstname: "firstname", lastname: "name", email: "email", company: "company", activity: "activity", is_placed: false))
    }
}
