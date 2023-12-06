//
//  test.swift
//  MapEvent
//
//  Created by benoit melanie on 04/12/2023.
//

import SwiftUI

struct test: View {
    var lessons = [Lesson(id:"1"), Lesson(id:"2"), Lesson(id:"3"), Lesson(id:"4"), Lesson(id:"5"), Lesson(id:"6"), Lesson(id:"7"), Lesson(id:"8"), Lesson(id:"9")]

    var body: some View {
        NavigationView(){
            Form {
                List(lessons){ lesson in
                    LessonButton(lesson: lesson)
                }
            }
        }
    }
}

struct LessonButton:View{
    @State var showSheet = false
    var lesson:Lesson

    var body: some View {
        Button(action:{self.showSheet = true}){
            Text(lesson.name)
        }.sheet(isPresented: $showSheet){
            NavigationView {
                VStack {
                    Text("My First Sheet")
                    NavigationLink(destination: Text("reached")){
                        Text("My Second Sheet")
                    }
                }
            }
            
        }
    }
}


struct Lesson: Identifiable{
    var id:String
    var name: String{
        "Lesson \(self.id)"
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
