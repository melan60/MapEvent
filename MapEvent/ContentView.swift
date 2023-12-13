//
//  ContentView.swift
//  MapEvent
//
//  Created by benoit melanie on 29/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
            BottomSheetView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
