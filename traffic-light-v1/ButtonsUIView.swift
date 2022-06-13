//
//  ButtonsUIView.swift
//  traffic-light-v1
//
//  Created by Dominik Ď. on 13/06/2022.
//

import SwiftUI

struct ButtonsUIView: View {
    
    @State private var buttonDisabled:Bool = true

    var body: some View {
        HStack {
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
            Button(action : {
                // code
            }, label: {
                Image(systemName: "moon.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(buttonDisabled ? .gray.opacity(0.25) : .black)
                    .padding(.horizontal, 18.0)
            })
            .disabled(buttonDisabled)

            Button(action : {
                // code
            }, label: {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(buttonDisabled ? .gray.opacity(0.25) : .black)
            })
            .disabled(buttonDisabled)
        }
    }
}

struct ButtonsUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsUIView()
    }
}
