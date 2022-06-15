//
//  LightsUIView.swift
//  traffic-light-v1
//
//  Created by Dominik Ď. on 13/06/2022.
//

import SwiftUI

// Timer here is just for testing stuff

struct LightsUIView: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    
    var body: some View {
        VStack() {
            ForEach(0..<3) { index in
                LightUIView()
            }
            Text("\(count) second(s) since the Timer started").onReceive(timer) { input in
                self.count += 1
            }
        }
    }
}

struct LightUIView: View {
    var body: some View {
        Circle()
            .fill(.gray)
            .opacity(0.25)
            .frame(width: 100, height: 100)
            .overlay(Circle()
                .trim(from: 0.53, to: 0.97)
                        .stroke(.gray, lineWidth: 8))
                        .shadow(radius: 10)
            .padding(.top, 12.0)
    }
}

struct LightsUIView_Previews: PreviewProvider {
    static var previews: some View {
        LightsUIView()
    }
}
