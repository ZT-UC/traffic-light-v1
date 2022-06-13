//
//  LightUIView.swift
//  traffic-light-v1
//
//  Created by Dominik Ď. on 13/06/2022.
//

import SwiftUI

struct LightUIView: View {
    var body: some View {
        Circle()
            .fill(.gray)
            .opacity(0.25)
            .frame(width: 100, height: 100)
            .overlay(Circle()
                .trim(from: 0.53, to: 0.97)
                        .stroke(.gray, lineWidth: 8))
            .padding(.top, 12.0)
    }
}

struct LightUIView_Previews: PreviewProvider {
    static var previews: some View {
        LightUIView()
    }
}
