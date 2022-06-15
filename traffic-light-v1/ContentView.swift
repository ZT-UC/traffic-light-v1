//
//  ContentView.swift
//  traffic-light-v1
//
//  Created by Dominik Ď. on 13/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
                LightsView()
            Spacer()
                ButtonsView()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
