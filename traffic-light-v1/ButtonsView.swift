//
//  ButtonsView.swift
//  traffic-light-v1
//
//  Created by Dominik Ď. on 13/06/2022.
//

import SwiftUI

struct ButtonsView: View {
    @State private var PowerButtonDisabled:Bool = true

    var body: some View {
        HStack (spacing: 26) {
            Button(action: {
                // code
            }, label: {
                Image(systemName: "power")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            PowerButtonDisabled.toggle()
                        }
                    }
                    .foregroundColor(PowerButtonDisabled ? .black : .green)
                    .scaleEffect(PowerButtonDisabled ? 1.0 : 0.75)
            })
            
            Button(action : {
                // code
            }, label: {
                Image(systemName: "moon.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            })
            .disabled(PowerButtonDisabled)

            Button(action : {
                // code
            }, label: {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            })
            .disabled(PowerButtonDisabled)
        }
    }
}

struct ButtonsUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
