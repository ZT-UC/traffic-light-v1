//
//  ButtonUIView.swift
//  traffic-light-v1
//
//  Created by Dominik Ď. on 13/06/2022.
//

import SwiftUI

// Need to create generic button for ButtonUIView
// use forEarch in it and then customize it

struct ButtonUIView: View {
    @State private var buttonDisabled:Bool = true

    var body: some View {
        Button(action: {
            // code
        }, label: {
            Image(systemName: "power")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(buttonDisabled ? .black : .green)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        buttonDisabled.toggle()
                    }
                }
                .scaleEffect(buttonDisabled ? 1.0 : 0.75)
        })
    }
}

struct ButtonUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonUIView()
    }
}
